//
//  
//  SheetKit
//
//  Created by Kamil Szpak on 10/07/2025.
//

import SwiftUI

extension SKStepper{
    struct Data{
        var title: String
        var textForValue: (S) -> String

        var range: ClosedRange<S>?
        var step: S.Stride
        
        init(title: String, range: ClosedRange<S>? = nil, step: S.Stride = 1, textForValue: @escaping (S) -> String) {
            self.title = title
            self.textForValue = textForValue
            self.step = step
            self.range = range
        }
    }
}

public struct SKStepper<S: Strideable>: View, SKComponent {
    @Binding var value: S
    public let type: SKComponentType = .field
    var data: SKStepper.Data
    public var body: some View {
        #if os(iOS)
        SKStepperIOS(value: $value, data: data)
        #elseif os(macOS)
        SKStepperMACOS(value: $value, data: data)
        #elseif os(tvOS)
        SKStepperTVOS(value: $value, data: data)
        #elseif os(visionOS)
        SKStepperVISIONOS(value: $value, data: data)
        #elseif os(watchOS)
        SKStepperWATCHOS(value: $value, data: data)
        #else
        EmptyView()
        #endif
    }
    
    public init(title: String, value: Binding<S>, step: S.Stride = 1, range: ClosedRange<S>? = nil, textForValue: @escaping (S) -> String = { s in "\(s)" }) {
        self._value = value
        self.data = .init(title: title, range: range, step: step, textForValue: textForValue)
    }
}


#if DEBUG
struct PreviewViewSKStepper: View {
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
        .skRowBackground(.red)
        #endif
    }
}

#Preview {
    PreviewViewSKStepper()
}
#endif
