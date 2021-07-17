//
//  FloatingPointFormatStyle.swift
//  
//
//  Created by Simon Salomons on 05/07/2021.
//

import Foundation

@available(iOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "FloatingPointFormatStyle")
@available(macOS, deprecated: 12.0, message: "Consider using Apple's API", renamed: "FloatingPointFormatStyle")
@available(tvOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "FloatingPointFormatStyle")
@available(watchOS, deprecated: 8.0, message: "Consider using Apple's API", renamed: "FloatingPointFormatStyle")
public struct BPFloatingPointFormatStyle : Codable, Hashable {

    public var locale: Locale
    internal var collection = BPNumberFormatStyleCollection()

    public init(locale: Locale = .current) {
        self.locale = locale
    }

    public typealias Configuration = BPNumberFormatStyleConfiguration

    public func grouping(_ group: Configuration.Grouping) -> BPFloatingPointFormatStyle {
        var copy = self
        copy.collection.group = group
        return copy
    }

    public func precision(_ p: Configuration.Precision) -> BPFloatingPointFormatStyle {
        var copy = self
        copy.collection.precision = p
        return copy
    }

    public func sign(strategy: Configuration.SignDisplayStrategy) -> BPFloatingPointFormatStyle {
        var copy = self
        copy.collection.signDisplayStrategy = strategy
        return copy
    }

    public func decimalSeparator(strategy: Configuration.DecimalSeparatorDisplayStrategy) -> BPFloatingPointFormatStyle {
        var copy = self
        copy.collection.decimalSeparatorStrategy = strategy
        return copy
    }

    // Excluded for now since I cannot seem to replicate the same results as Apple
    /*
    public func rounded(rule: Configuration.RoundingRule = .toNearestOrEven, increment: Double? = nil) -> BPFloatingPointFormatStyle {
        var copy = self
        copy.collection.rounding = rule
        copy.collection.roundingIncrement = increment.map({ RoundingIncrement(integer: $0) })
        return copy
    }
     */

    public func scale(_ multiplicand: Double) -> BPFloatingPointFormatStyle {
        var copy = self
        copy.collection.scale = multiplicand
        return copy
    }

    public func notation(_ notation: Configuration.Notation) -> BPFloatingPointFormatStyle {
        var copy = self
        copy.collection.notation = notation
        return copy
    }
}

extension BPFloatingPointFormatStyle: BPFormatStyle {

    private static let numberFormatter = NumberFormatter()
    private static let lock = DispatchSemaphore(value: 1)

    /// Creates a `FormatOutput` instance from `value`.
    public func format(_ value: Double) -> String {
        Self.lock.wait()
        defer { Self.lock.signal() }

        do {
            try Self.numberFormatter.applyFormat(collection, locale: locale, value: Decimal(value), applyPrecisionIfOmitted: true)
        } catch {
            return "\(value)"
        }

        let number = NSNumber(value: value)
        return Self.numberFormatter.string(from: number) ?? "\(value)"
    }

    /// If the format allows selecting a locale, returns a copy of this format with the new locale set. Default implementation returns an unmodified self.
    public func locale(_ locale: Locale) -> BPFloatingPointFormatStyle {
        var copy = self
        copy.locale = locale
        return copy
    }

    /// The type of data to format.
    public typealias FormatInput = Double

    /// The type of the formatted data.
    public typealias FormatOutput = String
}
