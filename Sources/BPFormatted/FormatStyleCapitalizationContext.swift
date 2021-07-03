//
//  FormatStyleCapitalizationContext.swift
//  
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

@available(iOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "FormatStyleCapitalizationContext")
@available(macOS, deprecated: 12.0, message: "Consider using Apple's API", renamed: "FormatStyleCapitalizationContext")
@available(tvOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "FormatStyleCapitalizationContext")
@available(watchOS, deprecated: 8.0, message: "Consider using Apple's API", renamed: "FormatStyleCapitalizationContext")
public struct BPFormatStyleCapitalizationContext: Codable, Hashable {

    internal let option: Option

    public static var unknown: BPFormatStyleCapitalizationContext {
        return BPFormatStyleCapitalizationContext(option: .unknown)
    }

    /// For stand-alone usage, such as an isolated name on a calendar page.
    public static var standalone: BPFormatStyleCapitalizationContext {
        return BPFormatStyleCapitalizationContext(option: .standalone)
    }

    /// For use in a UI list or menu item.
    public static var listItem: BPFormatStyleCapitalizationContext {
        return BPFormatStyleCapitalizationContext(option: .listItem)
    }

    public static var beginningOfSentence: BPFormatStyleCapitalizationContext {
        return BPFormatStyleCapitalizationContext(option: .beginningOfSentence)
    }

    public static var middleOfSentence: BPFormatStyleCapitalizationContext {
        return BPFormatStyleCapitalizationContext(option: .middleOfSentence)
    }

    internal enum Option: Int, Codable, Hashable {
        case unknown
        case standalone
        case listItem
        case beginningOfSentence
        case middleOfSentence

        var formatterContext: Formatter.Context {
            switch self {
            case .unknown:
                return .unknown
            case .standalone:
                return .standalone
            case .listItem:
                return .listItem
            case .beginningOfSentence:
                return .beginningOfSentence
            case .middleOfSentence:
                return .middleOfSentence
            }
        }
    }
}
