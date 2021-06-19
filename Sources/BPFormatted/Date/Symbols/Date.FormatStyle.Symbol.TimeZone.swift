//
//  Date.FormatStyle.Symbol.TimeZone.swift
//  
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

extension Date.BPFormatStyle.Symbol.TimeZone {

    public enum Width {
        case short
        case long
    }

    /// Specific non-location format. Falls back to `shortLocalizedGMT` if unavailable. For example,
    /// short: "PDT"
    /// long: "Pacific Daylight Time".
    public static func specificName(_ width: Date.BPFormatStyle.Symbol.TimeZone.Width) -> Date.BPFormatStyle.Symbol.TimeZone {
        switch width {
        case .short:
            return Date.BPFormatStyle.Symbol.TimeZone(value: "z")
        case .long:
            return Date.BPFormatStyle.Symbol.TimeZone(value: "zzzz")
        }
    }

    /// Generic non-location format. Falls back to `genericLocation` if unavailable. For example,
    /// short: "PT". Fallback again to `localizedGMT(.short)` if `genericLocation(.short)` is unavaiable.
    /// long: "Pacific Time"
    public static func genericName(_ width: Date.BPFormatStyle.Symbol.TimeZone.Width) -> Date.BPFormatStyle.Symbol.TimeZone {
        switch width {
        case .short:
            return Date.BPFormatStyle.Symbol.TimeZone(value: "v")
        case .long:
            return Date.BPFormatStyle.Symbol.TimeZone(value: "vvvv")
        }
    }

    /// The ISO8601 format with hours, minutes and optional seconds fields. For example,
    /// short: "-0800"
    /// long: "-08:00" or "-07:52:58".
    public static func iso8601(_ width: Date.BPFormatStyle.Symbol.TimeZone.Width) -> Date.BPFormatStyle.Symbol.TimeZone {
        switch width {
        case .short:
            return Date.BPFormatStyle.Symbol.TimeZone(value: "Z")
        case .long:
            return Date.BPFormatStyle.Symbol.TimeZone(value: "ZZZZZ")
        }
    }

    /// Short localized GMT format. For example,
    /// short: "GMT-8"
    /// long: "GMT-8:00"
    public static func localizedGMT(_ width: Date.BPFormatStyle.Symbol.TimeZone.Width) -> Date.BPFormatStyle.Symbol.TimeZone {
        switch width {
        case .short:
            return Date.BPFormatStyle.Symbol.TimeZone(value: "O")
        case .long:
            return Date.BPFormatStyle.Symbol.TimeZone(value: "OOOO")
        }
    }

    /// The time zone ID. For example,
    /// short: "uslax"
    /// long: "America/Los_Angeles".
    public static func identifier(_ width: Date.BPFormatStyle.Symbol.TimeZone.Width) -> Date.BPFormatStyle.Symbol.TimeZone {
        switch width {
        case .short:
            return Date.BPFormatStyle.Symbol.TimeZone(value: "V")
        case .long:
            return Date.BPFormatStyle.Symbol.TimeZone(value: "VV")
        }
    }

    /// The exemplar city (location) for the time zone. The localized exemplar city name for the special zone or unknown is used as the fallback if it is unavailable.
    /// For example, "Los Angeles".
    public static var exemplarLocation: Date.BPFormatStyle.Symbol.TimeZone {
        Date.BPFormatStyle.Symbol.TimeZone(value: "VVV")
    }

    /// The generic location format. Falls back to `longLocalizedGMT` if unavailable. Recommends for presenting possible time zone choices for user selection.
    /// For example, "Los Angeles Time".
    public static var genericLocation: Date.BPFormatStyle.Symbol.TimeZone {
        Date.BPFormatStyle.Symbol.TimeZone(value: "VVVV")
    }
}
