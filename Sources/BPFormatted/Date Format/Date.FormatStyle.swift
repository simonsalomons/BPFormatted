//
//  Date.FormatStyle.swift
//  
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

extension Date {

    /// Strategies for formatting a `Date`.
    public struct BPFormatStyle {

        internal var dateStyle: DateStyle?
        internal var timeStyle: TimeStyle?
        internal var symbols = Symbols()

        /// The locale to use when formatting date and time values.
        public var locale: Locale

        /// The time zone with which to specify date and time values.
        public var timeZone: TimeZone

        /// The calendar to use for date values.
        public var calendar: Calendar

        /// The capitalization formatting context used when formatting date and time values.
        public var capitalizationContext: FormatStyleCapitalizationContext

        /// Creates a new `FormatStyle` with the given configurations.
        /// - Parameters:
        ///   - date:  The date style for formatting the date.
        ///   - time:  The time style for formatting the date.
        ///   - locale: The locale to use when formatting date and time values.
        ///   - calendar: The calendar to use for date values.
        ///   - timeZone: The time zone with which to specify date and time values.
        ///   - capitalizationContext: The capitalization formatting context used when formatting date and time values.
        /// - Note: Always specify the date length, time length, or the date components to be included in the formatted string with the symbol modifiers. Otherwise, an empty string will be returned when you use the instance to format a `Date`.
        public init(date: Date.BPFormatStyle.DateStyle? = nil,
                    time: Date.BPFormatStyle.TimeStyle? = nil,
                    locale: Locale = .autoupdatingCurrent,
                    calendar: Calendar = .autoupdatingCurrent,
                    timeZone: TimeZone = .autoupdatingCurrent,
                    capitalizationContext: FormatStyleCapitalizationContext = .unknown) {
            self.dateStyle = date
            self.timeStyle = time
            self.locale = locale
            self.calendar = calendar
            self.timeZone = timeZone
            self.capitalizationContext = capitalizationContext
        }
    }
}

extension Date.BPFormatStyle: BPFormatStyle {

    private static var dateFormatter = DateFormatter()

    /// Creates a `FormatOutput` instance from `value`.
    public func format(_ value: Date) -> String {
        Self.dateFormatter.locale = locale
        Self.dateFormatter.calendar = calendar
        Self.dateFormatter.timeZone = timeZone
        if let template = symbols.template {
            Self.dateFormatter.setLocalizedDateFormatFromTemplate(template)
        } else {
            let dateTemplate = dateStyle?.symbols.template
            let timeTemplate = timeStyle?.symbols.template
            switch (dateTemplate, timeTemplate) {
            case let (.some(date), .some(time)):
                Self.dateFormatter.setLocalizedDateFormatFromTemplate("\(date) \(time)")
            case let (.some(date), .none):
                Self.dateFormatter.setLocalizedDateFormatFromTemplate(date)
            case let (.none, .some(time)):
                Self.dateFormatter.setLocalizedDateFormatFromTemplate(time)
            case (.none, .none):
                let template = "\(DateStyle.numeric.symbols.template!) \(TimeStyle.shortened.symbols.template!)"
                Self.dateFormatter.setLocalizedDateFormatFromTemplate(template)
            }
        }
#warning("🆘 Implement capitalization context")
        /*
         I don't know what capitalization context is supposed to do.
         Check the following code in a playground:
         ```
         print(Date.now.formatted(Date.FormatStyle(date: .complete, time: .complete, capitalizationContext: .unknown)))
         print(Date.now.formatted(Date.FormatStyle(date: .complete, time: .complete, capitalizationContext: .standalone)))
         print(Date.now.formatted(Date.FormatStyle(date: .complete, time: .complete, capitalizationContext: .beginningOfSentence)))
         print(Date.now.formatted(Date.FormatStyle(date: .complete, time: .complete, capitalizationContext: .listItem)))
         print(Date.now.formatted(Date.FormatStyle(date: .complete, time: .complete, capitalizationContext: .middleOfSentence)))
         ```
         */
        return Self.dateFormatter.string(from: value)
    }

    /// If the format allows selecting a locale, returns a copy of this format with the new locale set. Default implementation returns an unmodified self.
    public func locale(_ locale: Locale) -> Date.BPFormatStyle {
        var copy = self
        copy.locale = locale
        return copy
    }

    /// The type of data to format.
    public typealias FormatInput = Date

    /// The type of the formatted data.
    public typealias FormatOutput = String
}

extension Date.BPFormatStyle {
    internal struct Symbols: Hashable, Codable {
        var era: String?
        var year: String?
        var quarter: String?
        var month: String?
        var week: String?
        var day: String?
        var dayOfYear: String?
        var weekday: String?
        var hour: String?
        var minute: String?
        var second: String?
        var secondFraction: String?
        var timeZoneSymbol: String?

