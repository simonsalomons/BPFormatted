//
//  Date.FormatStyle.Symbol.swift
//  
//
//  Created by Simon Salomons on 19/06/2021.
//

import Foundation

extension Date.BPFormatStyle {

    public struct Symbol: Hashable {

        public struct Era: Hashable {
            internal var value: String
        }

        public struct Year: Hashable {
            internal var value: String
        }

        public struct Quarter: Hashable {
            internal var value: String
        }

        public struct Month: Hashable {
            internal var value: String
        }

        public struct Week: Hashable {
            internal var value: String
        }

        public struct Day: Hashable {
            internal var value: String
        }

        public struct DayOfYear: Hashable {
            internal var value: String
        }

        public struct Weekday: Hashable {
            internal var value: String
        }

        public struct Hour: Hashable {
            internal var value: String
        }

        public struct Minute: Hashable {
            internal var value: String
        }

        public struct Second: Hashable {
            internal var value: String
        }

        public struct SecondFraction: Hashable {
            internal var value: String
        }

        public struct TimeZone: Hashable {
            internal var value: String
        }

        public struct StandaloneQuarter: Hashable {
            internal var value: String
        }

        public struct StandaloneMonth: Hashable {
            internal var value: String
        }

        public struct StandaloneWeekday: Hashable {
            internal var value: String
        }

        public struct VerbatimHour: Hashable {
            internal var value: String
        }
    }
}
