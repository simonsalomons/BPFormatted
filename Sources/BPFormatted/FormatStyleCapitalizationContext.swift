//
//  FormatStyleCapitalizationContext.swift
//  
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

public struct FormatStyleCapitalizationContext: Codable, Hashable {

    internal let option: Option

    public static var unknown: FormatStyleCapitalizationContext {
        return FormatStyleCapitalizationContext(option: .unknown)
    }

    /// For stand-alone usage, such as an isolated name on a calendar page.
    public static var standalone: FormatStyleCapitalizationContext {
        return FormatStyleCapitalizationContext(option: .standalone)
    }

    /// For use in a UI list or menu item.
    public static var listItem: FormatStyleCapitalizationContext {
        return FormatStyleCapitalizationContext(option: .listItem)
    }

    public static var beginningOfSentence: FormatStyleCapitalizationContext {
        return FormatStyleCapitalizationContext(option: .beginningOfSentence)
    }

    public static var middleOfSentence: FormatStyleCapitalizationContext {
        return FormatStyleCapitalizationContext(option: .middleOfSentence)
    }

    internal enum Option: Int, Codable, Hashable {
        case unknown
        case standalone
        case listItem
        case beginningOfSentence
        case middleOfSentence
    }
}
