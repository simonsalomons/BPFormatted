//
//  Date.RelativeFormatStyle.swift
//  
//
//  Created by Simon Salomons on 19/06/2021.
//

import Foundation

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Date {

    @available(iOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "RelativeFormatStyle")
    @available(macOS, deprecated: 12.0, message: "Consider using Apple's API", renamed: "RelativeFormatStyle")
    @available(tvOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "RelativeFormatStyle")
    @available(watchOS, deprecated: 8.0, message: "Consider using Apple's API", renamed: "RelativeFormatStyle")
    public struct BPRelativeFormatStyle: Codable, Hashable {

        public struct UnitsStyle : Codable, Hashable {

            internal var option: Option

            /// "2 months ago", "next Wednesday"
            public static var wide: Date.BPRelativeFormatStyle.UnitsStyle {
                UnitsStyle(option: .wide)
            }

            /// "two months ago", "next Wednesday"
            public static var spellOut: Date.BPRelativeFormatStyle.UnitsStyle {
                UnitsStyle(option: .spellOut)
            }

            /// "2 mo. ago", "next Wed."
            public static var abbreviated: Date.BPRelativeFormatStyle.UnitsStyle {
                UnitsStyle(option: .abbreviated)
            }

            /// "2 mo. ago", "next W"
            public static var narrow: Date.BPRelativeFormatStyle.UnitsStyle {
                UnitsStyle(option: .narrow)
            }

            internal enum Option: Int, Codable, Hashable {
                case wide
                case spellOut
                case abbreviated
                case narrow

                var formatterStyle: RelativeDateTimeFormatter.UnitsStyle {
                    switch self {
                    case .wide:
                        return .full
                    case .spellOut:
                        return .spellOut
                    case .abbreviated:
                        return .short
                    case .narrow:
                        return .abbreviated
                    }
                }
            }
        }

        public struct Presentation : Codable, Hashable {

            internal var option: Option

            /// "1 day ago", "2 days ago", "1 week ago", "in 1 week"
            public static var numeric: Date.BPRelativeFormatStyle.Presentation {
                Presentation(option: .numeric)
            }

            /// "yesterday", "2 days ago", "last week", "next week"; falls back to the numeric style if no name is available.
            public static var named: Date.BPRelativeFormatStyle.Presentation {
                Presentation(option: .named)
            }

            internal enum Option: Int, Codable, Hashable {
                case numeric
                case named

                var formatterStyle: RelativeDateTimeFormatter.DateTimeStyle {
                    switch self {
                    case .numeric:
                        return .numeric
                    case .named:
                        return .named
                    }
                }
            }
        }

        public var presentation: Date.BPRelativeFormatStyle.Presentation
        public var unitsStyle: Date.BPRelativeFormatStyle.UnitsStyle
        public var capitalizationContext: FormatStyleCapitalizationContext
        public var locale: Locale
        public var calendar: Calendar

        public init(presentation: Date.BPRelativeFormatStyle.Presentation = .numeric,
                    unitsStyle: Date.BPRelativeFormatStyle.UnitsStyle = .wide,
                    locale: Locale = .autoupdatingCurrent,
                    calendar: Calendar = .autoupdatingCurrent,
                    capitalizationContext: FormatStyleCapitalizationContext = .unknown) {
            self.presentation = presentation
            self.unitsStyle = unitsStyle
            self.locale = locale
            self.calendar = calendar
            self.capitalizationContext = capitalizationContext
        }
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Date.BPRelativeFormatStyle: BPFormatStyle {

    private static let relativeFormatter = RelativeDateTimeFormatter()
    private static let lock = DispatchSemaphore(value: 1)

    /// Creates a `FormatOutput` instance from `value`.
    public func format(_ destDate: Date) -> String {
        Self.lock.wait()
        Self.relativeFormatter.locale = locale
        Self.relativeFormatter.calendar = calendar
        Self.relativeFormatter.unitsStyle = unitsStyle.option.formatterStyle
        Self.relativeFormatter.dateTimeStyle = presentation.option.formatterStyle
        Self.relativeFormatter.formattingContext = capitalizationContext.option.formatterContext
        let formatted = Self.relativeFormatter.localizedString(fromTimeInterval: destDate.timeIntervalSinceNow + 1)
//        let formatted = Self.relativeFormatter.localizedString(for: destDate, relativeTo: Date())
        Self.lock.signal()
        return formatted
    }

    /// If the format allows selecting a locale, returns a copy of this format with the new locale set. Default implementation returns an unmodified self.
    public func locale(_ locale: Locale) -> Date.BPRelativeFormatStyle {
        var copy = self
        copy.locale = locale
        return copy
    }

    /// The type of data to format.
    public typealias FormatInput = Date

    /// The type of the formatted data.
    public typealias FormatOutput = String
}
