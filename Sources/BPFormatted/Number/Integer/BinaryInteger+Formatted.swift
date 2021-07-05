//
//  BinaryInteger+Formatted.swift
//  
//
//  Created by Simon Salomons on 04/07/2021.
//

import Foundation

extension BinaryInteger {

    @available(iOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(macOS, deprecated: 12.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(tvOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(watchOS, deprecated: 8.0, message: "Consider using Apple's API", renamed: "formatted")
    /// Format `self` using `IntegerFormatStyle()`
    public func bpFormatted() -> String {
        bpFormatted(BPIntegerFormatStyle())
    }

    @available(iOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(macOS, deprecated: 12.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(tvOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(watchOS, deprecated: 8.0, message: "Consider using Apple's API", renamed: "formatted")
    /// Format `self` with the given format.
    public func bpFormatted<S>(_ format: S) -> S.FormatOutput where Self == S.FormatInput, S : BPFormatStyle {
        format.format(self)
    }

    @available(iOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(macOS, deprecated: 12.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(tvOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(watchOS, deprecated: 8.0, message: "Consider using Apple's API", renamed: "formatted")
    /// Format `self` with the given format. `self` is first converted to `S.FormatInput` type, then format with the given format.
    public func bpFormatted<S>(_ format: S) -> S.FormatOutput where S : BPFormatStyle, S.FormatInput : BinaryInteger {
        format.format(self as! S.FormatInput)
    }
}
