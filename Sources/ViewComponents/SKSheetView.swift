//
//  SKSheet.swift
//  SheetKit
//
//  Created by Kamil Szpak on 15/07/2025.
//

import SwiftUI

@resultBuilder
public struct SKSheetBuilder {

    /// Handles zero components (empty builder block).
    public static func buildBlock() -> [SKPage] {
        return []
    }

    /// Handles a single SKPage component.
    public static func buildBlock(_ component: SKPage) -> [SKPage] {
        return [component]
    }

    /// Handles multiple SKPage components.
    public static func buildBlock(_ components: SKPage...) -> [SKPage] {
        return components
    }

    /// Handles multiple already-wrapped components (e.g. arrays from conditionals or loops).
    public static func buildBlock(_ components: [SKPage]...) -> [SKPage] {
        return components.flatMap { $0 }
    }

    /// Support for expressions (bare `SKPage` values).
    public static func buildExpression(_ expression: SKPage) -> [SKPage] {
        return [expression]
    }

    /// Support for optional SKPage arrays (e.g. from `if let`).
    public static func buildOptional(_ component: [SKPage]?) -> [SKPage] {
        return component ?? []
    }

    /// Support for `if`/`else` first branch.
    public static func buildEither(first component: [SKPage]) -> [SKPage] {
        return component
    }

    /// Support for `if`/`else` second branch.
    public static func buildEither(second component: [SKPage]) -> [SKPage] {
        return component
    }

    /// Support for loops like `for` that produce `[SKPage]`.
    public static func buildArray(_ components: [[SKPage]]) -> [SKPage] {
        return components.flatMap { $0 }
    }

    /// Support for availability checks.
    public static func buildLimitedAvailability(_ component: [SKPage]) -> [SKPage] {
        return component
    }
    
    public static func buildExpression<Data, ID>(_ forEach: SKForEach<Data, ID, Any>) -> [SKPage] where Data: RandomAccessCollection, ID: Hashable {
        forEach.pageComponents
    }
    public static func buildExpression(_ components: SKPage...) -> [SKPage] {
        return components
    }
}

public struct SKSheetData {
    var pages: [SKPage]
    
    init(@SKSheetBuilder pages: () -> [SKPage]) {
        self.pages = pages()
    }
    init(pages: [SKPage]) {
        self.pages = pages
    }
}

public struct SKSheetView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.skSheetDragIndicatorVisibility) var skSheetDragIndicatorVisibility
    @Environment(\.skSheetInteractiveDismissDisabled) var skSheetInteractiveDismissDisabled
    @Environment(\.skSheetStyleDents) var skSheetStyleDents
    @Environment(\.skSheetStyleDentsSelection) var skSheetStyleDentsSelection
    @State private var path: [Int] = []
    @State private var shouldPresentAlert: Bool = false
    public var data: SKSheetData
    let adjustedContent: AnyView?
    public var body: some View {
        if let adjustedContent{
            adjustedContent
        }else{
            NavigationStack(path: $path){
                pageView(currentIndex: 0)
                    .navigationDestination(for: Int.self) { index in
                        pageView(currentIndex: index)
                    }
                    #if os(watchOS)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden()
                    #elseif !os(macOS) && !os(tvOS)
                    .navigationTitle("‎ ")
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
            .interactiveDismissDisabled(skSheetInteractiveDismissDisabled)
        }
    }
    
    @ViewBuilder
    func pageView(currentIndex: Int) -> some View{
        Group{
            if data.pages.count > currentIndex{
                let page = data.pages[currentIndex]
                let isPresented: Binding<Bool> = Binding {
                    if let alert = page.data.alert{
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
            if !path.isEmpty{
                ToolbarItem(placement: .navigation) {
                    SKToolbarItem(placement: .navigation) { _ in
                        SKButton("Back", systemImage: "chevron.backward") {
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
        .environment(\.skIsFinalPage, path.last == currentIndex)
        .environment(\.skIsShowingBackButton, !path.isEmpty)
        .environment(\.skDismissButtonAction) {
            dismissalAction(currentIndex: currentIndex)
        }
        .environment(\.skCloseButtonAction) {
            closeAction(currentIndex: currentIndex)
        }
    }
    
    public func confirmationAction(currentIndex: Int){
        if data.pages.count > 0{
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
    }
    
    public func dismissalAction(currentIndex: Int){
        if data.pages.count > 0{
            let page = data.pages[currentIndex]
            if let alert = page.data.alert, alert.type == .dismissal, alert.isPresented.wrappedValue{
                shouldPresentAlert = true
            }else{
                if !path.isEmpty{
                    path.removeLast()
                }else{
                    dismiss()
                }
            }
        }else{
            dismiss()
        }
    }
    
    public func closeAction(currentIndex: Int){
        if data.pages.count > 0{
            let page = data.pages[currentIndex]
            if let alert = page.data.alert, alert.type == .dismissal, alert.isPresented.wrappedValue{
                shouldPresentAlert = true
            }else{
                path.removeAll()
                dismiss()
            }
        }else{
            dismiss()
        }
    }

    
    public init(@SKSheetBuilder pages: () -> [SKPage]) {
        self.data = .init(pages: pages)
        self.adjustedContent = nil
    }
    
    public init(pages: [SKPage]) {
        self.data = .init(pages: pages)
        self.adjustedContent = nil
    }
    
    public init(data: SKSheetData, @ViewBuilder content: @escaping () -> some View) {
        self.data = data
        self.adjustedContent = AnyView(content())
    }
}

#Preview {
    SKSheetView{
        
    }
}


#if os(iOS)
extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
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
