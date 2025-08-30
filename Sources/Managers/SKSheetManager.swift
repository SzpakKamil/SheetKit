//
//  SKSheetManager.swift
//  SheetKit
//
//  Created by Kamil Szpak on 15/08/2025.
//

import SwiftUI

@Observable
public class SKSheetManager{
    
    var sheets: [SKSheetDisplayWrapper] = []
    
    var paths: [String: [Int]] = [:]
    
    var openedSheets: [SKSheetDisplayWrapper]{
        return sheets.filter{ $0.shouldBePresented }
    }
    var handoffableSheets: [SKSheetDisplayWrapper]{
        return sheets.filter{ $0.sheet?.options.first{ $0.id == 0}?.value1 as? Bool == true && $0.shouldBePresented }
    }

    var allSheetsCount: Int{
        sheets.count
    }
    
    
    var changesCount: Int = 0
    
    var openedSheetsCount: Int{
        openedSheets.count
    }
    
    
    func getPathBinding(forID id: String) -> Binding<[Int]>{
        if let pathValue = paths[id]{
            return Binding {
                pathValue
            } set: { newValue in
                self.paths[id] = newValue
            }
            
        }else{
            paths[id] = []
            return Binding {
                self.paths[id] ?? []
            } set: { newValue in
                self.paths[id] = newValue
            }
        }
    }
    
    public func add(sheet: any SKSheetable.Type){
        if let index = sheets.firstIndex(where: { $0.id == sheet.init().id }) {
            sheets.remove(at: index)
        }
        let wrapped = SKSheetDisplayWrapper(sheet: sheet.init())
        changesCount += 1
        sheets.append(wrapped)
    }
    
    public func add(id: String, @ViewBuilder view: @escaping () -> some View){
        if let index = sheets.firstIndex(where: { $0.id == id }) {
            sheets.remove(at: index)
        }
        let wrapped = SKSheetDisplayWrapper(id: id, view: view)
        changesCount += 1
        sheets.append(wrapped)
    }
    
    public func show(sheet: any SKSheetable){
        if let index = sheets.firstIndex(where: { $0.id == sheet.id }) {
            sheets.remove(at: index)
        }
        var wrapped = SKSheetDisplayWrapper(sheet: sheet)
        changesCount += 1
        wrapped.shouldBePresented = true
        sheets.append(wrapped)
    }
    public func show(sheet: any SKSheetable.Type){
        if let index = sheets.firstIndex(where: { $0.id == sheet.init().id }) {
            sheets.remove(at: index)
        }
        var wrapped = SKSheetDisplayWrapper(sheet: sheet.init())
        changesCount += 1
        wrapped.shouldBePresented = true
        sheets.append(wrapped)
    }
    
    public func show(id: String, @ViewBuilder view: @escaping () -> some View){
        if let index = sheets.firstIndex(where: { $0.id == id }) {
            sheets.remove(at: index)
        }
        var wrapped = SKSheetDisplayWrapper(id: id, view: view)
        changesCount += 1
        wrapped.shouldBePresented = true
        sheets.append(wrapped)
    }
    
    func handleContinuingHandoff(activity: NSUserActivity){
        if let decodedOpenedSheetsIDs = activity.userInfo?["OpenedSheetsIDs"] as? [String],
           let paths = activity.userInfo?["SheetPaths"] as? [String: [Int]],
           let additionalData = activity.userInfo?["SheetsData"] as? [String: [AnyHashable: Any]] {
            for openedSheetID in decodedOpenedSheetsIDs {
                let sheet = getSheet(forId: openedSheetID)
                sheet?.shouldBePresented = true
                sheet?.sheet?.loadData(sentData: additionalData[openedSheetID] ?? [:])
                sheet?.customViewSheet?.loadData(sentData: additionalData[openedSheetID] ?? [:])
                self.paths = paths
            }
        }
    }
    func startUserActivity(activity: NSUserActivity){
        activity.title = "Continue Sheet"
        activity.isEligibleForHandoff = true
        activity.isEligibleForSearch = true
        activity.targetContentIdentifier = "SKSheet\(handoffableSheets.last?.id ?? "ID")ContinuationActivity"
        
        do {
            let sheetsHandoffableIDs: [String] = handoffableSheets.map{ $0.id }
            let sheetsData: [String: [AnyHashable: Any]] = handoffableSheets.reduce(into: [:]) { dict, wrapper in
                if let id = wrapper.sheet?.id, let data = wrapper.sheet?.sentData() {
                    dict[id] = data
                }else if let id = wrapper.customViewSheet?.id, let data = wrapper.customViewSheet?.sentData() {
                    dict[id] = data
                }
            }
            try activity.addUserInfoEntries(from: ["OpenedSheetsIDs": sheetsHandoffableIDs])
            try activity.addUserInfoEntries(from: ["SheetPaths": paths])
            try activity.addUserInfoEntries(from: ["SheetsData": sheetsData])
        } catch {
            print("Failed to transfer opened sheets for user activity: \(error)")
        }
    }
    