        var template: String? {
            let symbols = [era, year, quarter, month, week, day, dayOfYear, weekday, hour, minute, second, secondFraction, timeZoneSymbol].compactMap({ $0 })
            guard symbols.isEmpty == false else {
                return nil
            }
            return symbols.joined(separator: " ")
        }
    }
}

extension Date.BPFormatStyle {

    internal func copyWithoutStyles() -> Date.BPFormatStyle {
        var copy = self
        copy.dateStyle = nil
        copy.timeStyle = nil
        return copy
    }

    public func era(_ format: Date.BPFormatStyle.Symbol.Era = .abbreviated) -> Date.BPFormatStyle {
        var copy = copyWithoutStyles()
        copy.symbols.era = format.value
        return self
    }

    public func year(_ format: Date.BPFormatStyle.Symbol.Year = .defaultDigits) -> Date.BPFormatStyle {
        var copy = copyWithoutStyles()
        copy.symbols.year = format.value
        return copy
    }

    public func quarter(_ format: Date.BPFormatStyle.Symbol.Quarter = .abbreviated) -> Date.BPFormatStyle {
        var copy = copyWithoutStyles()
        copy.symbols.quarter = format.value
        return copy
    }

    public func month(_ format: Date.BPFormatStyle.Symbol.Month = .abbreviated) -> Date.BPFormatStyle {
        var copy = copyWithoutStyles()
        copy.symbols.month = format.value
        return copy
    }

    public func week(_ format: Date.BPFormatStyle.Symbol.Week = .defaultDigits) -> Date.BPFormatStyle {
        var copy = copyWithoutStyles()
        copy.symbols.week = format.value
        return copy
    }

    public func day(_ format: Date.BPFormatStyle.Symbol.Day = .defaultDigits) -> Date.BPFormatStyle {
        var copy = copyWithoutStyles()
        copy.symbols.day = format.value
        return copy
    }

    public func dayOfYear(_ format: Date.BPFormatStyle.Symbol.DayOfYear = .defaultDigits) -> Date.BPFormatStyle {
        var copy = copyWithoutStyles()
        copy.symbols.dayOfYear = format.value
        return copy
    }

    public func weekday(_ format: Date.BPFormatStyle.Symbol.Weekday = .abbreviated) -> Date.BPFormatStyle {
        var copy = copyWithoutStyles()
        copy.symbols.weekday = format.value
        return copy
    }

    public func hour(_ format: Date.BPFormatStyle.Symbol.Hour = .defaultDigits(amPM: .abbreviated)) -> Date.BPFormatStyle {
        var copy = copyWithoutStyles()
        copy.symbols.hour = format.value
        return copy
    }

    public func minute(_ format: Date.BPFormatStyle.Symbol.Minute = .defaultDigits) -> Date.BPFormatStyle {
        var copy = copyWithoutStyles()
        copy.symbols.minute = format.value
        return copy
    }

    public func second(_ format: Date.BPFormatStyle.Symbol.Second = .defaultDigits) -> Date.BPFormatStyle {
        var copy = copyWithoutStyles()
        copy.symbols.second = format.value
        return copy
    }

    public func secondFraction(_ format: Date.BPFormatStyle.Symbol.SecondFraction) -> Date.BPFormatStyle {
        var copy = copyWithoutStyles()
        copy.symbols.secondFraction = format.value
        return copy
    }

    public func timeZone(_ format: Date.BPFormatStyle.Symbol.TimeZone = .specificName(.short)) -> Date.BPFormatStyle {
        var copy = copyWithoutStyles()
        copy.symbols.timeZoneSymbol = format.value
        return copy
    }
}

extension Date.BPFormatStyle {

    public struct Symbol: Hashable {

        public struct Era : Hashable {
            internal var value: String
        }

        public struct Year : Hashable {
            internal var value: String
        }

        public struct Quarter : Hashable {
            internal var value: String
        }

        public struct Month : Hashable {
            internal var value: String
        }

        public struct Week : Hashable {
            internal var value: String
        }

        public struct Day : Hashable {
            internal var value: String
        }

        public struct DayOfYear : Hashable {
            internal var value: String
        }

        public struct Weekday : Hashable {
            internal var value: String
        }
        
        public struct Hour : Hashable {
            internal var value: String
        }

        public struct Minute : Hashable {
            internal var value: String
        }

        public struct Second : Hashable {
            internal var value: String
        }

        public struct SecondFraction : Hashable {
            internal var value: String
        }

        public struct TimeZone : Hashable {
            internal var value: String
        }

        public struct StandaloneQuarter : Hashable {
            internal var value: String
        }

        public struct StandaloneMonth : Hashable {
            internal var value: String
        }

        public struct StandaloneWeekday : Hashable {
            internal var value: String
        }

        public struct VerbatimHour : Hashable {
            internal var value: String
        }
    }
}
