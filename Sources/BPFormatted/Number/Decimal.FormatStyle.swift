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
        internal var collection = Decimal.BPFormatStyle.Collection()

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

extension Decimal.BPFormatStyle.Configuration.RoundingRule: RawRepresentable, Codable {
    public typealias RawValue = Int

    public init?(rawValue: Int) {
        switch rawValue {
        case 0:
            self = .toNearestOrAwayFromZero
        case 1:
            self = .toNearestOrEven
        case 2:
            self = .up
        case 3:
            self = .down
        case 4:
            self = .towardZero
        case 5:
            self = .awayFromZero
        default:
            return nil
        }
    }

    public var rawValue: Int {
        switch self {
        case .toNearestOrAwayFromZero:
            return 0
        case .toNearestOrEven:
            return 1
        case .up:
            return 2
        case .down:
            return 3
        case .towardZero:
            return 4
        case .awayFromZero:
            return 5
        @unknown default:
            return 0
        }
    }
}

internal extension Decimal.BPFormatStyle {
    struct Collection: Codable, Hashable {
        var rounding: Configuration.RoundingRule?
        var roundingIncrement: RoundingIncrement?
        var group: Configuration.Grouping?
        var precision: Configuration.Precision?
        var signDisplayStrategy: Configuration.SignDisplayStrategy?
        var decimalSeparatorStrategy: Configuration.DecimalSeparatorDisplayStrategy?
        var scale: Double?
        var notation: Configuration.Notation?
    }
    struct RoundingIncrement: Codable, Hashable {
        var integer: Int
    }
}

extension Decimal.BPFormatStyle: BPFormatStyle {

    internal static let numberFormatter = NumberFormatter()
    private static let lock = DispatchSemaphore(value: 1)

    /// Creates a `FormatOutput` instance from `value`.
    public func format(_ value: Decimal) -> String {
        Self.lock.wait()
        defer { Self.lock.signal() }

        switch collection.notation?.option ?? .automatic {
        case .automatic:
            Self.numberFormatter.numberStyle = .decimal
        case .scientific:
            Self.numberFormatter.numberStyle = .scientific
        case .compactName:
            Self.numberFormatter.numberStyle = .percent
            Self.numberFormatter.perMillSymbol = "k"
        }

        // It's very important that we set the precision before setting the locale... for some reason
        // Otherwise the first result will get unexpected results

        // Precision
        do {
            try Self.numberFormatter.applyPrecision(collection.precision?.option ?? .default, forDecimal: value)
        } catch {
            return ""
        }

        // Locale
        if locale == .autoupdatingCurrent {
            Self.numberFormatter.locale = nil
        } else {
            Self.numberFormatter.locale = locale
        }

        // Sign
        let signStrategy = collection.signDisplayStrategy ?? .automatic
        Self.numberFormatter.negativePrefix = signStrategy.negative == 0 ? Self.numberFormatter.minusSign : ""
        if value == 0 {
            Self.numberFormatter.positivePrefix = signStrategy.zero == 0 ? Self.numberFormatter.plusSign : ""
        } else {
            Self.numberFormatter.positivePrefix = signStrategy.positive == 0 ? Self.numberFormatter.plusSign : ""
        }

        // Grouping
        Self.numberFormatter.usesGroupingSeparator = (collection.group ?? .automatic) == .automatic

        // Decimal Separator
        Self.numberFormatter.alwaysShowsDecimalSeparator = (collection.decimalSeparatorStrategy ?? .automatic) == .always

        // Scale
        if let scale = collection.scale {
            Self.numberFormatter.multiplier = NSNumber(value: scale)
        } else {
            Self.numberFormatter.multiplier = NSNumber(value: 1)
        }

        #warning("🆘 Implement rounded")

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

private extension NumberFormatter {
    enum PrecisionError: Error {
        case maxSignificantTooBig
        case maxFractionalTooBig
        case maxIntegerTooBig
    }

    func applyPrecision(_ precision: Decimal.BPFormatStyle.Configuration.Precision.Option, forDecimal decimal: Decimal) throws {
        switch precision {
        case let .integerAndFraction(maxFractionalLength, minFractionalLength, minIntegerLength, maxIntegerLength):
            try applyIntegerAndFractionPrecision(maxFractional: maxFractionalLength, minFractional: minFractionalLength, minInteger: minIntegerLength, maxInteger: maxIntegerLength, forDecimal: decimal)
        case let .significant(maxSignificantDigits, minSignificantDigits):
            try applySignificantPrecision(maxSignificant: maxSignificantDigits, minSignificant: minSignificantDigits, forDecimal: decimal)
        }
    }

    func applyIntegerAndFractionPrecision(maxFractional: Int?, minFractional: Int?, minInteger: Int?, maxInteger: Int?, forDecimal decimal: Decimal) throws {
        usesSignificantDigits = false
        maximumSignificantDigits = -1
        minimumSignificantDigits = -1

        var maxInteger = maxInteger ?? 999
        let maxFractional = maxFractional ?? 999
        let minInteger = minInteger ?? 0
        let exponent = max(0, -decimal.exponent)

        guard maxInteger < 1_000 else {
            throw PrecisionError.maxIntegerTooBig
        }

        guard maxFractional < 1_000 else {
            throw PrecisionError.maxFractionalTooBig
        }

        if minInteger == 0 && maxInteger == 0 {
            maxInteger = 999
        }

        if maxFractional > exponent {
            maximumFractionDigits = minFractional ?? .max
        } else {
            maximumFractionDigits = maxFractional
        }
        minimumFractionDigits = minFractional ?? 0
        minimumIntegerDigits = max(minInteger, 1)
        maximumIntegerDigits = maxInteger
    }

    func applySignificantPrecision(maxSignificant: Int?, minSignificant: Int, forDecimal decimal: Decimal) throws {
        usesSignificantDigits = true

        guard let maxSignificant = maxSignificant,
            maxSignificant > 0 else {
            try applyIntegerAndFractionPrecision(maxFractional: nil, minFractional: nil, minInteger: nil, maxInteger: nil, forDecimal: decimal)
            return
        }

        guard maxSignificant < 1_000 else {
            throw PrecisionError.maxSignificantTooBig
        }

        maximumSignificantDigits = maxSignificant
        minimumSignificantDigits = minSignificant
    }
}
