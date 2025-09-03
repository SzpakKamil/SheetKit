//
//  SKSheetable.swift
//  SheetKit
//
//  Created by Kamil Szpak on 26/08/2025.
//

import SwiftUI

@MainActor
public protocol SKSheetable: View{
    var id: String { get }
    var options: Set<SKSheetOptions> { get }
    
    func sentData() -> [AnyHashable: Any]
    func loadData(sentData: [AnyHashable: Any])
    func disapearAction()
    init()
}

public extension SKSheetable{
    func sentData() -> [AnyHashable: Any]{ [:]}
    func loadData(sentData: [AnyHashable: Any]){}
    func disapearAction(){}
}

extension SKSheetable{
    func adjustedContent() -> some View{
        self.onDisappear{disapearAction()}
    }
}

