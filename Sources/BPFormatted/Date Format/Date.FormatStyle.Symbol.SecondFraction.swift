//
//  Date.FormatStyle.Symbol.SecondFraction.swift
//  
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

extension Date.BPFormatStyle.Symbol.SecondFraction {

    /// Fractional second (numeric).
    /// Truncates, like other numeric time fields, but in this case to the number of digits specified by the associated `Int`.
    /// For example, specifying `4` for seconds value `12.34567` yields `12.3456`.
    public static func fractional(_ val: Int) -> Date.BPFormatStyle.Symbol.SecondFraction {
        Date.BPFormatStyle.Symbol.SecondFraction(value: String(repeating: "S", count: val))
    }

    /// Milliseconds in day (numeric).
    /// The associated `Int` specifies the minimum number of digits, with zero-padding as necessary. The maximum number of digits is 9.
    /// This field behaves exactly like a composite of all time-related fields, not including the zone fields. As such, it also reflects discontinuities of those fields on DST transition days. On a day of DST onset, it will jump forward. On a day of DST cessation, it will jump backward. This reflects the fact that is must be combined with the offset field to obtain a unique local time value.
    public static func milliseconds(_ val: Int) -> Date.BPFormatStyle.Symbol.SecondFraction {
        Date.BPFormatStyle.Symbol.SecondFraction(value: String(repeating: "A", count: val))
    }
}
