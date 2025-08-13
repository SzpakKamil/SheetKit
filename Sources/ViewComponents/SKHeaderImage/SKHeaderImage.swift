import SwiftUI

public extension SKHeaderImage {
    struct Data {
        // Store systemName for system images to enable hashing and equality
        let image: Image
        var color: Color?
        var variant: Variant
        var renderingMode: SKRenderingMode
        var size: SKHeaderImage.Size?
        var weight: Font.Weight
        var verticalPadding: VerticalPadding?
        var alignment: HorizontalAlignment?
    
        public init(image: Image, color: Color? = nil, variant: Variant = .none, renderingMode: SKRenderingMode = .monochrome, verticalPadding: VerticalPadding? = nil, weight: Font.Weight = .regular, alignment: HorizontalAlignment? = nil, size: SKHeaderImage.Size? = nil) {
            self.image = image
            self.color = color
            self.variant = variant
            self.renderingMode = renderingMode
            self.verticalPadding = verticalPadding
            self.alignment = alignment
            self.size = size
            self.weight = weight
        }
    }
    
    enum VerticalPadding: Hashable {
        case none
        case small
        case medium
        case large
        case custom(CGFloat)
        
        var rawValue: CGFloat {
            switch self {
            case .large:
                return 30
            case .medium:
                return 20
            case .small:
                return 10
            case .none:
                return 0
            case .custom(let value):
                return value
            }
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(self.rawValue)
        }
    }
    
    enum Size: Hashable {
        case large
        case medium
        case small
        case custom(CGFloat)
        
        var rawValue: CGFloat {
            #if os(watchOS)
            switch self {
            case .large:
                return 65
            case .medium:
                return 55
            case .small:
                return 40
            case .custom(let value):
                return value
            }
            #else
            switch self {
            case .large:
                return 100
            case .medium:
                return 85
            case .small:
                return 70
            case .custom(let value):
                return value
            }
            #endif
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(self.rawValue)
        }
    }
    
    enum Variant: CaseIterable {
        case fill
        case circle
        case none
        case rectangle
        case slash
        case square
        
        @available(iOS 15.0, macOS 12.0, *)
        func getSymbolVariant() -> SymbolVariants {
            switch self {
            case .fill:
                return .fill
            case .circle:
                return .circle
            case .none:
                return .none
            case .rectangle:
                return .rectangle
            case .slash:
                return .slash
            case .square:
                return .square
            }
        }
    }
}

public struct SKHeaderImage: SKComponent {

    public let type: SKComponentType = .header
    public var data: SKHeaderImage.Data
    
    public init(data: SKHeaderImage.Data) {
        self.data = data
    }
    
    public init(systemName: String) {
        self.data = Data(image: Image(systemName: systemName))
    }
    
    public init(image: Image) {
        self.data = Data(image: image)
    }
    
    public var body: some View {
        #if os(iOS)
        SKHeaderImageIOS(data: data)
        #elseif os(macOS)
        SKHeaderImageMACOS(data: data)
        #elseif os(tvOS)
        SKHeaderImageTVOS(data: data)
        #elseif os(visionOS)
        SKHeaderImageVISIONOS(data: data)
        #elseif os(watchOS)
        SKHeaderImageWATCHOS(data: data)
        #else
        EmptyView()
        #endif
    }

}

#if DEBUG
private struct PreviewViewSKHeaderImage: View {
    @State private var systemName = "trash"
    @State private var variant = SKHeaderImage.Variant.none
    @State private var renderingMode = SKRenderingMode.monochrome
    @State private var size = SKHeaderImage.Size.medium
    @State private var weight = Font.Weight.regular
    @State private var color: Color = .blue
    @State private var padding: SKHeaderImage.VerticalPadding? = nil
    
    var body: some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            List {
                SKHeaderImage(systemName: systemName)
                    .tint(color)
                    .size(size)
                    .weight(weight)
                    .verticalPadding(padding)
                    .renderingMode(renderingMode)
                    .variant(variant)
                Section {
                    Picker("SystemName", selection: $systemName) {
                        ForEach(["trash", "wifi", "airpods.max", "music.note", "signature"], id: \.self) { name in
                            Text(name.capitalized)
                        }
                    }
                    Picker("Vertical Padding", selection: $padding) {
                        ForEach([SKHeaderImage.VerticalPadding.large, .medium, .small, .custom(20), nil], id: \.self) { padding in
                            Text(String("\(padding)"))
                                .tag(padding)
                        }
                    }
                    Picker("Weight", selection: $weight) {
                        ForEach([Font.Weight.black, .heavy, .bold, .semibold, .medium, .regular, .light, .ultraLight], id: \.self) { weight in
                            switch weight {
                            case .black:
                                Text("Black")
                            case .heavy:
                                Text("Heavy")
                            case .bold:
                                Text("Bold")
                            case .semibold:
                                Text("Semibold")
                            case .medium:
                                Text("Medium")
                            case .regular:
                                Text("Regular")
                            case .light:
                                Text("Light")
                            case .ultraLight:
                                Text("Ultra Light")
                            default:
                                Text("Default")
                            }
                        }
                    }
                    Picker("Variant", selection: $variant) {
                        ForEach(SKHeaderImage.Variant.allCases, id: \.self) { variant in
                            Text(String("\(variant)"))
                        }
                    }
                    Picker("Size", selection: $size) {
                        ForEach([SKHeaderImage.Size.large, .medium, .small, .custom(10)], id: \.self) { variant in
                            Text(String("\(variant)"))
                        }
                    }
                    Picker("RenderingMode", selection: $renderingMode) {
                        ForEach([SKRenderingMode.hierarchical, SKRenderingMode.monochrome], id: \.self) { mode in
                            Text(String("\(mode)"))
                        }
                    }
                }
            }
            #if os(macOS)
            .listStyle(.sidebar)
            #endif
            .navigationTitle("SKHeaderImage")
        } else {
            Text("")
        }
    }
}

#Preview {
    PreviewViewSKHeaderImage()
}
#endif
