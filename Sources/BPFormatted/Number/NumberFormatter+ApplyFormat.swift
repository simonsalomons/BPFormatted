//
//  NumberFormatter+ApplyPrecision.swift
//  
//
//  Created by Simon Salomons on 04/07/2021.
//

import Foundation

internal extension NumberFormatter {
    enum PrecisionError: Error {
        case maxSignificantTooBig
        case maxFractionalTooBig
        case maxIntegerTooBig
    }

    func applyFormat(_ collection: BPNumberFormatStyleCollection, locale: Locale, value: Decimal, applyPrecisionIfOmitted: Bool) throws {
        // Notation
        switch collection.notation?.option ?? .automatic {
        case .automatic:
            self.numberStyle = .decimal
        case .scientific:
            self.numberStyle = .scientific
        case .compactName:
            fatalError("compactName not supported")
        }

        // It's very important that we set the precision before setting the locale... for some reason
        // Otherwise the first result will get unexpected results

        // Precision
        if applyPrecisionIfOmitted || collection.precision != nil {
            try self.applyPrecision(collection.precision?.option ?? .default, forDecimal: value)
        }

        // Locale
        if locale == .autoupdatingCurrent {
            self.locale = nil
        } else {
            self.locale = locale
        }

        // Sign
        let signStrategy = collection.signDisplayStrategy ?? .automatic
        self.negativePrefix = signStrategy.negative == 0 ? self.minusSign : ""
        if value == 0 {
            self.positivePrefix = signStrategy.zero == 0 ? self.plusSign : ""
        } else {
            self.positivePrefix = signStrategy.positive == 0 ? self.plusSign : ""
        }

        // Grouping
        self.usesGroupingSeparator = (collection.group ?? .automatic) == .automatic

        // Decimal Separator
        self.alwaysShowsDecimalSeparator = (collection.decimalSeparatorStrategy ?? .automatic) == .always

        // Scale
        if let scale = collection.scale {
            self.multiplier = NSNumber(value: scale)
        } else {
            self.multiplier = NSNumber(value: 1)
        }

        #warning("🆘 Implement rounded")
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
        let minInteger = minInteger ?? 0
        let defaultDecimalPlaces = getNumberOfDecimalPlaces(decimal as NSDecimalNumber)

        guard maxInteger < 1_000 else {
            throw PrecisionError.maxIntegerTooBig
        }

        if minInteger == 0 && maxInteger == 0 {
            maxInteger = 999
        }

        if let maxFractional = maxFractional {
            guard maxFractional < 1_000 else {
                throw PrecisionError.maxFractionalTooBig
            }
            maximumFractionDigits = min(maxFractional, defaultDecimalPlaces)
        } else {
            maximumFractionDigits = defaultDecimalPlaces
        }

        minimumFractionDigits = minFractional ?? 0
        minimumIntegerDigits = max(minInteger, 1)
        maximumIntegerDigits = maxInteger
    }

    func applySignificantPrecision(maxSignificant: Int?, minSignificant: Int, forDecimal decimal: Decimal) throws {
        usesSignificantDigits = true

        let maxSignificant = maxSignificant ?? 999
        guard maxSignificant > 0 else {
            try applyIntegerAndFractionPrecision(maxFractional: nil, minFractional: nil, minInteger: nil, maxInteger: nil, forDecimal: decimal)
            return
        }

        guard maxSignificant < 1_000 else {
            throw PrecisionError.maxSignificantTooBig
        }

        maximumSignificantDigits = maxSignificant
        minimumSignificantDigits = minSignificant
    }

    private static let decimalPlacesFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = "."
        formatter.minimumIntegerDigits = 1
        return formatter
    }()
    private static let lock = DispatchSemaphore(value: 1)

    func getNumberOfDecimalPlaces(_ number: NSNumber) -> Int {
        Self.lock.wait()
        defer { Self.lock.signal() }

        let exponent = max(abs(number.decimalValue.exponent), 0)
        Self.decimalPlacesFormatter.maximumFractionDigits = exponent + 10
        Self.decimalPlacesFormatter.minimumFractionDigits = exponent + 10

        return Self.decimalPlacesFormatter.string(from: number)?
            .trimmingCharacters(in: CharacterSet(charactersIn: "0"))
            .components(separatedBy: ".")
            .last?
            .count ?? exponent
    }
}
