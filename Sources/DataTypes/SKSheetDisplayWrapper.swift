//
//  SKSheetDisplayWrapper.swift
//  SheetKit
//
//  Created by Kamil Szpak on 17/08/2025.
//

import SwiftUI

@Observable
public class SKSheetDisplayWrapper: Identifiable, Hashable, Equatable, Codable {
    public var id: String
    var isPresented: Bool = false
    var shouldBePresented: Bool = false

    var isPresentedBinding: Binding<Bool>{
        Binding {
            self.isPresented && self.shouldBePresented
        } set: { newValue in
            self.isPresented = newValue
            if !newValue{
                DispatchQueue.main.asyncAfter(deadline: .now()){
                    self.shouldBePresented = newValue
                }
            }
        }
    }
    var customViewSheet: SKCustomViewSheet?
    var view: AnyView?
    var sheet: SKSheet?
    
    public static func == (lhs: SKSheetDisplayWrapper, rhs: SKSheetDisplayWrapper) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    public enum CodingKeys: String, CodingKey {
        case id
        case shouldBePresented
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(String.self, forKey: .id)
        self.shouldBePresented = false
        self.shouldBePresented = try values.decode(Bool.self, forKey: .shouldBePresented)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(shouldBePresented, forKey: .shouldBePresented)
    }
    
    init(sheet: SKSheet) {
        self.id = sheet.id
        self.sheet = sheet
    }
    init(customViewSheet: SKCustomViewSheet){
        self.id = customViewSheet.id
        self.customViewSheet = customViewSheet
    }
    
    init(id: String, @ViewBuilder view: @escaping () -> some View){
        self.id = id
        self.view = AnyView(view())
    }
}
