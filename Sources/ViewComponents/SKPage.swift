//
//  SKPage.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

@resultBuilder
public struct SKPageBuilder {
    public static func buildBlock(_ components: any SKComponent...) -> [any SKComponent] {
        components
    }
    
    public static func buildArray(_ components: [[any SKComponent]]) -> [any SKComponent] {
        components.flatMap { $0 }
    }
    
    public static func buildOptional(_ component: [any SKComponent]?) -> [any SKComponent] {
        component ?? []
    }
    
    public static func buildEither(first component: [any SKComponent]) -> [any SKComponent] {
        component
    }
    
    public static func buildEither(second component: [any SKComponent]) -> [any SKComponent] {
        component
    }
}


public extension SKPage{
    struct Alert{
        let title: String
        let description: String
        let content: AnyView
        let type: AlertType
        var isPresented: Binding<Bool>

        public init(isPresented: Binding<Bool>, title: String, description: String, type: AlertType = .manual, @ViewBuilder content: @escaping () -> some View) {
            self.isPresented = isPresented
            self.title = title
            self.description = description
            self.type = type
            self.content = AnyView(content())
        }
    }
    struct Data{
        var content: [any SKComponent]
        var alert: Alert?
        let toolbar: SKToolbar
        var backgroundStyle: BackgroundStyle?
        var alignment: HorizontalAlignment?
        var accentColor: Color?
        
        public init(backgroundStyle: BackgroundStyle? = nil, accentColor: Color? = nil, alignment: HorizontalAlignment? = nil, alert: Alert? = nil, @SKPageBuilder content: () -> [any SKComponent], @SKToolbarBuilder toolbar: () -> [SKToolbarItem]) {
            self.content = content()
            self.accentColor = accentColor
            self.backgroundStyle = backgroundStyle
            self.alignment = alignment
            self.toolbar = SKToolbar(content: toolbar)
            self.alert = alert
        }
    }

    enum BackgroundStyle{
        case custom(light: Color, dark: Color)
        case list
        case form
    }
    
    enum AlertType{
        case confirmation
        case dismissal
        case manual
    }
}

public struct SKPage: View{
    @Environment(\.accentColor) var accentColor
    @Environment(\.sheetSize) var sheetSize
    @Environment(\.closeButtonHidden) var closeButtonHidden
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @State private var presentAlert: Bool = false
    @State private var toolbarFactor: CGFloat = 0
    @State private var toolbarHeight: CGFloat = 0
    var data: SKPage.Data
    var autoStyle: SKPage.BackgroundStyle{
        if let backgroundStyle = data.backgroundStyle{
            return backgroundStyle
        }else{
            if data.content.contains(where: { $0.type == .field}){
                return .form
            }else{
                return .list
            }
        }
    }
    
    var autoSheetSize: SKSheetSize{
        if let sheetSize{
            return sheetSize
        }else if #available(macOS 26.0, *){
            return .large
        }else{
            return .large
        }
    }
    public var body: some View {
        ZStack(alignment: .top){
            SKScrollView(backgroundStyle: autoStyle, toolbar: data.toolbar) {
                ForEach(data.content.indices, id: \.self){index in
                    data.content[index].erasedContent()
                }
#if os(macOS)
                .frame(width: autoSheetSize.frameWidth)
                .frame(maxWidth: .infinity)
#endif
            }
            #if os(macOS)
            if sheetSize == .medium{
                HStack{
                    let navigationAction = data.toolbar.data.buttons.filter{
                        $0.data.placement == .navigation
                    }
                    if navigationAction.isEmpty{
                        SKToolbarItem(placement: .navigation) { action in
                            if #available(iOS 26.0, *){
                                Button{
                                    action()
                                }label: {
                                    Image(systemName: "chevron.backward")
                                        .imageScale(.large)
                                        .frame(width: 10, height: 10)
                                        .accessibilityHidden(true)
                                }
                                .accessibilityLabel("Back")
                            }else{
                                Button("Back") {
                                    action()
                                }
                            }
                        }
                    }else{
                        ForEach(navigationAction) { button in
                            button
                        }
                    }
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.top, 20)
            }
            #endif
        }
        .environment(\.alignment, data.alignment)
        .environment(\.accentColor, data.accentColor ?? accentColor)
        #if !os(macOS) && !os(tvOS)
        .toolbar {
            let navigationButtons = data.toolbar.data.buttons.filter{ $0.data.placement == .navigation}
            ToolbarItem(placement: .topBarTrailing) {
                if navigationButtons.isEmpty && !closeButtonHidden{
                    if #available(iOS 26.0, *){
                        SKToolbarItem(placement: .navigation) { action in
                            Button("Close", systemImage: "xmark") {
                                action()
                            }
                        }
                    }else{
                        SKToolbarItem(placement: .navigation) { action in
                            Button("Close") {
                                action()
                            }
                        }
                    }
                }else{
                    ForEach(navigationButtons) { button in
                        button
                    }
                }
            }
        }
        #elseif !os(tvOS)
        .frame(width: autoSheetSize.windowWidth, height: autoSheetSize.height)
        #endif
            
    }
    
    public init(@SKPageBuilder content: () -> [any SKComponent], @SKToolbarBuilder toolbar: () -> [SKToolbarItem]) {
        self.data = .init(content: content, toolbar: toolbar)
    }
}

