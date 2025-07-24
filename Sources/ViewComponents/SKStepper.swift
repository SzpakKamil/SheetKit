//
//  
//  SheetKit
//
//  Created by Kamil Szpak on 10/07/2025.
//

import SwiftUI

public extension SKStepper{
    struct Data{
        var title: String
        var textForValue: (S) -> String
        var value: Binding<S>
        var range: ClosedRange<S>
        var step: S.Stride
        var backgroundColor: Color?
        var cornerRadius: CGFloat?
        
        public init(title: String, value: Binding<S>, range: ClosedRange<S>, step: S.Stride = 1, backgroundColor: Color? = nil, cornerRadius: CGFloat? = nil, textForValue: @escaping (S) -> String) {
            self.title = title
            self.textForValue = textForValue
            self.step = step
            self.value = value
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
            self.range = range
        }
    }
}

public struct SKStepper<S: Strideable>: View, SKComponent {

    @Environment(\.colorScheme) var colorScheme
    public let type: SKComponentType = .field
    var data: SKStepper.Data
    var autoBackgroundColor: Color{
        if let backgroundColor = data.backgroundColor{
            return backgroundColor
        }else{
            if colorScheme == .dark{
                return Color(red: 0.1647058824, green: 0.1647058824, blue: 0.1764705882)
            }else{
                return .white
            }
        }
    }
    public var body: some View {
        HStack(spacing: 0){
            Text("\(data.title): \(data.textForValue(data.value.wrappedValue))")
                .contentTransition(.numericText())
                .animation(.smooth, value: data.value.wrappedValue)
            Spacer()
            #if os(tvOS)
            HStack(spacing: 8){
                Button("Increment", systemImage: "plus") {
                    let newValue = data.value.wrappedValue.advanced(by: data.step)
                    data.value.wrappedValue = min(newValue, data.range.upperBound)
                }
                .buttonRepeatBehavior(.enabled)
                .disabled(data.value.wrappedValue >= data.range.upperBound)
                .foregroundStyle(.primary)
                .buttonBorderShape(.circle)
                .accessibilityLabel("Increment \(data.title)")
                Button("Decrement", systemImage: "minus") {
                    let newValue = data.value.wrappedValue.advanced(by: -data.step)
                    data.value.wrappedValue = max(newValue, data.range.lowerBound)
                }
                .buttonRepeatBehavior(.enabled)
                .disabled(data.value.wrappedValue <= data.range.lowerBound)
                .foregroundStyle(.primary)
                .buttonBorderShape(.circle)
                .accessibilityLabel("Decrement \(data.title)")
            }
            #else
            Stepper("", value: data.value, in: data.range, step: data.step)
            #endif
        }
        #if os(iOS)
        .if{ content in
            if #available(iOS 26.0, *){
                content
                    .padding(.leading)
                    .padding(.trailing, 8)
                    .padding(.vertical, 8)
                    .background(autoBackgroundColor)
                    .if {content in
                        if let cornerRadius = data.cornerRadius{
                            content
                                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                        }else{
                            content
                                .clipShape( .capsule)
                        }
                    }
            }else{
                content
                    .padding(.leading)
                    .padding(.trailing, 6)
                    .padding(.vertical, 6)
                    .background(autoBackgroundColor)
                    .if {content in
                        if let cornerRadius = data.cornerRadius{
                            content
                                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                        }else{
                            content
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }
                    }
            }
        }
        #elseif os(tvOS)
        .padding(.vertical, 5)
        .padding(.leading, 25)
        .padding(.trailing, 18)
        .background((colorScheme == .dark ? Color.black : .white).opacity(0.9))
        .clipShape(.capsule)
        #endif
    }
    
    public init(data: SKStepper.Data) {
        self.data = data
    }
    
    public init(title: String, value: Binding<S>, step: S.Stride = 1, range: ClosedRange<S>, textForValue: @escaping (S) -> String = { s in "\(s)" }) {
        self.data = .init(title: title, value: value, range: range, step: step, textForValue: textForValue)
    }
}


#if DEBUG
private struct PreviewViewSKButton: View {
    @State private var value = 0
    var body: some View{
        SKStepper(title: "Test", value: $value, range: 0...100){ value in
            if value == 0{
                return "Zero"
            }else{
                return "\(value)"
            }
        }
        #if os(iOS)
        .backgroundColor(.red)
        #endif
    }
}

#Preview {
    PreviewViewSKButton()
}
#endif
