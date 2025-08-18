//
//  SKSheetType.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI
import Observation

public protocol SKHandoffableSheet: SKSheet {
    associatedtype DataType: SKSheetData
    var data: DataType { get set }
}
