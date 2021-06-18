//
//  Date+BPISO8601FormatStyle.swift
//  
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
extension Date {

    /// Options for generating and parsing string representations of dates following the ISO 8601 standard.
    public struct BPISO8601FormatStyle {

        public enum TimeZoneSeparator: String, Codable {
            case colon = ":"
            case omitted = ""

            fileprivate var options: ISO8601DateFormatter.Options {
                switch self {
                case .colon:
                    return .withColonSeparatorInTimeZone
                case .omitted:
                    return []
                }
            }
        }

        public enum DateSeparator: String, Codable {
            case dash = "-"
            case omitted = ""

            fileprivate var options: ISO8601DateFormatter.Options {
                switch self {
                case .dash:
                    return .withDashSeparatorInDate
                case .omitted:
                    return []
                }
            }
        }

        public enum TimeSeparator: String, Codable {
            case colon = ":"
            case omitted = ""

            fileprivate var options: ISO8601DateFormatter.Options {
                switch self {
                case .colon:
                    return .withColonSeparatorInTime
                case .omitted:
                    return []
                }
            }
        }

        public enum DateTimeSeparator: String, Codable {
            case space = " "
            case standard = "T"

            fileprivate var options: ISO8601DateFormatter.Options {
                switch self {
                case .space:
                    return .withSpaceBetweenDateAndTime
                case .standard:
                    return []
                }
            }
        }

        internal enum Option: Int, Hashable, Codable {
            case year
            case weekOfYear
            case month
            case day
            case time
            case timeZone

            var dateFormatterOption: ISO8601DateFormatter.Options {
                switch self {
                case .year:
                    return .withYear
                case .weekOfYear:
                    return .withWeekOfYear
                case .month:
                    return .withMonth
                case .day:
                    return .withDay
                case .time:
                    return .withTime
                case .timeZone:
                    return .withTimeZone
                }
            }
        }

        internal(set) public var dateSeparator: DateSeparator

        internal(set) public var dateTimeSeparator: DateTimeSeparator

        internal var timeSeparator: TimeSeparator = .omitted

        internal var timeZoneSeparator: TimeZoneSeparator = .omitted

        internal var _formatFields = Set<Option>()

        internal var includingFractionalSeconds = false

        /// The time zone to use to create and parse date representations.
        public var timeZone: TimeZone

        public init(dateSeparator: DateSeparator = .omitted,
                    dateTimeSeparator: DateTimeSeparator = .standard,
                    timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
            self.dateSeparator = dateSeparator
            self.dateTimeSeparator = dateTimeSeparator
            self.timeZone = timeZone
        }
    }
}

@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
extension Date.BPISO8601FormatStyle {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_formatFields, forKey: ._formatFields)
        try container.encode(timeZone, forKey: .timeZone)
        try container.encode(dateSeparator, forKey: .dateSeparator)
        try container.encode(includingFractionalSeconds, forKey: .includingFractionalSeconds)
        try container.encode(timeSeparator, forKey: .timeSeparator)
        try container.encode(timeZoneSeparator, forKey: .timeZoneSeparator)
        try container.encode(dateTimeSeparator, forKey: .dateTimeSeparator)
    }
}

@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
extension Date.BPISO8601FormatStyle : BPFormatStyle {

    private static var dateFormatter = ISO8601DateFormatter()

    /// Creates a `FormatOutput` instance from `value`.
    public func format(_ value: Date) -> String {
        Self.dateFormatter.timeZone = timeZone
        var options: ISO8601DateFormatter.Options
        if _formatFields.isEmpty {
            options = [.withYear, .withMonth, .withDay, .withTime, .withTimeZone]
        } else {
            options = _formatFields.reduce(into: [], { $0.formUnion($1.dateFormatterOption) })
        }
        options.formUnion(dateSeparator.options)
        options.formUnion(dateTimeSeparator.options)
        options.formUnion(timeZoneSeparator.options)
        options.formUnion(timeSeparator.options)
        if #available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *) {
            if includingFractionalSeconds {
                options.formUnion(.withFractionalSeconds)
            }
        }
        Self.dateFormatter.formatOptions = options
        return Self.dateFormatter.string(from: value)
    }

    /// The type of data to format.
    public typealias FormatInput = Date

    /// The type of the formatted data.
    public typealias FormatOutput = String
}

@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
extension Date.BPISO8601FormatStyle {

    public func year() -> Date.BPISO8601FormatStyle {
        var copy = self
        copy._formatFields.insert(.year)
        return copy
    }

    public func weekOfYear() -> Date.BPISO8601FormatStyle {
        var copy = self
        copy._formatFields.insert(.weekOfYear)
        return copy
    }

    public func month() -> Date.BPISO8601FormatStyle {
        var copy = self
        copy._formatFields.insert(.month)
        return copy
    }

    public func day() -> Date.BPISO8601FormatStyle {
        var copy = self
        copy._formatFields.insert(.day)
        return copy
    }

    public func time(includingFractionalSeconds: Bool) -> Date.BPISO8601FormatStyle {
        var copy = self
        copy._formatFields.insert(.time)
        copy.includingFractionalSeconds = includingFractionalSeconds
        return copy
    }

    public func timeZone(separator: Date.BPISO8601FormatStyle.TimeZoneSeparator) -> Date.BPISO8601FormatStyle {
        var copy = self
        copy._formatFields.insert(.timeZone)
        copy.timeZoneSeparator = separator
        return copy
    }

    public func dateSeparator(_ separator: Date.BPISO8601FormatStyle.DateSeparator) -> Date.BPISO8601FormatStyle {
        var copy = self
        copy.dateSeparator = separator
        return copy
    }

    public func dateTimeSeparator(_ separator: Date.BPISO8601FormatStyle.DateTimeSeparator) -> Date.BPISO8601FormatStyle {
        var copy = self
        copy.dateTimeSeparator = separator
        return copy
    }

    public func timeSeparator(_ separator: Date.BPISO8601FormatStyle.TimeSeparator) -> Date.BPISO8601FormatStyle {
        var copy = self
        copy.timeSeparator = separator
        return copy
    }

    public func timeZoneSeparator(_ separator: Date.BPISO8601FormatStyle.TimeZoneSeparator) -> Date.BPISO8601FormatStyle {
        var copy = self
        copy.timeZoneSeparator = separator
        return copy
    }
}
