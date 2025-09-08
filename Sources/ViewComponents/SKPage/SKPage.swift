//
//  SKPage.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

extension SKPage{
    public struct Data{
        var content: [any SKComponent]
        var alert: SKPage.Alert?
        let toolbar: SKToolbar
        var backgroundStyle: SKPage.BackgroundStyle?
        var pageStyle: SKPage.Style?
        
        public init(backgroundStyle: SKPage.BackgroundStyle? = nil, style: SKPage.Style? = nil, alert: SKPage.Alert? = nil, @SKPageBuilder content: () -> [any SKComponent], @SKToolbarBuilder toolbar: () -> [SKToolbarItem]) {
            self.content = content()
            self.backgroundStyle = backgroundStyle
            self.toolbar = SKToolbar(items: toolbar)
            self.pageStyle = style
            self.alert = alert
        }
        public init(backgroundStyle: SKPage.BackgroundStyle? = nil, style: SKPage.Style? = nil, alert: SKPage.Alert? = nil, @SKPageBuilder content: () -> [any SKComponent], toolbarItems: [SKToolbarItem]) {
            self.content = content()
            self.backgroundStyle = backgroundStyle
            self.toolbar = SKToolbar(items: toolbarItems)
            self.pageStyle = style
            self.alert = alert
        }
    }
    
    public enum BackgroundStyle{
        case custom(light: Color, dark: Color)
        case list
        case form
        case plain
    }
    
    public enum Style{
        case plain
        case `default`
    }
    
    public struct Alert{
        let title: String
        let description: String
        let content: AnyView
        let type: AlertType?
        var isPresented: Binding<Bool>
        
        public init(isPresented: Binding<Bool>, title: String, description: String, type: AlertType? = nil, @ViewBuilder content: @escaping () -> some View) {
            self.isPresented = isPresented
            self.title = title
            self.description = description
            self.type = type
            self.content = AnyView(content())
        }
        
        public enum AlertType{
            case confirmation
            case dismissal
        }
    }
}
public struct SKPage: View{
    public var data: SKPage.Data
    public var adjustedContent: AnyView?
    public var body: some View {
        if let adjustedContent{
            adjustedContent
        }else{
            #if os(iOS)
            SKPageIOS(data: data)
            #elseif os(macOS)
            SKPageMACOS(data: data)
            #elseif os(tvOS)
            SKPageTVOS(data: data)
            #elseif os(visionOS)
            SKPageVISIONOS(data: data)
            #elseif os(watchOS)
            SKPageWATCHOS(data: data)
            #else
            EmptyView()
            #endif
        }
    }
    
    public init(@SKPageBuilder content: () -> [any SKComponent], @SKToolbarBuilder toolbar: () -> [SKToolbarItem]) {
        self.data = .init(content: content, toolbar: toolbar)
    }
    
    public init(@SKPageBuilder content: () -> [any SKComponent]) {
        self.data = .init(content: content, toolbar: {})
    }
    public init(data: SKPage.Data) {
        self.data = data
    }
    public init(data: SKPage.Data, @ViewBuilder content: @escaping () -> some View) {
        self.data = data
        self.adjustedContent = AnyView(content())
    }
}

#if DEBUG
struct PreviewSKPageContent: View{
    @State private var isPresentingAlert: Bool = false
    @State private var name = ""
    var body: some View{
        Text("")
            .sheet(isPresented: .constant(true)) {
                NavigationView{
                    SKPage {
                        SKHeaderImage(systemName: "apple.intelligence")
                        SKTitle("ChatGPT")
                        SKDescription("When iPhone works with ChatGPT, it can do more for you.")
                        SKHighlight(title: "Integrates with Siri", description: "More in depth Siri answers and insights about photos and documents.", systemName: "siri")
                        SKHighlight(title: "More Visual Intelligence", description: "Learn about the world around you and get more information about what you see. ", systemName: "text.bubble")
                        SKHighlight(title: "Compose Text in Writing Tools", description: "Create text or images from just a description.", systemName: "apple.writing.tools")
                        SKHighlight(title: "New Styles in Image Playground", description: "Play with an expanded range of visual styles for image creation.", systemName: "apple.image.playground")
                        SKHighlight(title: "Works with a ChatGPT Account", description: "Accounts are optional. With a ChatGPT subscription, iPhone can use the most powerful capabilities more often.", systemName: "person.crop.circle")
                    } toolbar: {
                        SKToolbarItem(placement: .primary) { action in
                            SKButton("Continue") {action()}
                        }
                        SKToolbarItem(placement: .secondary) { _ in
                            SKButton("Test") {isPresentingAlert.toggle()}
                        }
                        SKToolbarItem(placement: .note) { _ in
                            SKButton("When you enable ChatGPT, you agree to OpenAI's Terms of Use...") {}
                        }
                    }
                    .skAlert(isPresented: $isPresentingAlert, title: "This is example Alert", description: "It is a test for alert modifiers") {
                        Button("Destructive", role: .destructive){}
                        Button("Dismiss", role: .cancel){}
                    }
                }
            }
    }
}

#Preview {
    PreviewSKPageContent()
}
#endif
