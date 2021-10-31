//
//  CurrencyFormatStyleConfiguration.swift
//
//  Created by Simon Salomons on 17/07/2021.
//

import Foundation

@available(iOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "CurrencyFormatStyleConfiguration")
@available(macOS, deprecated: 12.0, message: "Consider using Apple's API", renamed: "CurrencyFormatStyleConfiguration")
@available(tvOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "CurrencyFormatStyleConfiguration")
@available(watchOS, deprecated: 8.0, message: "Consider using Apple's API", renamed: "CurrencyFormatStyleConfiguration")
public enum BPCurrencyFormatStyleConfiguration {

    public typealias Grouping = BPNumberFormatStyleConfiguration.Grouping

    public typealias Precision = BPNumberFormatStyleConfiguration.Precision

    public typealias DecimalSeparatorDisplayStrategy = BPNumberFormatStyleConfiguration.DecimalSeparatorDisplayStrategy

    public typealias RoundingRule = BPNumberFormatStyleConfiguration.RoundingRule

    public struct SignDisplayStrategy : Codable, Hashable {

        internal enum Option: Int, Codable, Hashable {
            case always = 0
            case hidden = 1
        }

        internal let negative: Option
        internal let zero: Option
        internal let positive: Option
        internal let accounting: Bool

        public static var automatic: SignDisplayStrategy {
            SignDisplayStrategy(negative: .always,
                                zero: .hidden,
                                positive: .hidden,
                                accounting: false)
        }

        public static var never: SignDisplayStrategy {
            SignDisplayStrategy(negative: .hidden,
                                zero: .hidden,
                                positive: .hidden,
                                accounting: false)
        }

        public static func always(showZero: Bool = true) -> SignDisplayStrategy {
            SignDisplayStrategy(negative: .always,
                                zero: showZero ? .always : .hidden,
                                positive: .always,
                                accounting: false)
        }

        public static var accounting: SignDisplayStrategy {
            SignDisplayStrategy(negative: .always,
                                zero: .hidden,
                                positive: .hidden,
                                accounting: true)
        }

        public static func accountingAlways(showZero: Bool = false) -> SignDisplayStrategy {
            SignDisplayStrategy(negative: .always,
                                zero: showZero ? .always : .hidden,
                                positive: .always,
                                accounting: true)
        }
    }

    public struct Presentation : Codable, Hashable {

        internal let option: Option

        public static var narrow: Presentation {
            Presentation(option: .narrow)
        }

        public static var standard: Presentation {
            Presentation(option: .standard)
        }

        public static var isoCode: Presentation {
            Presentation(option: .isoCode)
        }

        public static var fullName: Presentation {
            Presentation(option: .fullName)
        }

        internal enum Option: Int, Codable {
            case narrow
            case standard
            case isoCode
            case fullName
        }
    }
}
