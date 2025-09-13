import SwiftUI

extension SKHeaderImage {
    struct Data {
        // Store systemName for system images to enable hashing and equality
        let image: Image
        var variant: Variant
        var renderingMode: SKRenderingMode
        var size: SKHeaderImage.Size?
        var weight: Font.Weight
        var verticalPadding: VerticalPadding?
    
        init(image: Image, variant: Variant = .none, renderingMode: SKRenderingMode = .monochrome, verticalPadding: VerticalPadding? = nil, weight: Font.Weight = .regular, size: SKHeaderImage.Size? = nil) {
            self.image = image
            self.variant = variant
            self.renderingMode = renderingMode
            self.verticalPadding = verticalPadding
            self.size = size
            self.weight = weight
        }
    }
    
    public enum VerticalPadding: Hashable {
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
    
    public enum Size: Hashable {
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
    
    public enum Variant: CaseIterable {
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
    var data: SKHeaderImage.Data
    
    init(data: SKHeaderImage.Data) {
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
