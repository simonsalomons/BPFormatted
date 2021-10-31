//
//  IntegerFormatStyle.swift
//  
//
//  Created by Simon Salomons on 04/07/2021.
//

import Foundation

@available(iOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "IntegerFormatStyle")
@available(macOS, deprecated: 12.0, message: "Consider using Apple's API", renamed: "IntegerFormatStyle")
@available(tvOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "IntegerFormatStyle")
@available(watchOS, deprecated: 8.0, message: "Consider using Apple's API", renamed: "IntegerFormatStyle")
public struct BPIntegerFormatStyle<Value>: Codable, Hashable where Value: BinaryInteger {

    public var locale: Locale
    internal var collection = BPNumberFormatStyleCollection()

    public init(locale: Locale = .autoupdatingCurrent) {
        self.locale = locale
    }

    public typealias Configuration = BPNumberFormatStyleConfiguration

    public func grouping(_ group: BPIntegerFormatStyle<Value>.Configuration.Grouping) -> BPIntegerFormatStyle<Value> {
        var copy = self
        copy.collection.group = group
        return copy
    }

    public func precision(_ p: BPIntegerFormatStyle<Value>.Configuration.Precision) -> BPIntegerFormatStyle<Value> {
        var copy = self
        copy.collection.precision = p
        return copy
    }

    public func sign(strategy: BPIntegerFormatStyle<Value>.Configuration.SignDisplayStrategy) -> BPIntegerFormatStyle<Value> {
        var copy = self
        copy.collection.signDisplayStrategy = strategy
        return copy
    }

    public func decimalSeparator(strategy: BPIntegerFormatStyle<Value>.Configuration.DecimalSeparatorDisplayStrategy) -> BPIntegerFormatStyle<Value> {
        var copy = self
        copy.collection.decimalSeparatorStrategy = strategy
        return copy
    }

    // Excluded for now since I cannot seem to replicate the same results as Apple
    /*
    public func rounded(rule: Configuration.RoundingRule = .toNearestOrEven, increment: Int? = nil) -> BPIntegerFormatStyle {
        var copy = self
        copy.collection.rounding = rule
        copy.collection.roundingIncrement = increment.map({ RoundingIncrement(integer: $0) })
        return copy
    }
     */

    public func scale(_ multiplicand: Double) -> BPIntegerFormatStyle<Value> {
        var copy = self
        copy.collection.scale = multiplicand
        return copy
    }

    public func notation(_ notation: BPIntegerFormatStyle<Value>.Configuration.Notation) -> BPIntegerFormatStyle<Value> {
        var copy = self
        copy.collection.notation = notation
        return copy
    }
}

private var numberFormatter = NumberFormatter()
private var lastFormatAppliedPrecision = false
private let lock = DispatchSemaphore(value: 1)

extension BPIntegerFormatStyle: BPFormatStyle {

    /// Creates a `FormatOutput` instance from `value`.
    public func format(_ value: Value) -> String {
        lock.wait()
        defer { lock.signal() }

        if lastFormatAppliedPrecision && collection.precision == nil {
            numberFormatter = NumberFormatter()
        } else if collection.precision != nil {
            lastFormatAppliedPrecision = true
        }

        do {
            try numberFormatter.applyFormat(collection, locale: locale, value: value, applyPrecisionIfOmitted: false)
        } catch {
            return "\(value)"
        }

        return numberFormatter.string(from: value) ?? "\(value)"
    }

    /// If the format allows selecting a locale, returns a copy of this format with the new locale set. Default implementation returns an unmodified self.
    public func locale(_ locale: Locale) -> BPIntegerFormatStyle {
        var copy = self
        copy.locale = locale
        return copy
    }

    /// The type of data to format.
    public typealias FormatInput = Value

    /// The type of the formatted data.
    public typealias FormatOutput = String
}
