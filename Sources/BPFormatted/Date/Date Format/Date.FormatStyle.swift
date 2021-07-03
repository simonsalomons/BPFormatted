//
//  Date.FormatStyle.swift
//  
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

extension Date {

    @available(iOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "FormatStyle")
    @available(macOS, deprecated: 12.0, message: "Consider using Apple's API", renamed: "FormatStyle")
    @available(tvOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "FormatStyle")
    @available(watchOS, deprecated: 8.0, message: "Consider using Apple's API", renamed: "FormatStyle")
    /// Strategies for formatting a `Date`.
    public struct BPFormatStyle {

        internal var dateStyle: DateStyle? = nil
        internal var timeStyle: TimeStyle? = nil
        internal var symbols = SymbolsConfig()

        internal var currentSymbols: SymbolsConfig {
            guard symbols.components.isEmpty else {
                return symbols
            }

            let config = SymbolsConfig(date: dateStyle, time: timeStyle)
            guard config.components.isEmpty else {
                return config
            }

            return SymbolsConfig(year: .defaultDigits,
                                 month: .defaultDigits,
                                 day: .defaultDigits,
                                 hour: .defaultDigits(amPM: .abbreviated),
                                 minute: .twoDigits)
        }

        /// The locale to use when formatting date and time values.
        public var locale: Locale

        /// The time zone with which to specify date and time values.
        public var timeZone: TimeZone

        /// The calendar to use for date values.
        public var calendar: Calendar

        /// The capitalization formatting context used when formatting date and time values.
        public var capitalizationContext: BPFormatStyleCapitalizationContext

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
                    capitalizationContext: BPFormatStyleCapitalizationContext = .unknown) {
            self.dateStyle = date
            self.timeStyle = time
            self.locale = locale
            self.calendar = calendar
            self.timeZone = timeZone
            self.capitalizationContext = capitalizationContext
        }
    }
}

extension Date.BPFormatStyle {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(locale, forKey: .locale)
        try container.encode(timeZone, forKey: .timeZone)
        try container.encode(calendar, forKey: .calendar)
        try container.encode(currentSymbols, forKey: .symbols)
        try container.encode(capitalizationContext, forKey: .capitalizationContext)
    }
}

extension Date.BPFormatStyle: BPFormatStyle {

    private static let dateFormatter = DateFormatter()
    private static let lock = DispatchSemaphore(value: 1)

    /// Creates a `FormatOutput` instance from `value`.
    public func format(_ value: Date) -> String {
        Self.lock.wait()
        Self.dateFormatter.locale = locale
        Self.dateFormatter.calendar = calendar
        Self.dateFormatter.timeZone = timeZone
        Self.dateFormatter.setLocalizedDateFormatFromTemplate(currentSymbols.template)
        Self.dateFormatter.formattingContext = capitalizationContext.option.formatterContext
        let formatted = Self.dateFormatter.string(from: value)
        Self.lock.signal()
        return formatted
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

    public func era(_ format: Date.BPFormatStyle.Symbol.Era = .abbreviated) -> Date.BPFormatStyle {
        var copy = self
        copy.symbols.era = format.value
        return copy
    }

    public func year(_ format: Date.BPFormatStyle.Symbol.Year = .defaultDigits) -> Date.BPFormatStyle {
        var copy = self
        copy.symbols.year = format.value
        return copy
    }

    public func quarter(_ format: Date.BPFormatStyle.Symbol.Quarter = .abbreviated) -> Date.BPFormatStyle {
        var copy = self
        copy.symbols.quarter = format.value
        return copy
    }

    public func month(_ format: Date.BPFormatStyle.Symbol.Month = .abbreviated) -> Date.BPFormatStyle {
        var copy = self
        copy.symbols.month = format.value
        return copy
    }

    public func week(_ format: Date.BPFormatStyle.Symbol.Week = .defaultDigits) -> Date.BPFormatStyle {
        var copy = self
        copy.symbols.week = format.value
        return copy
    }

    public func day(_ format: Date.BPFormatStyle.Symbol.Day = .defaultDigits) -> Date.BPFormatStyle {
        var copy = self
        copy.symbols.day = format.value
        return copy
    }

    public func dayOfYear(_ format: Date.BPFormatStyle.Symbol.DayOfYear = .defaultDigits) -> Date.BPFormatStyle {
        var copy = self
        copy.symbols.dayOfYear = format.value
        return copy
    }

    public func weekday(_ format: Date.BPFormatStyle.Symbol.Weekday = .abbreviated) -> Date.BPFormatStyle {
        var copy = self
        copy.symbols.weekday = format.value
        return copy
    }

    public func hour(_ format: Date.BPFormatStyle.Symbol.Hour = .defaultDigits(amPM: .abbreviated)) -> Date.BPFormatStyle {
        var copy = self
        copy.symbols.hour = format.value
        return copy
    }

    public func minute(_ format: Date.BPFormatStyle.Symbol.Minute = .defaultDigits) -> Date.BPFormatStyle {
        var copy = self
        copy.symbols.minute = format.value
        return copy
    }

    public func second(_ format: Date.BPFormatStyle.Symbol.Second = .defaultDigits) -> Date.BPFormatStyle {
        var copy = self
        copy.symbols.second = format.value
        return copy
    }

    public func secondFraction(_ format: Date.BPFormatStyle.Symbol.SecondFraction) -> Date.BPFormatStyle {
        var copy = self
        copy.symbols.secondFraction = format.value
        return copy
    }

    public func timeZone(_ format: Date.BPFormatStyle.Symbol.TimeZone = .specificName(.short)) -> Date.BPFormatStyle {
        var copy = self
        copy.symbols.timeZoneSymbol = format.value
        return copy
    }
}
