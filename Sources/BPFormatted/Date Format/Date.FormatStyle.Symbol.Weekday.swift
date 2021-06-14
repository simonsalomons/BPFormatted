//
//  Date.FormatStyle.Symbol.Weekday.swift
//  
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

extension Date.BPFormatStyle.Symbol.Weekday {

    /// Abbreviated day of week name. For example, "Tue".
    public static var abbreviated: Date.BPFormatStyle.Symbol.Weekday {
        Date.BPFormatStyle.Symbol.Weekday(value: "EEE")
    }

    /// Wide day of week name. For example, "Tuesday".
    public static var wide: Date.BPFormatStyle.Symbol.Weekday {
        Date.BPFormatStyle.Symbol.Weekday(value: "EEEE")
    }

    /// Narrow day of week name. For example, "T".
    public static var narrow: Date.BPFormatStyle.Symbol.Weekday {
        Date.BPFormatStyle.Symbol.Weekday(value: "EEEEE")
    }

    /// Short day of week name. For example, "Tu".
    public static var short: Date.BPFormatStyle.Symbol.Weekday {
        Date.BPFormatStyle.Symbol.Weekday(value: "EEEEEE")
    }

    /// Local day of week number/name. The value depends on the local starting day of the week.
    public static var oneDigit: Date.BPFormatStyle.Symbol.Weekday {
        Date.BPFormatStyle.Symbol.Weekday(value: "e")
    }

    /// Local day of week number/name, format style; two digits, zero-padded if necessary.
    public static var twoDigits: Date.BPFormatStyle.Symbol.Weekday {
        Date.BPFormatStyle.Symbol.Weekday(value: "ee")
    }
}
