//
//  Date.TimeStyle.swift
//  
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

extension Date.BPFormatStyle {

    /// Predefined time styles varied in lengths or the components included. The exact format depends on the locale.
    public struct TimeStyle : Codable, Hashable {
        internal let style: Style

        /// Excludes the time part.
        public static var omitted: Date.BPFormatStyle.TimeStyle {
            return TimeStyle(style: .omitted)
        }

        /// For example, `04:29 PM`, `16:29`.
        public static var shortened: Date.BPFormatStyle.TimeStyle {
            return TimeStyle(style: .shortened)
        }

        /// For example, `4:29:24 PM`, `16:29:24`.
        public static var standard: Date.BPFormatStyle.TimeStyle {
            return TimeStyle(style: .standard)
        }

        /// For example, `4:29:24 PM PDT`, `16:29:24 GMT`.
        public static var complete: Date.BPFormatStyle.TimeStyle {
            return TimeStyle(style: .complete)
        }

        internal var symbols: Symbols {
            switch style {
            case .omitted:
                return Symbols()
            case .shortened:
                return Date.BPFormatStyle.dateTime
                    .minute(.twoDigits)
                    .hour(.defaultDigits(amPM: .abbreviated))
                    .symbols
            case .standard:
                return Date.BPFormatStyle.dateTime
                    .minute(.twoDigits)
                    .hour(.defaultDigits(amPM: .abbreviated))
                    .second(.twoDigits)
                    .symbols
            case .complete:
                return Date.BPFormatStyle.dateTime
                    .minute(.twoDigits)
                    .hour(.defaultDigits(amPM: .abbreviated))
                    .second(.twoDigits)
                    .timeZone(.specificName(.short))
                    .symbols
            }
        }

        internal var dateFormatterStyle: DateFormatter.Style {
            switch style {
            case .omitted:
                return .none
            case .shortened:
                return .short
            case .standard:
                return .medium
            case .complete:
                return .long
            }
        }

        internal enum Style: Codable, Hashable {
            case omitted
            case shortened
            case standard
            case complete
        }
    }
}
