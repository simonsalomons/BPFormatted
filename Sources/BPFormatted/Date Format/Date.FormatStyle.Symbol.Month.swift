//
//  Date.FormatStyle.Symbol.Month.swift
//  
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

extension Date.BPFormatStyle.Symbol.Month {

    /// Minimum number of digits that shows the numeric month. Intended to be used in conjunction with `Day.defaultDigits`.
    /// For example, `9`, `12`.
    public static var defaultDigits: Date.BPFormatStyle.Symbol.Month {
        Date.BPFormatStyle.Symbol.Month(value: "M")
    }

    /// 2 digits, zero pad if needed. For example, `09`, `12`.
    public static var twoDigits: Date.BPFormatStyle.Symbol.Month {
        Date.BPFormatStyle.Symbol.Month(value: "MM")
    }

    /// Abbreviated month name. For example, "Sep".
    public static var abbreviated: Date.BPFormatStyle.Symbol.Month {
        Date.BPFormatStyle.Symbol.Month(value: "MMM")
    }

    /// Wide month name. For example, "September".
    public static var wide: Date.BPFormatStyle.Symbol.Month {
        Date.BPFormatStyle.Symbol.Month(value: "MMMM")
    }

    /// Narrow month name. For example, "S".
    public static var narrow: Date.BPFormatStyle.Symbol.Month {
        Date.BPFormatStyle.Symbol.Month(value: "MMMMM")
    }
}
