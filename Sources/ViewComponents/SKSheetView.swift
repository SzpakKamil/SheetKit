//
//  SKSheet.swift
//  SheetKit
//
//  Created by Kamil Szpak on 15/07/2025.
//

import SwiftUI

public struct SKSheetView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.skSheetDragIndicatorVisibility) var skSheetDragIndicatorVisibility
    @Environment(\.skSheetInteractiveDismissDisabled) var skSheetInteractiveDismissDisabled
    @Environment(\.skSheetStyleDents) var skSheetStyleDents
    @Environment(\.skSheetStyleDentsSelection) var skSheetStyleDentsSelection
    var pathBinding: Binding<[Int]>?
    @State private var path: [Int] = []
    @State private var shouldPresentAlert: Bool = false
    var pages: [SKPage]
    let adjustedContent: AnyView?
    public var body: some View {
        if let adjustedContent{
            adjustedContent
        }else{
            NavigationStack(path: pathBinding ?? $path){
                pageView(currentIndex: 0)
                    .navigationDestination(for: Int.self) { index in
                        pageView(currentIndex: index)
                    }
                    #if os(watchOS)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden()
                    #elseif !os(macOS) && !os(tvOS)
                    .navigationTitle(Text(verbatim: "‎ "))
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden()
                    #endif
            }
            .presentationDragIndicator(skSheetDragIndicatorVisibility)
            .if{ content in
                if let skSheetStyleDents, let skSheetStyleDentsSelection{
                    content
                        .presentationDetents(skSheetStyleDents, selection: skSheetStyleDentsSelection)
                }else if let skSheetStyleDents{
                    content
                        .presentationDetents(skSheetStyleDents)
                }else{
                    content
                }
            }
            .onDisappear{
                pathBinding?.wrappedValue = []
            }
            .interactiveDismissDisabled(skSheetInteractiveDismissDisabled)
        }
    }
    
    @ViewBuilder
    func pageView(currentIndex: Int) -> some View{
        Group{
            if pages.count > currentIndex{
                let page = pages[currentIndex]
                let isPresented: Binding<Bool> = Binding {
                    if let alert = page.data.alert{
                        alert
                        if alert.type == nil{
                            return alert.isPresented.wrappedValue
                        }else{
                            return alert.isPresented.wrappedValue && shouldPresentAlert
                        }
                    }else{
                        return false
                    }
                } set: { newValue in
                    if let alert = page.data.alert{
                        if alert.type == nil{
                            alert.isPresented.wrappedValue = newValue
                        }else{
                            shouldPresentAlert = newValue
                        }
                    }
                }

                page
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
            if !(pathBinding?.wrappedValue ?? path).isEmpty{
                ToolbarItem(placement: .navigation) {
                    SKToolbarItem(placement: .navigation) { _ in
                        SKButton(verbatim: SKTranslation.SKButton.back.value, systemImage: "chevron.backward") {
                            dismissalAction(currentIndex: currentIndex)
                        }
                    }
                }
            }
        }
        #endif
        .environment(\.skPrimaryButtonAction) {
            confirmationAction(currentIndex: currentIndex)
        }
        .environment(\.skIsFinalPage, (pathBinding?.wrappedValue ?? path).last == currentIndex)
        .environment(\.skIsShowingBackButton, !(pathBinding?.wrappedValue ?? path).isEmpty)
        .environment(\.skDismissButtonAction) {
            dismissalAction(currentIndex: currentIndex)
        }
        .environment(\.skCloseButtonAction) {
            closeAction(currentIndex: currentIndex)
        }
    }
    
    public func confirmationAction(currentIndex: Int){
        if pages.count > 0{
            let page = pages[currentIndex]
            if let alert = page.data.alert, alert.type == .confirmation, alert.isPresented.wrappedValue{
                shouldPresentAlert = true
            }else{
                if let pathBinding{
                    if pages.count > currentIndex + 1{
                        pathBinding.wrappedValue.append(currentIndex + 1)
                    }else{
                        pathBinding.wrappedValue.removeAll(); dismiss()
                    }
                }else{
                    if pages.count > currentIndex + 1{
                        path.append(currentIndex + 1)
                    }else{
                        path.removeAll(); dismiss()
                    }
                }
            }
        }
    }
    
    public func dismissalAction(currentIndex: Int){
        if pages.count > 0{
            let page = pages[currentIndex]
            if let alert = page.data.alert, alert.type == .dismissal, alert.isPresented.wrappedValue{
                shouldPresentAlert = true
            }else{
                if let pathBinding{
                    if !pathBinding.wrappedValue.isEmpty{
                        pathBinding.wrappedValue.removeLast()
                    }else{
                        dismiss()
                    }
                }else{
                    if !path.isEmpty{
                        path.removeLast()
                    }else{
                        dismiss()
                    }
                }
            }
        }else{
            dismiss()
        }
    }
    
    public func closeAction(currentIndex: Int){
        if pages.count > 0{
            let page = pages[currentIndex]
            if let alert = page.data.alert, alert.type == .dismissal, alert.isPresented.wrappedValue{
                shouldPresentAlert = true
            }else{
                if let pathBinding{
                    pathBinding.wrappedValue.removeAll()
                }else{
                    path.removeAll()
                }
                dismiss()
            }
        }else{
            dismiss()
        }
    }

    
    public init(@SKSheetBuilder pages: () -> [SKPage]) {
        self.pages = pages()
        self.adjustedContent = nil
    }
    
    public init(pages: [SKPage]) {
        self.pages = pages
        self.adjustedContent = nil
    }
    
    public init(pages: [SKPage], @ViewBuilder content: @escaping () -> some View) {
        self.pages = pages
        self.adjustedContent = AnyView(content())
    }
    
    func skSheetPathBinding(_ path: Binding<[Int]>?) -> SKSheetView{
        var copy = self
        copy.pathBinding = path
        return copy
    }
}

#Preview {
    SKSheetView{
        SKPage{
            SKTitle("Test")
            SKTitle("Test")
            SKTitle("Test")
            SKTitle("Test")
            SKTitle("Test")
            SKTitle("Test")
            SKTitle("Test")
            SKTitle("Test")
            SKTitle("Test")
            SKTitle("Test")
            SKTitle("Test")
            SKTitle("Test")
            SKTitle("Test")
            SKTitle("Test")
        }
    }
}


#if os(iOS)

@_documentation(visibility: internal)
extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    @_documentation(visibility: internal)
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    @_documentation(visibility: internal)
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }

    // To make it works also with ScrollView
    @_documentation(visibility: internal)
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}
#endif
