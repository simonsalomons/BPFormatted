//
//  Date.FormatStyle.Symbol.Year.swift
//  
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

extension Date.BPFormatStyle.Symbol.Year {

    /// Minimum number of digits that shows the full year.
    /// For example, `2`, `20`, `201`, `2017`, `20173`.
    public static var defaultDigits: Date.BPFormatStyle.Symbol.Year {
        Date.BPFormatStyle.Symbol.Year(value: "y")
    }

    /// Two low-order digits.
    /// Padded or truncated if necessary. For example, `02`, `20`, `01`, `17`, `73`.
    public static var twoDigits: Date.BPFormatStyle.Symbol.Year {
        Date.BPFormatStyle.Symbol.Year(value: "yy")
    }

    /// Three or more digits.
    /// Padded if necessary. For example, `002`, `020`, `201`, `2017`, `20173`.
    public static func padded(_ length: Int) -> Date.BPFormatStyle.Symbol.Year {
        Date.BPFormatStyle.Symbol.Year(value: String(repeating: "y", count: length))
    }

    /// Related Gregorian year.
    /// For non-Gregorian calendars, this corresponds to the extended Gregorian year in which the calendar’s year begins. Related Gregorian years are often displayed, for example, when formatting dates in the Japanese calendar — e.g. "2012(平成24)年1月15日" — or in the Chinese calendar — e.g. "2012壬辰年腊月初四".
    public static func relatedGregorian(minimumLength: Int = 1) -> Date.BPFormatStyle.Symbol.Year {
        Date.BPFormatStyle.Symbol.Year(value: String(repeating: "U", count: minimumLength))
    }

    /// Extended year.
    /// This is a single number designating the year of this calendar system, encompassing all supra-year fields. For example, for the Julian calendar system, year numbers are positive, with an era of BCE or CE. An extended year value for the Julian calendar system assigns positive values to CE years and negative values to BCE years, with 1 BCE being year 0.
    public static func extended(minimumLength: Int = 1) -> Date.BPFormatStyle.Symbol.Year {
        Date.BPFormatStyle.Symbol.Year(value: String(repeating: "u", count: minimumLength))
    }
}
