//
//  SKSheetType.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

public protocol SKCustomViewSheet: View{
    var id: String { get }
    var options: Set<SKSheetOptions> { get }
    func sentData() -> [AnyHashable: Any]
    func loadData(sentData: [AnyHashable: Any])
}

public extension SKCustomViewSheet{
    func sentData() -> [AnyHashable: Any]{ [:]}
    func loadData(sentData: [AnyHashable: Any]){}
}