    public func show(id: String){
        if let index = sheets.firstIndex(where: { $0.id == id }) {
            sheets[index].shouldBePresented = true
            changesCount += 1
        }
    }
    
    public func showAllSheets(){
        sheets.indices.forEach{ index in
            sheets[index].shouldBePresented = true
        }
        changesCount += 1
    }
    
    public func hideAllSheets(dismissAction: (() -> Void)? = nil){
        sheets.indices.forEach{ index in
            sheets[index].isPresented = false
        }
        changesCount += 1
        dismissAction?()
    }
    
    public func removeAllSheets(dismissAction: (() -> Void)? = nil){
        sheets.indices.forEach{ index in
            sheets[index].isPresented = false
        }
        changesCount += 1
        DispatchQueue.main.asyncAfter(deadline: .now()){
            self.sheets.removeAll()
            dismissAction?()
        }
    }
    public func hide(id: String, removeAfter: Bool = false, dismissAction: (() -> Void)? = nil){
        if let index = sheets.firstIndex(where: { $0.id == id }) {
            sheets[index].isPresented = false
            if removeAfter{
                DispatchQueue.main.asyncAfter(deadline: .now()){
                    self.sheets.remove(at: index)
                    dismissAction?()
                }
            }else{
                dismissAction?()
            }
            changesCount += 1
        }
        
    }
    
    public func hide(sheet: any SKSheetable, removeAfter: Bool = false, dismissAction: (() -> Void)? = nil){
        if let index = sheets.firstIndex(where: { $0.id == sheet.id }) {
            sheets[index].isPresented = false
            if removeAfter{
                DispatchQueue.main.asyncAfter(deadline: .now()){
                    self.sheets.remove(at: index)
                    dismissAction?()
                }
            }else{
                dismissAction?()
            }
            changesCount += 1
        }
    }
    public func hide(sheet: any SKSheetable.Type, removeAfter: Bool = false, dismissAction: (() -> Void)? = nil){
        if let index = sheets.firstIndex(where: { $0.id == sheet.init().id }) {
            sheets[index].isPresented = false
            if removeAfter{
                DispatchQueue.main.asyncAfter(deadline: .now()){
                    self.sheets.remove(at: index)
                    dismissAction?()
                }
            }else{
                dismissAction?()
            }
            changesCount += 1
        }
    }
    
    public func isValid(index: Int) -> Bool{
        index >= 0 && index < allSheetsCount
    }
    
    func getSheet(forIndex index: Int) -> SKSheetDisplayWrapper?{
        guard isValid(index: index) else { return nil }
        return sheets[index]
    }
    func getSheet(forId id: String) -> SKSheetDisplayWrapper?{
        guard isValid(id: id) else { return nil }
        return sheets.first{ $0.id == id }
    }
    func getOpenedSheet(forIndex index: Int) -> SKSheetDisplayWrapper?{
        guard isValidOpened(index: index) else { return nil }
        return openedSheets[index]
    }
    func getOpenedSheet(forID id: String) -> SKSheetDisplayWrapper?{
        guard isValid(id: id) else { return nil }
        return openedSheets.first{ $0.id == id }
    }
    
    public func isValidOpened(index: Int) -> Bool{
        index >= 0 && index < openedSheetsCount
    }
    
    public func isValid(id: String) -> Bool{
        sheets.contains(where: { $0.id == id })
    }
    
    public func isValidOpened(id: String) -> Bool{
        openedSheets.contains(where: { $0.id == id })
    }
    
    public init(){}
    
    public init(sheets: any SKSheetable.Type...) {
        self.sheets = sheets.map{ $0.init()}.map{ SKSheetDisplayWrapper(sheet: $0)}
    }
    public init(sheets: [any SKSheetable.Type]) {
        self.sheets = sheets.map{ $0.init()}.map{ SKSheetDisplayWrapper(sheet: $0)}
    }
}
