//
//  SKPickerWATCHOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

#if os(watchOS)
struct SKPickerWATCHOS<SelectionValue: Hashable, Content: View>: View, SKComponent {
    let type: SKComponentType = .field
    @Environment(\.colorScheme) var colorScheme
    var data: SKPicker<SelectionValue, Content>.Data
    
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
    
    var menuIndicatorColor: Color{
        if let backgroundColor = data.backgroundColor{
            return backgroundColor
        }else if colorScheme == .dark{
            return Color(red: 0.2, green: 0.2196078431, blue: 0.2274509804)
        }else{
            return Color(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647)
        }
    }
    
    var body: some View {
        #if os(tvOS)
        tvOSStyle()
        #else
        ZStack{
            #if os(visionOS)
            TextField(text: .constant(""), label: {
                Text("")
                    .padding(.vertical)
            })
                .textFieldStyle(.roundedBorder)
                .allowsHitTesting(false)
            #endif
            HStack{
                Text(data.title)
                Spacer()
                Menu{
                    #if os(macOS)
                    if let headerView = data.headerView{
                        headerView
                    }
                    #else
                    if let footerView = data.footerView{
                        footerView
                    }
                    #endif
                    _VariadicView.Tree(SKPickerOptions(selectedValue: data.selection)) {
                        data.content
                    }
                    #if os(macOS)
                    if let footerView = data.footerView{
                        footerView
                    }
                    #else
                    if let headerView = data.headerView{
                        headerView
                    }
                    #endif
                }label: {
                    HStack(spacing: 5){
                        Text(verbatim: String(describing: data.selection.wrappedValue))
                            #if os(macOS)
                            .font(.body)
                            .padding(.horizontal, 11)
                            #else
                            .font(.callout)
                            #endif
                        #if os(macOS) || os(tvOS)
                        Spacer()
                        #endif
                        Image(systemName: "chevron.up.chevron.down")
                            #if os(macOS)
                            .if{content in
                                if #available(macOS 13.0, *) {
                                    content
                                        .fontWeight(.semibold)
                                } else {
                                    content
                                }
                            }
                            .padding(.trailing, 7)
                            #endif
                            .imageScale(.small)
                    }
                    #if os(macOS)
                    .padding(.vertical, 4)
                    .background(menuIndicatorColor)
                    .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                    #elseif os(iOS)
                    .foregroundStyle(.secondary)
                    #endif
                }
                #if os(visionOS)
                .buttonStyle(.borderless)
                .buttonBorderShape(.roundedRectangle)
                #else
                .buttonStyle(.plain)
                #endif
                .tint(.primary)
            }
            #if os(iOS)
            .if{ content in
                if #available(iOS 26.0, *){
                    content
                        .padding(.horizontal)
                        .padding(.vertical, 15)
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
                        .padding(.horizontal, 19)
                        .padding(.vertical, 12)
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
            #elseif os(visionOS)
            .padding(.leading)
            #endif
        }
        #endif
    }
    @ViewBuilder
    func tvOSStyle() -> some View {
        Menu{
            if let footerView = data.footerView{
                footerView
            }
            _VariadicView.Tree(SKPickerOptions(selectedValue: data.selection)) {
                data.content
            }
            if let headerView = data.headerView{
                headerView
            }
        }label: {
            HStack(spacing: 5){
                Text(data.title)
                Spacer()
                HStack(spacing: 5){
                    Text(verbatim: String(describing: data.selection.wrappedValue))
                        .font(.callout)
                    Image(systemName: "chevron.up.chevron.down")
                        .fontWeight(.semibold)
                        .imageScale(.small)
                }
            }
            .padding(.vertical, 3)
            .padding(.leading, -7)
            .padding(.trailing, -15)

        }
        .buttonStyle(.borderedProminent)
        .tint(colorScheme == .dark ? .black : .white)
    }
    
    init(data: SKPicker<SelectionValue, Content>.Data) {
        self.data = data
    }
}

#if DEBUG
#Preview {
    PreviewViewSKPicker()
}
#endif
#endif
