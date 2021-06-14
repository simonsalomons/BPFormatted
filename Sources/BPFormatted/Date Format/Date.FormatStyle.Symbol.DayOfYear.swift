//
//  Date.FormatStyle.Symbol.DayOfYear.swift
//  
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

extension Date.BPFormatStyle.Symbol.DayOfYear {

    /// Minimum number of digits that shows the full numeric day of year. For example, `7`, `33`, `345`.
    public static var defaultDigits: Date.BPFormatStyle.Symbol.DayOfYear {
        Date.BPFormatStyle.Symbol.DayOfYear(value: "D")
    }

    /// Two-digit day of year, with zero-padding as necessary. For example, `07`, `33`, `345`.
    public static var twoDigits: Date.BPFormatStyle.Symbol.DayOfYear {
        Date.BPFormatStyle.Symbol.DayOfYear(value: "DD")
    }

    /// Three-digit day of year, with zero-padding as necessary. For example, `007`, `033`, `345`.
    public static var threeDigits: Date.BPFormatStyle.Symbol.DayOfYear {
        Date.BPFormatStyle.Symbol.DayOfYear(value: "DDD")
    }
}
