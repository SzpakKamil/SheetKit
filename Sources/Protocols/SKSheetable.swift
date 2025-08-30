//
//  SKSheetable.swift
//  SheetKit
//
//  Created by Kamil Szpak on 26/08/2025.
//

import SwiftUI

public protocol SKSheetable: View{
    var id: String { get }
    var options: Set<SKSheetOptions> { get }
    
    func sentData() -> [AnyHashable: Any]
    func loadData(sentData: [AnyHashable: Any])
    init()
}

public extension SKSheetable{
    func sentData() -> [AnyHashable: Any]{ [:]}
    func loadData(sentData: [AnyHashable: Any]){}
}
