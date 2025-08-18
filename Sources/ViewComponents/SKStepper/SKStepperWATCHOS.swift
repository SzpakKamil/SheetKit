//
//  SKStepperWATCHOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 01/08/2025.
//

import SwiftUI
#if os(watchOS)
struct SKStepperWATCHOS<S: Strideable>: View, SKComponent {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    @Environment(\.skRowShape) var skRowShape
    @Binding var value: S
    var data: SKStepper<S>.Data
    var type: SKComponentType = .field
    @State private var isUsingStepper: Bool = false
    @State private var tempValue: S
    
    var autoBackgroundColor: Color{
        if let skRowBackgroundColor{
            return skRowBackgroundColor
        }else{
            return .primary.opacity(0.1)
        }
    }
    
    public var body: some View {
        Button {
            isUsingStepper = true
            tempValue = value
        }label:{
            VStack{
                Text(data.title)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(data.textForValue(value))
                    .lineLimit(1)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 17)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            .background(autoBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 100, style: .continuous))
        }
        .buttonStyle(.plain)
        .fullScreenCover(isPresented: $isUsingStepper) {
            NavigationStack{
                VStack{
                    if let range = data.range{
                        Stepper(data.textForValue(value), value: $value, in: range)
                    }else{
                        Stepper(data.textForValue(value), value: $value)
                    }
                    
                    HStack{
                        Button("Submit", role: .cancel) {
                            isUsingStepper = false
                            value = tempValue
                        }
                        Button("Reset", role: .destructive) {
                            tempValue = value
                        }
                    }
                }
                .navigationTitle("Adjust Value")
            }
        }
    }
    
    public init(value: Binding<S>, data: SKStepper<S>.Data) {
        self.data = data
        self._value = value
        self.tempValue = value.wrappedValue
    }
}

#if DEBUG
#Preview {
    PreviewViewSKStepper()
}
#endif
#endif
