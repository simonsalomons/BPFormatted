//
//  Date.FormatStyle.Symbol.Second.swift
//  
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

extension Date.BPFormatStyle.Symbol.Second {

    /// Minimum digits to show the numeric second. Truncated, not rounded. For example, `8`, `12`.
    public static var defaultDigits: Date.BPFormatStyle.Symbol.Second {
        Date.BPFormatStyle.Symbol.Second(value: "s")
    }

    /// Two digits numeric, zero padded if needed, not rounded. For example, `08`, `12`.
    public static var twoDigits: Date.BPFormatStyle.Symbol.Second {
        Date.BPFormatStyle.Symbol.Second(value: "ss")
    }
}
