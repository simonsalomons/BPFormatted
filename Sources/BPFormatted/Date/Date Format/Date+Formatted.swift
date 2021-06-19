//
//  Date+Formatted.swift
//  
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

extension Date {

    @available(iOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(macOS, deprecated: 12.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(tvOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(watchOS, deprecated: 8.0, message: "Consider using Apple's API", renamed: "formatted")
    /// Converts `self` to its textual representation.
    /// - Parameter format: The format for formatting `self`.
    /// - Returns: A representation of `self` using the given `format`. The type of the representation is specified by `FormatStyle.FormatOutput`.
    public func bpFormatted<F>(_ format: F) -> String where F: BPFormatted.BPFormatStyle, F.FormatInput == Date, F.FormatOutput == String {
        format.format(self)
    }

    @available(iOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(macOS, deprecated: 12.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(tvOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(watchOS, deprecated: 8.0, message: "Consider using Apple's API", renamed: "formatted")
    /// Converts `self` to its textual representation that contains both the date and time parts. The exact format depends on the user's preferences.
    /// - Parameters:
    ///   - date: The style for describing the date part.
    ///   - time: The style for describing the time part.
    /// - Returns: A `String` describing `self`.
    public func bpFormatted(date: Date.BPFormatStyle.DateStyle, time: Date.BPFormatStyle.TimeStyle) -> String {
        bpFormatted(BPFormatStyle(date: date, time: time))
    }

    @available(iOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(macOS, deprecated: 12.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(tvOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(watchOS, deprecated: 8.0, message: "Consider using Apple's API", renamed: "formatted")
    public func bpFormatted() -> String {
        bpFormatted(BPFormatStyle())
    }
}
