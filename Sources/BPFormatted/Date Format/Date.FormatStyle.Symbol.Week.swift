//
//  Date.FormatStyle.Symbol.Week.swift
//  
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

extension Date.BPFormatStyle.Symbol.Week {

    /// Numeric week of year. For example, `8`, `27`.
    public static var defaultDigits: Date.BPFormatStyle.Symbol.Week {
        Date.BPFormatStyle.Symbol.Week(value: "w")
    }

    /// Two-digit numeric week of year, zero padded as necessary. For example, `08`, `27`.
    public static var twoDigits: Date.BPFormatStyle.Symbol.Week {
        Date.BPFormatStyle.Symbol.Week(value: "ww")
    }

    /// One-digit numeric week of month, starting from 1. For example, `1`.
    public static var weekOfMonth: Date.BPFormatStyle.Symbol.Week {
        Date.BPFormatStyle.Symbol.Week(value: "W")
    }
}
