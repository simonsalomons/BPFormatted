//
//  Decimal.FormatStyle.swift
//  
//
//  Created by Simon Salomons on 19/06/2021.
//

import Foundation

extension Decimal {

    @available(iOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "FormatStyle")
    @available(macOS, deprecated: 12.0, message: "Consider using Apple's API", renamed: "FormatStyle")
    @available(tvOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "FormatStyle")
    @available(watchOS, deprecated: 8.0, message: "Consider using Apple's API", renamed: "FormatStyle")
    public struct BPFormatStyle {

        public var locale: Locale
        internal var collection = BPNumberFormatStyleCollection()

        public init(locale: Locale = .autoupdatingCurrent) {
            self.locale = locale
        }

        public typealias Configuration = BPNumberFormatStyleConfiguration

        public func grouping(_ group: Decimal.BPFormatStyle.Configuration.Grouping) -> Decimal.BPFormatStyle {
            var copy = self
            copy.collection.group = group
            return copy
        }

        public func precision(_ p: Decimal.BPFormatStyle.Configuration.Precision) -> Decimal.BPFormatStyle {
            var copy = self
            copy.collection.precision = p
            return copy
        }

        public func sign(strategy: Decimal.BPFormatStyle.Configuration.SignDisplayStrategy) -> Decimal.BPFormatStyle {
            var copy = self
            copy.collection.signDisplayStrategy = strategy
            return copy
        }

        public func decimalSeparator(strategy: Decimal.BPFormatStyle.Configuration.DecimalSeparatorDisplayStrategy) -> Decimal.BPFormatStyle {
            var copy = self
            copy.collection.decimalSeparatorStrategy = strategy
            return copy
        }

        // Excluded for now since I cannot seem to replicate the same results as Apple
        /*
        public func rounded(rule: Decimal.BPFormatStyle.Configuration.RoundingRule = .toNearestOrEven, increment: Int? = nil) -> Decimal.BPFormatStyle {
            var copy = self
            copy.collection.rounding = rule
            copy.collection.roundingIncrement = increment.map({ RoundingIncrement(integer: $0) })
            return copy
        }
         */

        public func scale(_ multiplicand: Double) -> Decimal.BPFormatStyle {
            var copy = self
            copy.collection.scale = multiplicand
            return copy
        }

        public func notation(_ notation: Decimal.BPFormatStyle.Configuration.Notation) -> Decimal.BPFormatStyle {
            var copy = self
            copy.collection.notation = notation
            return copy
        }
    }
}

extension Decimal.BPFormatStyle: BPFormatStyle {

    private static let numberFormatter = NumberFormatter()
    private static let lock = DispatchSemaphore(value: 1)

    /// Creates a `FormatOutput` instance from `value`.
    public func format(_ value: Decimal) -> String {
        Self.lock.wait()
        defer { Self.lock.signal() }

        do {
            try Self.numberFormatter.applyFormat(collection, locale: locale, value: value, applyPrecisionIfOmitted: true)
        } catch {
            return "\(value)"
        }

        let number = NSDecimalNumber(decimal: value)
        return Self.numberFormatter.string(from: number) ?? "\(value)"
    }

    /// If the format allows selecting a locale, returns a copy of this format with the new locale set. Default implementation returns an unmodified self.
    public func locale(_ locale: Locale) -> Decimal.BPFormatStyle {
        var copy = self
        copy.locale = locale
        return copy
    }

    /// The type of data to format.
    public typealias FormatInput = Decimal

    /// The type of the formatted data.
    public typealias FormatOutput = String
}
