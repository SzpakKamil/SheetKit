//
//  SKSheetSize.swift
//  Savely
//
//  Created by Kamil Szpak on 14/07/2025.
//

import Foundation

public enum SKSheetSize{
   
    case small
    case medium
    case large
    
    public var frameWidth: CGFloat{
        if #available(macOS 26.0, *){
            switch self{
            case .small: return 400
            case .medium: return 330
            case .large: return 400
            }
        }else{
            switch self{
            case .small: return 400
            case .medium: return 330
            case .large: return 379
            }
        }
    }
    
    public var windowWidth: CGFloat{
        if #available(macOS 26.0, *){
            switch self{
            case .small: return 750
            case .medium: return 500
            case .large: return 750
            }
        }else{
            switch self{
            case .small: return 500
            case .medium: return 480
            case .large: return 520
            }
        }
    }
    public var height: CGFloat{
        if #available(macOS 26.0, *){
            switch self{
            case .small: return 700
            case .medium: return 600
            case .large: return 700
            }
        }else{
            switch self{
            case .small: return 500
            case .medium: return 580
            case .large: return 660
            }
        }

    }
}
