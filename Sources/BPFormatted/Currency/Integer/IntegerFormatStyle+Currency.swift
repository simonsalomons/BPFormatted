//
//  IntegerFormatStyle+Currency.swift
//
//  Created by Simon Salomons on 17/07/2021.
//

import Foundation

@available(iOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "IntegerFormatStyle")
@available(macOS, deprecated: 12.0, message: "Consider using Apple's API", renamed: "IntegerFormatStyle")
@available(tvOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "IntegerFormatStyle")
@available(watchOS, deprecated: 8.0, message: "Consider using Apple's API", renamed: "IntegerFormatStyle")
extension BPIntegerFormatStyle {

    public struct Currency: Codable, Hashable {

        public typealias Configuration = BPCurrencyFormatStyleConfiguration

        public var locale: Locale
        public let currencyCode: String
        internal var collection = BPCurrencyFormatStyleCollection()

        public init(code: String, locale: Locale = .autoupdatingCurrent) {
            self.currencyCode = code
            self.locale = locale
        }

        public func grouping(_ group: Configuration.Grouping) -> Currency {
            var copy = self
            copy.collection.group = group
            return copy
        }

        public func precision(_ p: Configuration.Precision) -> Currency {
            var copy = self
            copy.collection.precision = p
            return copy
        }

        public func sign(strategy: Configuration.SignDisplayStrategy) -> Currency {
            var copy = self
            copy.collection.signDisplayStrategy = strategy
            return copy
        }

        public func decimalSeparator(strategy: Configuration.DecimalSeparatorDisplayStrategy) -> Currency {
            var copy = self
            copy.collection.decimalSeparatorStrategy = strategy
            return copy
        }

        // Excluded for now since I cannot seem to replicate the same results as Apple
        /*
        public func rounded(rule: Configuration.RoundingRule = .toNearestOrEven, increment: Int? = nil) -> Currency {
            var copy = self
            copy.collection.rounding = rule
            copy.collection.roundingIncrement = increment.map({ RoundingIncrement(integer: $0) })
            return copy
        }
        */

        public func scale(_ multiplicand: Double) -> Currency {
            var copy = self
            copy.collection.scale = multiplicand
            return copy
        }

        public func presentation(_ p: Configuration.Presentation) -> Currency {
            var copy = self
            copy.collection.presentation = p
            return copy
        }
    }
}

private let numberFormatter = NumberFormatter()
private let lock = DispatchSemaphore(value: 1)

extension BPIntegerFormatStyle.Currency: BPFormatStyle {

    /// Creates a `FormatOutput` instance from `value`.
    public func format(_ value: Value) -> String {
        lock.wait()
        defer { lock.signal() }

        numberFormatter.currencyCode = currencyCode

        do {
            try numberFormatter.applyFormat(collection, locale: locale, value: value, applyPrecisionIfOmitted: false)
        } catch {
            return "\(value)"
        }

        return numberFormatter.string(from: value) ?? "\(value)"
    }

    /// If the format allows selecting a locale, returns a copy of this format with the new locale set. Default implementation returns an unmodified self.
    public func locale(_ locale: Locale) -> BPIntegerFormatStyle.Currency {
        var copy = self
        copy.locale = locale
        return copy
    }

    /// The type of data to format.
    public typealias FormatInput = Value

    /// The type of the formatted data.
    public typealias FormatOutput = String
}
