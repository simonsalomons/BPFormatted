//
//  Decimal+Formatted.swift
//  
//
//  Created by Simon Salomons on 27/06/2021.
//

import Foundation

extension Decimal {

    @available(iOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(macOS, deprecated: 12.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(tvOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(watchOS, deprecated: 8.0, message: "Consider using Apple's API", renamed: "formatted")
    /// Format `self` using `Decimal.FormatStyle`
    public func bpFormatted() -> String {
        bpFormatted(BPFormatStyle())
    }

    @available(iOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(macOS, deprecated: 12.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(tvOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "formatted")
    @available(watchOS, deprecated: 8.0, message: "Consider using Apple's API", renamed: "formatted")
    /// Format `self` with the given format.
    public func bpFormatted<S>(_ format: S) -> S.FormatOutput where S : BPFormatted.BPFormatStyle, S.FormatInput == Decimal {
        format.format(self)
    }
}
