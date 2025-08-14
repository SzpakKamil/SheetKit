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
        var range: ClosedRange<S>?
        var step: S.Stride
        
        public init(title: String, value: Binding<S>, range: ClosedRange<S>? = nil, step: S.Stride = 1, textForValue: @escaping (S) -> String) {
            self.title = title
            self.textForValue = textForValue
            self.step = step
            self.value = value
            self.range = range
        }
    }
}

public struct SKStepper<S: Strideable>: View, SKComponent {
    public let type: SKComponentType = .field
    var data: SKStepper.Data
    public var body: some View {
        #if os(iOS)
        SKStepperIOS(data: data)
        #elseif os(macOS)
        SKStepperMACOS(data: data)
        #elseif os(tvOS)
        SKStepperTVOS(data: data)
        #elseif os(visionOS)
        SKStepperVISIONOS(data: data)
        #elseif os(watchOS)
        SKStepperWATCHOS(data: data)
        #else
        EmptyView()
        #endif
    }
    
    public init(data: SKStepper.Data) {
        self.data = data
    }
    
    public init(title: String, value: Binding<S>, step: S.Stride = 1, range: ClosedRange<S>?, textForValue: @escaping (S) -> String = { s in "\(s)" }) {
        self.data = .init(title: title, value: value, range: range, step: step, textForValue: textForValue)
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
