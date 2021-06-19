//
//  Date.IntervalFormatStyle.swift
//  
//
//  Created by Simon Salomons on 19/06/2021.
//

import Foundation

extension Date {

    @available(iOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "IntervalFormatStyle")
    @available(macOS, deprecated: 12.0, message: "Consider using Apple's API", renamed: "IntervalFormatStyle")
    @available(tvOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "IntervalFormatStyle")
    @available(watchOS, deprecated: 8.0, message: "Consider using Apple's API", renamed: "IntervalFormatStyle")
    /// Strategies for formatting a `Range<Date>`
    public struct BPIntervalFormatStyle: Codable, Hashable {

        public typealias DateStyle = Date.BPFormatStyle.DateStyle
        public typealias TimeStyle = Date.BPFormatStyle.TimeStyle
        internal typealias SymbolsConfig = Date.BPFormatStyle.SymbolsConfig

        public var locale: Locale
        public var timeZone: TimeZone
        public var calendar: Calendar
        public var dateStyle: DateStyle?
        public var timeStyle: TimeStyle?

        internal var symbols = SymbolsConfig()

        internal var currentSymbols: SymbolsConfig {
            if !symbols.components.isEmpty {
                return symbols
            } else {
                let config = SymbolsConfig(date: dateStyle, time: timeStyle)
                if !config.components.isEmpty {
                    return config
                } else {
                    return SymbolsConfig(year: .twoDigits,
                                         month: .defaultDigits,
                                         day: .defaultDigits,
                                         hour: .defaultDigits(amPM: .abbreviated),
                                         minute: .twoDigits)
                }
            }
        }

        /// Creates a new `FormatStyle` with the given configurations.
        /// - Parameters:
        ///   - date: The style for formatting the date part of the given date pairs. Note that if `.omitted` is specified, but the date interval spans more than one day, a locale-specific fallback will be used.
        ///   - time: The style for formatting the time part of the given date pairs.
        ///   - locale: The locale to use when formatting date and time values.
        ///   - calendar: The calendar to use for date values.
        ///   - timeZone: The time zone with which to specify date and time values.
        /// - Important: Always specify the date length, time length, or the date components to be included in the formatted string with the symbol modifiers. Otherwise, an empty string will be returned when you use the instance to format an object.
        /// - Note: If specifying the date fields, and the `DateInterval` range is larger than the specified units, a locale-specific fallback will be used.
        ///     - Example: for the range 2010-03-04 07:56 - 2010-03-08 16:11 (4 days, 8 hours, 15 minutes), specifying `.hour().minute()` will produce
        ///         - for en_US, "3/4/2010 7:56 AM - 3/8/2010 4:11 PM"
        ///         - for en_GB, "4/3/2010 7:56 - 8/3/2010 16:11"
        public init(date: Date.BPIntervalFormatStyle.DateStyle? = nil,
                    time: Date.BPIntervalFormatStyle.TimeStyle? = nil,
                    locale: Locale = .autoupdatingCurrent,
                    calendar: Calendar = .autoupdatingCurrent,
                    timeZone: TimeZone = .autoupdatingCurrent) {
            self.dateStyle = date
            self.timeStyle = time
            self.locale = locale
            self.calendar = calendar
            self.timeZone = timeZone
        }
    }
}

extension Date.BPIntervalFormatStyle {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(locale, forKey: .locale)
        try container.encode(timeZone, forKey: .timeZone)
        try container.encode(calendar, forKey: .calendar)
        try container.encode(currentSymbols, forKey: .symbols)
        try container.encodeIfPresent(timeStyle, forKey: .timeStyle)
        try container.encodeIfPresent(dateStyle, forKey: .dateStyle)
    }
}

extension Date.BPIntervalFormatStyle: BPFormatStyle {

    private static let intervalFormatter = DateIntervalFormatter()
    private static let lock = DispatchSemaphore(value: 1)

    /// Creates a `FormatOutput` instance from `value`.
    public func format(_ v: Range<Date>) -> String {
        Self.lock.wait()
        Self.intervalFormatter.locale = locale
        Self.intervalFormatter.calendar = calendar
        Self.intervalFormatter.timeZone = timeZone
        Self.intervalFormatter.dateTemplate = currentSymbols.template
        let formatted = Self.intervalFormatter.string(from: v.lowerBound, to: v.upperBound)
        Self.lock.signal()
        return formatted
    }

    /// If the format allows selecting a locale, returns a copy of this format with the new locale set. Default implementation returns an unmodified self.
    public func locale(_ locale: Locale) -> Date.BPIntervalFormatStyle {
        var copy = self
        copy.locale = locale
        return copy
    }

    /// The type of data to format.
    public typealias FormatInput = Range<Date>

    /// The type of the formatted data.
    public typealias FormatOutput = String
}

extension Date.BPIntervalFormatStyle {

    public typealias Symbol = Date.BPFormatStyle.Symbol

    public func year() -> Date.BPIntervalFormatStyle {
        var copy = self
        copy.symbols.year = Symbol.Year.defaultDigits.value
        return copy
    }

    public func month(_ format: Date.BPIntervalFormatStyle.Symbol.Month = .abbreviated) -> Date.BPIntervalFormatStyle {
        var copy = self
        copy.symbols.month = format.value
        return copy
    }

    public func day() -> Date.BPIntervalFormatStyle {
        var copy = self
        copy.symbols.day = Symbol.Day.defaultDigits.value
        return copy
    }

    public func weekday(_ format: Date.BPIntervalFormatStyle.Symbol.Weekday = .abbreviated) -> Date.BPIntervalFormatStyle {
        var copy = self
        copy.symbols.weekday = format.value
        return copy
    }

    public func hour(_ format: Date.BPIntervalFormatStyle.Symbol.Hour = .defaultDigits(amPM: .abbreviated)) -> Date.BPIntervalFormatStyle {
        var copy = self
        copy.symbols.hour = format.value
        return copy
    }

    public func minute() -> Date.BPIntervalFormatStyle {
        var copy = self
        copy.symbols.minute = Symbol.Minute.defaultDigits.value
        return copy
    }

    public func second() -> Date.BPIntervalFormatStyle {
        var copy = self
        copy.symbols.second = Symbol.Second.defaultDigits.value
        return copy
    }

    public func timeZone(_ format: Date.BPIntervalFormatStyle.Symbol.TimeZone = .genericName(.short)) -> Date.BPIntervalFormatStyle {
        var copy = self
        copy.symbols.timeZoneSymbol = format.value
        return copy
    }
}
