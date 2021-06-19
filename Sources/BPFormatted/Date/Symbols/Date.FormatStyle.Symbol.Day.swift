//
//  Date.FormatStyle.Symbol.Day.swift
//  
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

extension Date.BPFormatStyle.Symbol.Day {

    /// Minimum number of digits that shows the full numeric day of month. For example, `1`, `18`.
    public static var defaultDigits: Date.BPFormatStyle.Symbol.Day {
        Date.BPFormatStyle.Symbol.Day(value: "d")
    }

    /// Two-digit, zero-padded if necessary. For example, `01`, `18`.
    public static var twoDigits: Date.BPFormatStyle.Symbol.Day {
        Date.BPFormatStyle.Symbol.Day(value: "dd")
    }

    /// Ordinal of day in month.
    /// For example, the 2nd Wed in July would yield `2`.
    public static var ordinalOfDayInMonth: Date.BPFormatStyle.Symbol.Day {
        Date.BPFormatStyle.Symbol.Day(value: "F")
    }

    /// The field length specifies the minimum number of digits, with zero-padding as necessary.
    /// This is different from the conventional Julian day number in two regards. First, it demarcates days at local zone midnight, rather than noon GMT. Second, it is a local number; that is, it depends on the local time zone. It can be thought of as a single number that encompasses all the date-related fields.
    /// For example, `2451334`.
    public static func julianModified(minimumLength: Int = 1) -> Date.BPFormatStyle.Symbol.Day {
        Date.BPFormatStyle.Symbol.Day(value: "g")
    }
}
