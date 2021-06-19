//
//  Range+Formatted.swift
//  
//
//  Created by Simon Salomons on 19/06/2021.
//

import Foundation

extension Range where Bound == Date {

    @available(iOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(macOS, deprecated: 12.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(tvOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(watchOS, deprecated: 8.0, message: "Consider using Apple's API", renamed: "formatted")
    /// Formats the date range using the specified style.
    public func bpFormatted<S>(_ style: S) -> S.FormatOutput where S : BPFormatStyle, S.FormatInput == Range<Date> {
        style.format(self)
    }

    @available(iOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(macOS, deprecated: 12.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(tvOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(watchOS, deprecated: 8.0, message: "Consider using Apple's API", renamed: "formatted")
    /// Formats the date range as an interval.
    public func bpFormatted() -> String {
        bpFormatted(Date.BPIntervalFormatStyle())
    }

    @available(iOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(macOS, deprecated: 12.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(tvOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(watchOS, deprecated: 8.0, message: "Consider using Apple's API", renamed: "formatted")
    public func bpFormatted(date: Date.BPIntervalFormatStyle.DateStyle, time: Date.BPIntervalFormatStyle.TimeStyle) -> String {
        bpFormatted(Date.BPIntervalFormatStyle(date: date, time: time))
    }
}
