//
//  VariableBlurDirection.swift
//  SheetKit
//
//  Created by Kamil Szpak on 16/07/2025.
//

import SwiftUI
#if canImport(UIKit) && !os(watchOS)
import UIKit

open class UIBackdropView: UIView {

  open override class var layerClass: AnyClass {
    NSClassFromString("CABackdropLayer") ?? CALayer.self
  }
}

public struct Backdrop: UIViewRepresentable {

  public init() {}

  public func makeUIView(context: Context) -> UIBackdropView {
    UIBackdropView()
  }

  public func updateUIView(_ uiView: UIBackdropView, context: Context) {}
}
#endif

public struct Blur: View {
    
    public var radius: CGFloat
    public var opaque: Bool
    
    public init(radius: CGFloat = 5.0, opaque: Bool = true) {
        self.radius = radius
        self.opaque = opaque
    }
    
    public var body: some View {
        ZStack{
            #if os(visionOS) || os(macOS)
            Rectangle()
                .fill(.bar)
                .padding(.bottom, -25)
                .mask {
                    VStack(spacing: 0) {
                        LinearGradient(
                            colors: [
                                Color.black.opacity(1),
                                Color.black.opacity(1),
                                Color.black.opacity(0),
                            ],
                            startPoint: .bottom,
                            endPoint: .top
                        )
                        Rectangle()
                    }
                }
                .ignoresSafeArea()
            
            #elseif canImport(UIKit) && !os(watchOS)
            Backdrop()
                .blur(radius: radius, opaque: false)
                .padding(.bottom, -25)
                .mask {
                    VStack(spacing: 0) {
                        LinearGradient(
                            colors: [
                                Color.black.opacity(1),
                                Color.black.opacity(0.8),
                                Color.black.opacity(0.8),
                                Color.black.opacity(0),
                            ],
                            startPoint: .bottom,
                            endPoint: .top
                        )
                        Rectangle()
                    }
                }
                .ignoresSafeArea()
            Backdrop()
                .blur(radius: radius, opaque: false)
                .padding(.bottom, -25)
                .mask {
                    VStack(spacing: 0) {
                        LinearGradient(
                            colors: [
                                Color.black.opacity(1),
                                Color.black.opacity(1),
                                Color.black.opacity(0.25),
                                Color.black.opacity(0),
                            ],
                            startPoint: .bottom,
                            endPoint: .top
                        )
                        Rectangle()
                    }
                }
                .ignoresSafeArea()
            #endif
        }
    }
}

