//
//  SKSheetManager.swift
//  SheetKit
//
//  Created by Kamil Szpak on 15/08/2025.
//

import SwiftUI

@Observable
public class SKSheetManager: Codable{
    @MainActor
    var sheets: [SKSheetDisplayWrapper] = []
    
    var paths: [String: [Int]] = [:]
    @MainActor
    var openedSheets: [SKSheetDisplayWrapper]{
        return sheets.filter{ $0.shouldBePresented }
    }
    
    @MainActor
    var handoffableSheets: [SKSheetDisplayWrapper]{
        return sheets.filter{ $0.sheet?.options.first{ $0.id == 0}?.value1 as? Bool == true && $0.shouldBePresented }
    }
    
    @MainActor
    public var allSheetsCount: Int{
        sheets.count
    }
    
    @MainActor
    var changesCount: Int = 0
    @MainActor
    public var openedSheetsCount: Int{
        openedSheets.count
    }
    
    
    @MainActor public func getPathBinding(forID id: String) -> Binding<[Int]>{
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
    
    @MainActor public func add(sheet: SKSheet){
        if let index = sheets.firstIndex(where: { $0.id == sheet.id }) {
            sheets.remove(at: index)
        }
        let wrapped = SKSheetDisplayWrapper(sheet: sheet)
        changesCount += 1
        sheets.append(wrapped)
    }
    
    @MainActor public func add(sheet: SKCustomViewSheet){
        if let index = sheets.firstIndex(where: { $0.id == sheet.id }) {
            sheets.remove(at: index)
        }
        let wrapped = SKSheetDisplayWrapper(customViewSheet: sheet)
        changesCount += 1
        sheets.append(wrapped)
    }
    
    @MainActor public func add(id: String, @ViewBuilder view: @escaping () -> some View){
        if let index = sheets.firstIndex(where: { $0.id == id }) {
            sheets.remove(at: index)
        }
        let wrapped = SKSheetDisplayWrapper(id: id, view: view)
        changesCount += 1
        sheets.append(wrapped)
    }
    
    @MainActor public func show(sheet: SKSheet){
        if let index = sheets.firstIndex(where: { $0.id == sheet.id }) {
            sheets.remove(at: index)
        }
        var wrapped = SKSheetDisplayWrapper(sheet: sheet)
        changesCount += 1
        wrapped.shouldBePresented = true
        sheets.append(wrapped)
    }
    @MainActor public func show(sheet: SKCustomViewSheet){
        if let index = sheets.firstIndex(where: { $0.id == sheet.id }) {
            sheets.remove(at: index)
        }
        var wrapped = SKSheetDisplayWrapper(customViewSheet: sheet)
        changesCount += 1
        wrapped.shouldBePresented = true
        sheets.append(wrapped)
    }
    
    @MainActor public func show(id: String, @ViewBuilder view: @escaping () -> some View){
        if let index = sheets.firstIndex(where: { $0.id == id }) {
            sheets.remove(at: index)
        }
        var wrapped = SKSheetDisplayWrapper(id: id, view: view)
        changesCount += 1
        wrapped.shouldBePresented = true
        sheets.append(wrapped)
    }
    
    @MainActor func handleContinuingHandoff(activity: NSUserActivity){
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
    @MainActor func startUserActivity(activity: NSUserActivity){
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
    
    @MainActor public func show(id: String){
        if let index = sheets.firstIndex(where: { $0.id == id }) {
            sheets[index].shouldBePresented = true
            changesCount += 1
        }
    }
    
    @MainActor public func showAllSheets(){
        sheets.indices.forEach{ index in
            sheets[index].shouldBePresented = true
        }
        changesCount += 1
    }
    
    @MainActor public func hideAllSheets(dismissAction: (() -> Void)? = nil){
        sheets.indices.forEach{ index in
            sheets[index].isPresented = false
        }
        changesCount += 1
        dismissAction?()
    }
    
    @MainActor public func removeAllSheets(dismissAction: (() -> Void)? = nil){
        sheets.indices.forEach{ index in
            sheets[index].isPresented = false
        }
        changesCount += 1
        DispatchQueue.main.asyncAfter(deadline: .now()){
            self.sheets.removeAll()
            dismissAction?()
        }
    }
    @MainActor public func hide(id: String, removeAfter: Bool = false, dismissAction: (() -> Void)? = nil){
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
    
    @MainActor public func hide(sheet: SKSheet, removeAfter: Bool = false, dismissAction: (() -> Void)? = nil){
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
    
    @MainActor public func hide(sheet: SKCustomViewSheet, removeAfter: Bool = false, dismissAction: (() -> Void)? = nil){
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
    
    @MainActor public func isValid(index: Int) -> Bool{
        index >= 0 && index < allSheetsCount
    }
    
    @MainActor public func getSheet(forIndex index: Int) -> SKSheetDisplayWrapper?{
        guard isValid(index: index) else { return nil }
        return sheets[index]
    }
    @MainActor public func getSheet(forId id: String) -> SKSheetDisplayWrapper?{
        guard isValid(id: id) else { return nil }
        return sheets.first{ $0.id == id }
    }
    @MainActor public func getOpenedSheet(forIndex index: Int) -> SKSheetDisplayWrapper?{
        guard isValidOpened(index: index) else { return nil }
        return openedSheets[index]
    }
    @MainActor public func getOpenedSheet(forID id: String) -> SKSheetDisplayWrapper?{
        guard isValid(id: id) else { return nil }
        return openedSheets.first{ $0.id == id }
    }
    
    @MainActor public func isValidOpened(index: Int) -> Bool{
        index >= 0 && index < openedSheetsCount
    }
    
    @MainActor public func isValid(id: String) -> Bool{
        sheets.contains(where: { $0.id == id })
    }
    
    @MainActor public func isValidOpened(id: String) -> Bool{
        openedSheets.contains(where: { $0.id == id })
    }
    
    public enum CodingKeys: CodingKey {
        case sheets
    }
    
    // Custom decoding: keep existing views when decoding sheets.
    @MainActor
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let decodedSheets = try values.decode([SKSheetDisplayWrapper].self, forKey: .sheets)
        self.sheets = decodedSheets
    }
    @MainActor
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sheets, forKey: .sheets)
    }
    
    public init(){}
}

