//
//  SKSheet.swift
//  SheetKit
//
//  Created by Kamil Szpak on 15/07/2025.
//

import SwiftUI

@resultBuilder
public struct SKSheetBuilder {
    public static func buildBlock(_ components: SKPage...) -> [SKPage] {
        return components
    }
}


extension SKSheet{
    struct Data {
        var pages: [SKPage]
        var dragIndicatorVisibility: Visibility
        var allowsInteractiveDismissal: Bool = true
        var accentColor: Color?
        var alignment: HorizontalAlignment?
        var sheetSize: SKSheetSize?
        var presentationDents: Set<PresentationDetent>
        
        public init(allowsInteractiveDismissal: Bool = true, sheetSize: SKSheetSize? = nil, accentColor: Color? = nil, dragIndicatorVisibility: Visibility = .hidden, alignment: HorizontalAlignment? = nil, presentationDents: Set<PresentationDetent> = [.large], @SKSheetBuilder pages: () -> [SKPage]) {
            self.allowsInteractiveDismissal = allowsInteractiveDismissal
            self.presentationDents = presentationDents
            self.sheetSize = sheetSize
            self.alignment = alignment
            self.dragIndicatorVisibility = dragIndicatorVisibility
            self.pages = pages()
        }
    }
}
public struct SKSheet: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.accentColor) var accentColor
    @State private var path: [Int] = []
    @State private var shouldPresentAlert: Bool = false
    var selectedPresentationDent: Binding<PresentationDetent>
    var autoAccentColor: Color{
        if let accentColor = data.accentColor{
            return accentColor
        }else{
            #if os(tvOS)
            return .blue
            #else
            return .accentColor
            #endif
        }
    }
    var data: Data
    public var body: some View {
        NavigationStack(path: $path){
            pageView(currentIndex: 0)
                .navigationDestination(for: Int.self) { index in
                    pageView(currentIndex: index)
                }
        }
        .presentationDragIndicator(data.dragIndicatorVisibility)
        .presentationDetents(data.presentationDents, selection: selectedPresentationDent)
        .interactiveDismissDisabled(!data.allowsInteractiveDismissal)
        .environment(\.alignment, data.alignment)
        .environment(\.accentColor, autoAccentColor)
        .environment(\.sheetSize, data.sheetSize)
    }
    
    @ViewBuilder
    func defaultView() -> some View {
        if data.pages.isEmpty{
            EmptyView()
        }else{
            data.pages[0]
                
        }
    }
    
    @ViewBuilder
    func pageView(currentIndex: Int) -> some View{
        Group{
            if data.pages.count > currentIndex{
                let page = data.pages[currentIndex]
                let isPresented: Binding<Bool> = Binding {
                    if let alert = page.data.alert{
                        if alert.type == .manual{
                            return alert.isPresented.wrappedValue
                        }else{
                            return alert.isPresented.wrappedValue && shouldPresentAlert
                        }
                    }else{
                        return false
                    }
                } set: { newValue in
                    if let alert = page.data.alert{
                        if alert.type == .manual{
                            alert.isPresented.wrappedValue = newValue
                        }else{
                            shouldPresentAlert = newValue
                        }
                    }
                }

                page
                    .if{ content in
                        if data.pages.count > currentIndex + 1{
                            content
                                .environment(\.primaryAction) {
                                    confirmationAction(currentIndex: currentIndex)
                                }
                        }else{
                            content
                                .environment(\.primaryAction) {
                                    confirmationAction(currentIndex: currentIndex)
                                }
                        }
                    }
                    .environment(\.navigationAction) {
                        dismissalAction(currentIndex: currentIndex)
                    }
                    .alert(page.data.alert?.title ?? "", isPresented: isPresented) {
                        page.data.alert?.content
                    } message: {
                        Text(page.data.alert?.description ?? "")
                    }
            }else{
                EmptyView()
            }
        }
        .navigationBarBackButtonHidden()
        #if !os(macOS) && !os(tvOS) && !os(watchOS)
        .toolbar{
            if !path.isEmpty{
                ToolbarItem(placement: .navigation) {
                    SKToolbarItem(placement: .navigation) { action in
                        if #available(iOS 26.0, *){
                            Button("Back", systemImage: "chevron.backward") {
                                path.removeLast()
                            }
                        }else{
                            Button {
                                path.removeLast()
                            }label:{
                                HStack(spacing: 5){
                                    Image(systemName: "chevron.backward")
                                    Text("Back")
                                }
                            }
                        }
                    }
                }
            }
        }
        #endif
    }
    
    public func confirmationAction(currentIndex: Int){
        let page = data.pages[currentIndex]
        if let alert = page.data.alert, alert.type == .confirmation, alert.isPresented.wrappedValue{
            shouldPresentAlert = true
        }else{
            if data.pages.count > currentIndex + 1{
                path.append(currentIndex + 1)
            }else{
                path.removeAll(); dismiss()
            }
        }
    }
    
    public func dismissalAction(currentIndex: Int){
        let page = data.pages[currentIndex]
        if let alert = page.data.alert, alert.type == .dismissal, alert.isPresented.wrappedValue{
            shouldPresentAlert = true
        }else{
            if !path.isEmpty{
                path.removeLast()
            }else{
                path.removeAll()
                dismiss()
            }
        }
    }

    
    public init(@SKSheetBuilder pages: () -> [SKPage]) {
        self.data = .init(pages: pages)
        self.selectedPresentationDent = .constant(self.data.presentationDents.first ?? .large)
    }
}

#Preview {
    SKSheet{
        
    }
}


#if os(iOS)
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }

    // To make it works also with ScrollView
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}
#endif
