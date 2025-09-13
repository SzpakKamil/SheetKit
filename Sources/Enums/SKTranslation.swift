//
//  File.swift
//  SheetKit
//
//  Created by Kamil Szpak on 11/09/2025.
//

import Foundation

enum SKTranslation{
    enum SKButton{
        case close
        case back
        case `continue`
        case noDescription
        
        var value: String{
            switch self {
            case .close:
                String(
                    localized: "SKTranslation.SKButton.Close",
                    defaultValue: "Close",
                    bundle: Bundle.module
                )
            case .back:
                String(
                    localized: "SKTranslation.SKButton.Back",
                    defaultValue: "Back",
                    bundle: Bundle.module
                )
            case .noDescription:
                String(
                    localized: "SKTranslation.SKButton.NoDescription",
                    defaultValue: "No Description Provided",
                    bundle: Bundle.module
                )
            case .continue:
                String(
                    localized: "SKTranslation.SKButton.Continue",
                    defaultValue: "Continue",
                    bundle: Bundle.module
                )
            }
        }
    }
    enum SKDatePicker{
        case submit
        case reset
        case title
        
        var value: String{
            switch self {
            case .submit:
                String(
                    localized: "SKTranslation.SKDatePicker.Submit",
                    defaultValue: "Submit",
                    bundle: Bundle.module
                )
            case .reset:
                String(
                    localized: "SKTranslation.SKDatePicker.Reset",
                    defaultValue: "Reset",
                    bundle: Bundle.module
                )
            case .title:
                String(
                    localized: "SKTranslation.SKDatePicker.Title",
                    defaultValue: "Select a Date",
                    bundle: Bundle.module
                )
            }
        }
    }
    enum SKStepper{
        case submit
        case reset
        case title
        case increment
        case decrement
        
        //        static func decrement(value: String) -> String {
        //            return String.localizedStringWithFormat(NSLocalizedString("SKTranslation.SKStepper.Decrement", bundle: .main, value: "Decrement %@", comment: ""), value)
        //        }
        var value: String{
            switch self {
            case .submit:
                String(
                    localized: "SKTranslation.SKStepper.Submit",
                    defaultValue: "Submit",
                    bundle: Bundle.module
                )
            case .reset:
                String(
                    localized: "SKTranslation.SKStepper.Reset",
                    defaultValue: "Reset",
                    bundle: Bundle.module
                )
            case .title:
                String(
                    localized: "SKTranslation.SKStepper.Title",
                    defaultValue: "Adjust Value",
                    bundle: Bundle.module
                )
            case .increment:
                String(
                    localized: "SKTranslation.SKStepper.Increment",
                    defaultValue: "Increment",
                    bundle: Bundle.module
                )
            case .decrement:
                String(
                    localized: "SKTranslation.SKStepper.Decrement",
                    defaultValue: "Decrement",
                    bundle: Bundle.module
                )
            }
        }
    }
    
    enum SKPicker{
        case title
        
        var value: String{
            switch self {
            case .title:
                String(
                    localized: "SKTranslation.SKPickr.Title",
                    defaultValue: "Select Value",
                    bundle: Bundle.module
                )
            }
        }
    }
    
    enum SKTextField{
        case submit
        
        var value: String{
            switch self {
            case .submit:
                String(
                    localized: "SKTranslation.SKTextField.Submit",
                    defaultValue: "Submit",
                    bundle: Bundle.module
                )
            }
        }
    }
    enum SKToggle{
        case on
        case off
        
        var value: String{
            switch self {
            case .on:
                String(
                    localized: "SKTranslation.SKToggle.On",
                    defaultValue: "On",
                    bundle: Bundle.module
                )
            case .off:
                String(
                    localized: "SKTranslation.SKToggle.Off",
                    defaultValue: "Off",
                    bundle: Bundle.module
                )
            }
        }
    }
}
