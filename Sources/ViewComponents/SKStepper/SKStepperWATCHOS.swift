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
    var data: SKStepper<S>.Data
    var type: SKComponentType = .field
    @State private var isUsingStepper: Bool = false
    @State private var tempValue: S
    
    var autoBackgroundColor: Color{
        if let backgroundColor = data.backgroundColor{
            return backgroundColor
        }else{
            return .primary.opacity(0.1)
        }
    }
    
    public var body: some View {
        Button {
            isUsingStepper = true
            tempValue = data.value.wrappedValue
        }label:{
            VStack{
                Text(data.title)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(data.textForValue(data.value.wrappedValue))
                    .lineLimit(1)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 17)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            .background(autoBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: data.cornerRadius ?? 100, style: .continuous))
        }
        .buttonStyle(.plain)
        .fullScreenCover(isPresented: $isUsingStepper) {
            NavigationStack{
                VStack{
                    Stepper(data.textForValue(data.value.wrappedValue), value: data.value, in: data.range)
                    HStack{
                        Button("Submit", role: .cancel) {
                            isUsingStepper = false
                            data.value.wrappedValue = tempValue
                        }
                        Button("Reset", role: .destructive) {
                            tempValue = data.value.wrappedValue
                        }
                    }
                }
                .navigationTitle("Adjust Value")
            }
        }
    }
    
    public init(data: SKStepper<S>.Data) {
        self.data = data
        self.tempValue = data.value.wrappedValue
    }
}

#if DEBUG
#Preview {
    PreviewViewSKStepper()
}
#endif
#endif
