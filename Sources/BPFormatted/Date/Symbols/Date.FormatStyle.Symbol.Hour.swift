//
//  Date.FormatStyle.Symbol.Hour.swift
//  
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

extension Date.BPFormatStyle.Symbol.Hour {

    public struct AMPMStyle : Codable, Hashable {

        internal let style: Style

        /// Hides the day period marker (AM/PM).
        /// For example, `8` (for 8 in the morning), `1` (for 1 in the afternoon) if used with `defaultDigits`.
        /// Or `08`, `01` if used with `twoDigits`.
        public static var omitted: Date.BPFormatStyle.Symbol.Hour.AMPMStyle {
            Date.BPFormatStyle.Symbol.Hour.AMPMStyle(style: .omitted)
        }

        /// Narrow day period if the locale prefers using day period with hour.
        /// For example, `8`, `8a`, `13`, `1p` if used with `defaultDigits`.
        /// Or `08`, `08a`, `13`, `01p` if used with `twoDigits`.
        public static var narrow: Date.BPFormatStyle.Symbol.Hour.AMPMStyle {
            Date.BPFormatStyle.Symbol.Hour.AMPMStyle(style: .narrow)
        }

        /// Abbreviated day period if the locale prefers using day period with hour.
        /// For example, `8`, `8 AM`, `13`, `1 PM` if used with `defaultDigits`.
        /// Or `08`, `08 AM`, `13`, `01 PM` if used with `twoDigits`.
        public static var abbreviated: Date.BPFormatStyle.Symbol.Hour.AMPMStyle {
            Date.BPFormatStyle.Symbol.Hour.AMPMStyle(style: .abbreviated)
        }

        /// Wide day period if the locale prefers using day period with hour.
        /// For example, `8`, `8 A.M.`, `13`, `1 P.M.` if used with `defaultDigits`.
        /// Or, `08`, `08 A.M.`, `13`, `01 P.M.` if used with `twoDigits`.
        public static var wide: Date.BPFormatStyle.Symbol.Hour.AMPMStyle {
            Date.BPFormatStyle.Symbol.Hour.AMPMStyle(style: .wide)
        }

        internal enum Style: String, Codable {
            case omitted
            case narrow
            case abbreviated
            case wide
        }
    }

    /// The preferred numeric hour format for the locale with minimum digits. Whether the period symbol (AM/PM) will be shown depends on the locale.
    public static func defaultDigits(amPM: Date.BPFormatStyle.Symbol.Hour.AMPMStyle) -> Date.BPFormatStyle.Symbol.Hour {
        switch amPM.style {
        case .omitted:
            return Date.BPFormatStyle.Symbol.Hour(value: "J")
        case .narrow:
            return Date.BPFormatStyle.Symbol.Hour(value: "jjjjj")
        case .abbreviated:
            return Date.BPFormatStyle.Symbol.Hour(value: "j")
        case .wide:
            return Date.BPFormatStyle.Symbol.Hour(value: "jjj")
        }
    }

    /// The preferred two-digit hour format for the locale, zero padded if necessary. Whether the period symbol (AM/PM) will be shown depends on the locale.
    public static func twoDigits(amPM: Date.BPFormatStyle.Symbol.Hour.AMPMStyle) -> Date.BPFormatStyle.Symbol.Hour {
        switch amPM.style {
        case .omitted:
            return Date.BPFormatStyle.Symbol.Hour(value: "JJ")
        case .narrow:
            return Date.BPFormatStyle.Symbol.Hour(value: "jjjjjj")
        case .abbreviated:
            return Date.BPFormatStyle.Symbol.Hour(value: "jj")
        case .wide:
            return Date.BPFormatStyle.Symbol.Hour(value: "jjjj")
        }
    }

    /// Behaves like `defaultDigits`: the preferred numeric hour format for the locale with minimum digits. May also use conversational period formats.
    public static func conversationalDefaultDigits(amPM: Date.BPFormatStyle.Symbol.Hour.AMPMStyle) -> Date.BPFormatStyle.Symbol.Hour {
        switch amPM.style {
        case .omitted:
            return Date.BPFormatStyle.Symbol.Hour(value: "J")
        case .narrow:
            return Date.BPFormatStyle.Symbol.Hour(value: "CCCCC")
        case .abbreviated:
            return Date.BPFormatStyle.Symbol.Hour(value: "C")
        case .wide:
            return Date.BPFormatStyle.Symbol.Hour(value: "CCC")
        }
    }

    /// Behaves like `twoDigits`: two-digit hour format for the locale, zero padded if necessary. May also use conversational period formats.
    public static func conversationalTwoDigits(amPM: Date.BPFormatStyle.Symbol.Hour.AMPMStyle) -> Date.BPFormatStyle.Symbol.Hour {
        switch amPM.style {
        case .omitted:
            return Date.BPFormatStyle.Symbol.Hour(value: "JJ")
        case .narrow:
            return Date.BPFormatStyle.Symbol.Hour(value: "CCCCCC")
        case .abbreviated:
            return Date.BPFormatStyle.Symbol.Hour(value: "CC")
        case .wide:
            return Date.BPFormatStyle.Symbol.Hour(value: "CCCC")
        }
    }
}
