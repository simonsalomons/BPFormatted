//
//  Date.FormatStyle.Symbol.Era.swift
//  
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

extension Date.BPFormatStyle.Symbol.Era {

    /// Abbreviated Era name. For example, "AD", "Reiwa", "令和".
    public static var abbreviated: Date.BPFormatStyle.Symbol.Era {
        Date.BPFormatStyle.Symbol.Era(value: "GGG")
    }
    /// Wide era name. For example, "Anno Domini", "Reiwa", "令和".
    public static var wide: Date.BPFormatStyle.Symbol.Era {
        Date.BPFormatStyle.Symbol.Era(value: "GGGG")
    }
    /// Narrow era name.
    /// For example, For example, "A", "R", "R".
    public static var narrow: Date.BPFormatStyle.Symbol.Era {
        Date.BPFormatStyle.Symbol.Era(value: "GGGGG")
    }
}
