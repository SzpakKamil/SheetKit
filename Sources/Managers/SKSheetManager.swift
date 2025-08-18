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
    @MainActor
    var openedSheets: [SKSheetDisplayWrapper]{
        return sheets.filter{ $0.shouldBePresented }
    }
    
    @MainActor
    public var allSheetsCount: Int{
        sheets.count
    }
    
    @MainActor
    var changesCount: Int{
        openedSheetsCount + openedSheets.map{
            if let handoffable = $0.sheet as? SKHandoffableSheet {
                return handoffable.data.path.reduce(0){ $0 + $1 }
            }else {
                return 0
            }
        }.reduce(0){$0 + $1}
    }
    @MainActor
    public var openedSheetsCount: Int{
        openedSheets.count
    }
    
    @MainActor public func add(sheet: SKSheet){
        if let index = sheets.firstIndex(where: { $0.id == sheet.id }) {
            sheets.remove(at: index)
        }
        let wrapped = SKSheetDisplayWrapper(sheet: sheet)
        sheets.append(wrapped)
    }
    
    @MainActor public func add(id: String, @ViewBuilder view: @escaping () -> some View){
        if let index = sheets.firstIndex(where: { $0.id == id }) {
            sheets.remove(at: index)
        }
        let wrapped = SKSheetDisplayWrapper(id: id, view: view)
        sheets.append(wrapped)
    }
    
    @MainActor public func show(sheet: SKSheet){
        if let index = sheets.firstIndex(where: { $0.id == sheet.id }) {
            sheets.remove(at: index)
        }
        var wrapped = SKSheetDisplayWrapper(sheet: sheet)
        wrapped.shouldBePresented = true
        sheets.append(wrapped)
    }
    
    @MainActor public func show(id: String, @ViewBuilder view: @escaping () -> some View){
        if let index = sheets.firstIndex(where: { $0.id == id }) {
            sheets.remove(at: index)
        }
        var wrapped = SKSheetDisplayWrapper(id: id, view: view)
        wrapped.shouldBePresented = true
        sheets.append(wrapped)
    }
    
    @MainActor func handleContinuingHandoff(activity: NSUserActivity){
        if let userInfo = activity.userInfo,
           let sheetsData = userInfo["sheetsJSON"] as? Data {
            do {
                let decodedSheets = try JSONDecoder().decode([SKSheetDisplayWrapper].self, from: sheetsData)
                for sheet in decodedSheets {
                    let originalSheet = getSheet(forId: sheet.id)
                    if let handoffableSheet = sheet.sheet as? SKHandoffableSheet, let handoffableOriginalSheet = originalSheet?.sheet as? SKHandoffableSheet {
                        // Try to get the handoff path from userInfo
                        if let handoffPath = userInfo["ID-\(sheet.id)"] as? [Int] {
                            handoffableOriginalSheet.data.path = handoffPath
                        } else {
                            handoffableOriginalSheet.data.path = handoffableSheet.data.path
                        }
                    }
                    originalSheet?.shouldBePresented = sheet.shouldBePresented
                }
            } catch {
                print("Failed to decode sheetsJSON: \(error)")
            }
        }
    }
    @MainActor func startUserActivity(activity: NSUserActivity){
        activity.title = "Continue Sheet"
        activity.isEligibleForHandoff = true
        activity.isEligibleForSearch = true
        activity.targetContentIdentifier = "SKSheet\(openedSheets.last?.id ?? "ID")ContinuationActivity"

        do {
            let sheetsData = try JSONEncoder().encode(sheets)
            activity.addUserInfoEntries(from: ["sheetsJSON": sheetsData])
            
            // Collect ID-path mapping from opened sheets
            var pathMapping: [String: Any] = [:]
            openedSheets.compactMap { $0.sheet as? SKHandoffableSheet }.forEach {
                pathMapping["ID-\($0.id)"] = $0.data.path
            }
            if !pathMapping.isEmpty {
                activity.addUserInfoEntries(from: pathMapping)
            }
        } catch {
            print("Failed to encode sheets for user activity: \(error)")
        }
    }
    
    @MainActor public func show(id: String){
        if let index = sheets.firstIndex(where: { $0.id == id }) {
            sheets[index].shouldBePresented = true
        }
    }
    
    @MainActor public func showAllSheets(){
        sheets.indices.forEach{ index in
            sheets[index].shouldBePresented = true
        }
    }
    
    @MainActor public func hideAllSheets(dismissAction: (() -> Void)? = nil){
        sheets.indices.forEach{ index in
            sheets[index].isPresented = false
        }
        dismissAction?()
    }
    
    @MainActor public func removeAllSheets(dismissAction: (() -> Void)? = nil){
        sheets.indices.forEach{ index in
            sheets[index].isPresented = false
        }
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

