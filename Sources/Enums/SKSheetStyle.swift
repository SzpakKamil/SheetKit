//
//  SKSheetStyle.swift
//  Savely
//
//  Created by Kamil Szpak on 14/07/2025.
//

import Foundation

public enum SKSheetStyle{
    case prominent
    case compact
    case `default`
    
    public var frameWidth: CGFloat{
        if #available(macOS 26.0, *){
            switch self{
            case .prominent: return 350
            case .compact: return 330
            case .`default`: return 400
            }
        }else{
            switch self{
            case .prominent: return 350
            case .compact: return 330
            case .`default`: return 379
            }
        }
    }
    
    public var windowWidth: CGFloat{
        if #available(macOS 26.0, *){
            switch self{
            case .prominent: return 480
            case .compact: return 500
            case .`default`: return 750
            }
        }else{
            switch self{
            case .prominent: return 480
            case .compact: return 480
            case .`default`: return 520
            }
        }
    }
    public var height: CGFloat{
        if #available(macOS 26.0, *){
            switch self{
            case .prominent: return 600
            case .compact: return 600
            case .`default`: return 700
            }
        }else{
            switch self{
            case .prominent: return 500
            case .compact: return 580
            case .`default`: return 660
            }
        }

    }
}