struct PreviewSKPageContent: View{
    @State private var isPresentingAlert: Bool = false
    @State private var name = ""
    var body: some View{
#if os(iOS)
        Text("")
            .sheet(isPresented: .constant(true)) {
                NavigationView{
                    SKPage {
                        SKHeaderImage(systemName: "apple.intelligence")
                        SKTitle("ChatGPT")
                        SKDescription("When iPhone works with ChatGPT, it can do more for you.")
                        SKTextField("TextField", text: $name)
                        SKTextField("Test", text: $name)
                        SKTextField("Test", text: $name)
                        SKTextField("Test", text: $name)
                        SKTextField("Test", text: $name)
                        SKTextField("Test", text: $name)
//                        SKHighlight(title: "Integrates with Siri", description: "More in depth Siri answers and insights about photos and documents.", systemName: "siri")
//                        SKHighlight(title: "More Visual Intelligence", description: "Learn about the world around you and get more information about what you see. ", systemName: "text.bubble")
//                        SKHighlight(title: "Compose Text in Writing Tools", description: "Create text or images from just a description.", systemName: "apple.writing.tools")
//                        SKHighlight(title: "New Styles in Image Playground", description: "Play with an expanded range of visual styles for image creation.", systemName: "apple.image.playground")
//                        SKHighlight(title: "Works with a ChatGPT Account", description: "Accounts are optional. With a ChatGPT subscription, iPhone can use the most powerful capabilities more often.", systemName: "person.crop.circle")
                    } toolbar: {
                        SKToolbarItem(placement: .primary) { action in
                            Button("Continue") {
                                action()
                            }
                        }
                        SKToolbarItem(placement: .secondary) { _ in
                            Button("Test") {
                                isPresentingAlert.toggle()
                            }
                        }
                        SKToolbarItem(placement: .note) { _ in
                            Button("When you enable ChatGPT, you agree to OpenAI's Terms of Use...") {
                                
                            }
                        }
                    }
                    .alert(isPresented: $isPresentingAlert, title: "This is example Alert", description: "It is a test for alert modifiers") {
                        Button("Destructive", role: .destructive){}
                        Button("Dismiss", role: .cancel){}
                    }
                    .style(.form)
                }
            }
    #else
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
            SKToolbarItem(placement: .secondary) { _ in
                Button("Test") {
                    isPresentingAlert.toggle()
                }
            }
            SKToolbarItem(placement: .note) { _ in
                Button("When you enable ChatGPT, you agree to OpenAI's Terms of Use...") {
                    
                }
            }
        }
        .alert(isPresented: $isPresentingAlert, title: "This is example Alert", description: "It is a test for alert modifiers") {
            Button("Destructive", role: .destructive){}
            Button("Dismiss", role: .cancel){}
        }
    #endif
    }
}

#Preview {
    PreviewSKPageContent()
}
