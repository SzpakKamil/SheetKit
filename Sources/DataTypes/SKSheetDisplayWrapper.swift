//
//  SKSheetDisplayWrapper.swift
//  SheetKit
//
//  Created by Kamil Szpak on 17/08/2025.
//

import SwiftUI

@Observable
class SKSheetDisplayWrapper: Identifiable, Hashable, Equatable, Codable {
    var id: String
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
    var customViewSheet: (any SKSheetable)?
    var view: AnyView?
    var sheet: (any SKSheet)?
    
    static func == (lhs: SKSheetDisplayWrapper, rhs: SKSheetDisplayWrapper) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case shouldBePresented
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(String.self, forKey: .id)
        self.shouldBePresented = false
        self.shouldBePresented = try values.decode(Bool.self, forKey: .shouldBePresented)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(shouldBePresented, forKey: .shouldBePresented)
    }
    
    init(sheet: any SKSheetable) {
        self.id = sheet.id
        if let sheet = sheet as? SKSheet{
            self.sheet = sheet
        }else{
            self.customViewSheet = sheet
        }
    }
    
    init(id: String, @ViewBuilder view: @escaping () -> some View){
        self.id = id
        self.view = AnyView(view())
    }
}
