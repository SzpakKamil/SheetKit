//
//  SKSheetManager.swift
//  SheetKit
//
//  Created by Kamil Szpak on 15/08/2025.
//

import SwiftUI

@Observable
public class SKSheetManager{
    private(set) var sheets: [SKSheetDisplayWrapper] = []
    var openedSheets: [SKSheetDisplayWrapper]{
        sheets.filter{ $0.shouldBePresented }
    }
    
    public var allSheetsCount: Int{
        sheets.count
    }
    
    public var openedSheetsCount: Int{
        openedSheets.count
    }
    
    @MainActor public func add(sheet: SKSheet){
        if sheets.firstIndex{ $0.id == sheet.id } == nil{
            let wrapped = SKSheetDisplayWrapper(sheet: sheet)
            sheets.append(wrapped)
        }
    }
    
    @MainActor public func add(id: String, @ViewBuilder view: () -> some View){
        if sheets.firstIndex{ $0.id == id } == nil{
            let wrapped = SKSheetDisplayWrapper(id: id, view: view)
            sheets.append(wrapped)
        }
    }
    
    @MainActor public func show(sheet: SKSheet){
        if let index = sheets.firstIndex(where: { $0.id == sheet.id }) {
            sheets.remove(at: index)
        }
        let wrapped = SKSheetDisplayWrapper(sheet: sheet)
        wrapped.shouldBePresented = true
        sheets.append(wrapped)
    }
    
    @MainActor public func show(id: String, @ViewBuilder view: () -> some View){
        if let index = sheets.firstIndex(where: { $0.id == id }) {
            sheets[index].shouldBePresented = true
        } else {
            let wrapped = SKSheetDisplayWrapper(id: id, view: view)
            wrapped.shouldBePresented = true
            sheets.append(wrapped)
        }
    }
    
    @MainActor public func show(id: String){
        if let index = sheets.firstIndex(where: { $0.id == id }) {
            sheets[index].shouldBePresented = true
        }
    }
    
    @MainActor public func showAllSheets(){
        sheets.forEach{
            $0.shouldBePresented = true
        }
    }
    
    @MainActor public func hideAllSheets(dismissAction: (() -> Void)? = nil){
        sheets.forEach{
            $0.isPresentedBinding.wrappedValue = false
        }
        dismissAction?()
    }
    
    @MainActor public func removeAllSheets(dismissAction: (() -> Void)? = nil){
        sheets.forEach{
            $0.isPresentedBinding.wrappedValue = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now()){
            self.sheets.removeAll()
            dismissAction?()
        }
    }
    @MainActor public func hide(id: String, removeAfter: Bool = false, dismissAction: (() -> Void)? = nil){
        if let index = sheets.firstIndex(where: { $0.id == id }) {
            sheets[index].isPresentedBinding.wrappedValue = false
            if removeAfter{
                DispatchQueue.main.asyncAfter(deadline: .now()){
                    self.sheets.remove(at: index)
                    dismissAction?()
                }
            }else{
                dismissAction?()
            }
        }

    }
    
    @MainActor public func hide(sheet: SKSheet, removeAfter: Bool = false, dismissAction: (() -> Void)? = nil){
        if let index = sheets.firstIndex(where: { $0.id == sheet.id }) {
            sheets[index].isPresentedBinding.wrappedValue = false
            if removeAfter{
                DispatchQueue.main.asyncAfter(deadline: .now()){
                    self.sheets.remove(at: index)
                    dismissAction?()
                }
            }else{
                dismissAction?()
            }
            
        }

    }
    
    @MainActor public func isValid(index: Int) -> Bool{
        index >= 0 && index < allSheetsCount
    }
    
    @MainActor public func getSheet(forIndex index: Int) -> SKSheetDisplayWrapper?{
        guard isValid(index: index) else { return nil }
        return sheets[index]
    }
    @MainActor public func getOpenedSheet(forIndex index: Int) -> SKSheetDisplayWrapper?{
        guard isValidOpened(index: index) else { return nil }
        return openedSheets[index]
    }
    
    @MainActor public func isValidOpened(index: Int) -> Bool{
        index >= 0 && index < openedSheetsCount
    }
    
    @MainActor public func isValid(id: Int) -> Bool{
        sheets.contains(where: { $0.id == "\(id)" })
    }
    
    @MainActor public func isValidOpened(id: Int) -> Bool{
        openedSheets.contains(where: { $0.id == "\(id)" })
    }
    
    public init(){}
}

@Observable
public class SKSheetDisplayWrapper: Identifiable, Hashable, Equatable{
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
    var view: AnyView
    
    public static func == (lhs: SKSheetDisplayWrapper, rhs: SKSheetDisplayWrapper) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    init(sheet: SKSheet) {
        print("Sheet Opened")
        self.id = sheet.id
        self.view = AnyView(sheet)
    }
    
    init(id: String, @ViewBuilder view: () -> some View) {
        self.id = id
        self.view = AnyView(view())
    }
    
}

