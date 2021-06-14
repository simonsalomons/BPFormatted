//
//  Date.FormatStyle.Symbol.Quarter.swift
//  
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

extension Date.BPFormatStyle.Symbol.Quarter {

    /// Numeric: one digit quarter. For example `2`.
    public static var oneDigit: Date.BPFormatStyle.Symbol.Quarter {
        Date.BPFormatStyle.Symbol.Quarter(value: "Q")
    }
    /// Numeric: two digits with zero padding. For example `02`.
    public static var twoDigits: Date.BPFormatStyle.Symbol.Quarter {
        Date.BPFormatStyle.Symbol.Quarter(value: "QQ")
    }
    /// Abbreviated quarter. For example `Q2`.
    public static var abbreviated: Date.BPFormatStyle.Symbol.Quarter {
        Date.BPFormatStyle.Symbol.Quarter(value: "QQQ")
    }
    /// The quarter spelled out in full, for example `2nd quarter`.
    public static var wide: Date.BPFormatStyle.Symbol.Quarter {
        Date.BPFormatStyle.Symbol.Quarter(value: "QQQQ")
    }
    /// Narrow quarter. For example `2`.
    public static var narrow: Date.BPFormatStyle.Symbol.Quarter {
        Date.BPFormatStyle.Symbol.Quarter(value: "q")
    }
}
