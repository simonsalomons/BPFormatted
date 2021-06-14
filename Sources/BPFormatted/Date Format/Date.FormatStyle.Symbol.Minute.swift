//
//  Date.FormatStyle.Symbol.Minute.swift
//  
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

extension Date.BPFormatStyle.Symbol.Minute {

    /// Minimum digits to show the numeric minute. Truncated, not rounded. For example, `8`, `59`.
    public static var defaultDigits: Date.BPFormatStyle.Symbol.Minute {
        Date.BPFormatStyle.Symbol.Minute(value: "m")
    }

    /// Two-digit numeric, zero padded if needed. For example, `08`, `59`.
    public static var twoDigits: Date.BPFormatStyle.Symbol.Minute {
        Date.BPFormatStyle.Symbol.Minute(value: "mm")
    }
}
