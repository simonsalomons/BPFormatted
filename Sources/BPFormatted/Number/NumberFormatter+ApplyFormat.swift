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

    func applyFormat<Value: BinaryInteger>(_ collection: BPNumberFormatStyleCollection, locale: Locale, value: Value, applyPrecisionIfOmitted: Bool) throws {

        applyNotation(collection.notation)

        // It's very important that we set the precision before setting the locale... for some reason
        // Otherwise the first result will get unexpected results

        if applyPrecisionIfOmitted || collection.precision != nil {
            try self.applyPrecision(collection.precision?.option ?? .default, forValue: value)
        }

        applyLocale(locale)

        applySignStrategy(collection.signDisplayStrategy, forValue: value)

        applyGrouping(collection.group)

        applyDecimalSeparator(collection.decimalSeparatorStrategy)

        applyScale(collection.scale)

#warning("🆘 Implement rounded")
    }

    func applyFormat<Value: BinaryInteger>(_ collection: BPCurrencyFormatStyleCollection, locale: Locale, value: Value, applyPrecisionIfOmitted: Bool) throws {

        // Reset prefix and suffix because setting the presentation will set them to standards
        negativePrefix = nil
        positivePrefix = nil
        negativeSuffix = nil
        positiveSuffix = nil

        applyPresentation(collection.presentation)

        // It's very important that we set the precision before setting the locale... for some reason
        // Otherwise the first result will get unexpected results

        if applyPrecisionIfOmitted || collection.precision != nil {
            try self.applyPrecision(collection.precision?.option ?? .default, forValue: value)
        }

        applyLocale(locale)

        applySignStrategy(collection.signDisplayStrategy, forValue: value)

        applyGrouping(collection.group)

        applyDecimalSeparator(collection.decimalSeparatorStrategy)

        applyScale(collection.scale)

#warning("🆘 Implement rounded")
    }

    func applyFormat<Value: BinaryFloatingPoint>(_ collection: BPNumberFormatStyleCollection, locale: Locale, value: Value, applyPrecisionIfOmitted: Bool) throws {

        applyNotation(collection.notation)

        // It's very important that we set the precision before setting the locale... for some reason
        // Otherwise the first result will get unexpected results

        if applyPrecisionIfOmitted || collection.precision != nil {
            try self.applyPrecision(collection.precision?.option ?? .default, forValue: value)
        }

        applyLocale(locale)

        applySignStrategy(collection.signDisplayStrategy, forValue: value)

        applyGrouping(collection.group)

        applyDecimalSeparator(collection.decimalSeparatorStrategy)

        applyScale(collection.scale)

#warning("🆘 Implement rounded")
    }

    func applyFormat<Value: BinaryFloatingPoint>(_ collection: BPCurrencyFormatStyleCollection, locale: Locale, value: Value, applyPrecisionIfOmitted: Bool) throws {

        // Reset prefix and suffix because setting the presentation will set them to standards
        negativePrefix = nil
        positivePrefix = nil
        negativeSuffix = nil
        positiveSuffix = nil

        applyPresentation(collection.presentation)

        // It's very important that we set the precision before setting the locale... for some reason
        // Otherwise the first result will get unexpected results

        if applyPrecisionIfOmitted || collection.precision != nil {
            try self.applyPrecision(collection.precision?.option ?? .default, forValue: value)
        }

        applyLocale(locale)

        applySignStrategy(collection.signDisplayStrategy, forValue: value)

        applyGrouping(collection.group)

        applyDecimalSeparator(collection.decimalSeparatorStrategy)

        applyScale(collection.scale)

#warning("🆘 Implement rounded")
    }

    func applyFormat(_ collection: BPNumberFormatStyleCollection, locale: Locale, value: Decimal, applyPrecisionIfOmitted: Bool) throws {

        applyNotation(collection.notation)

        // It's very important that we set the precision before setting the locale... for some reason
        // Otherwise the first result will get unexpected results

        if applyPrecisionIfOmitted || collection.precision != nil {
            try self.applyPrecision(collection.precision?.option ?? .default, forValue: value)
        }

        applyLocale(locale)

        applySignStrategy(collection.signDisplayStrategy, forValue: value)

        applyGrouping(collection.group)

        applyDecimalSeparator(collection.decimalSeparatorStrategy)

        applyScale(collection.scale)

#warning("🆘 Implement rounded")
    }

    func applyNotation(_ notation: BPNumberFormatStyleConfiguration.Notation?) {
        switch notation?.option ?? .automatic {
        case .automatic:
            numberStyle = .decimal
        case .scientific:
            numberStyle = .scientific
        case .compactName:
            fatalError("compactName not supported")
        }
    }

    func applyPresentation(_ presentation: BPCurrencyFormatStyleConfiguration.Presentation?) {
        switch presentation?.option ?? .standard {
        case .narrow:
            numberStyle = .currencyAccounting
        case .standard:
            numberStyle = .currency
        case .isoCode:
            numberStyle = .currencyISOCode
        case .fullName:
            numberStyle = .currencyPlural
        }
    }

    func applyLocale(_ locale: Locale) {
        if locale == .autoupdatingCurrent {
            self.locale = nil
        } else {
            self.locale = locale
        }
    }

    func applySignStrategy<Value: BinaryInteger>(_ strategy: BPNumberFormatStyleConfiguration.SignDisplayStrategy?, forValue value: Value) {
        let signStrategy = strategy ?? .automatic
        negativePrefix = signStrategy.negative == 0 ? minusSign : ""
        if value == 0 {
            positivePrefix = signStrategy.zero == 0 ? plusSign : ""
        } else {
            positivePrefix = signStrategy.positive == 0 ? plusSign : ""
        }
    }

    func applySignStrategy<Value: BinaryFloatingPoint>(_ strategy: BPNumberFormatStyleConfiguration.SignDisplayStrategy?, forValue value: Value) {
        let signStrategy = strategy ?? .automatic
        negativePrefix = signStrategy.negative == 0 ? minusSign : ""
        if value == 0 {
            positivePrefix = signStrategy.zero == 0 ? plusSign : ""
        } else {
            positivePrefix = signStrategy.positive == 0 ? plusSign : ""
        }
    }

    func applySignStrategy<Value: BinaryInteger>(_ strategy: BPCurrencyFormatStyleConfiguration.SignDisplayStrategy?, forValue value: Value) {
        let signStrategy = strategy ?? .automatic

        if signStrategy.accounting {
            negativePrefix = "(" + currencySymbol
            negativeSuffix = ")"
        } else {
            switch signStrategy.negative {
            case .hidden where negativePrefix.contains(minusSign):
                negativePrefix = negativePrefix.replacingOccurrences(of: minusSign, with: "")
            case .always where !negativePrefix.contains(minusSign):
                negativePrefix = "\(minusSign ?? "")\(negativePrefix ?? "")"
            default:
                break
            }
            negativePrefix = (signStrategy.negative == .always ? minusSign : "") + currencySymbol
            negativeSuffix = ""
        }
        if value == 0 {
            switch signStrategy.zero {
            case .hidden where positivePrefix.contains(plusSign):
                positivePrefix = positivePrefix.replacingOccurrences(of: plusSign, with: "")
            case .always where !positivePrefix.contains(plusSign):
                positivePrefix = "\(plusSign ?? "")\(positivePrefix ?? "")"
            default:
                break
            }
            positivePrefix = (signStrategy.zero == .always ? plusSign : "") + currencySymbol
        } else {
            switch signStrategy.positive {
            case .hidden where positivePrefix.contains(plusSign):
                positivePrefix = positivePrefix.replacingOccurrences(of: plusSign, with: "")
            case .always where !positivePrefix.contains(plusSign):
                positivePrefix = "\(plusSign ?? "")\(positivePrefix ?? "")"
            default:
                break
            }
            positivePrefix = (signStrategy.positive == .always ? plusSign : "") + currencySymbol
        }
    }

    func applySignStrategy<Value: BinaryFloatingPoint>(_ strategy: BPCurrencyFormatStyleConfiguration.SignDisplayStrategy?, forValue value: Value) {
        let signStrategy = strategy ?? .automatic

        if signStrategy.accounting {
            negativePrefix = "(" + currencySymbol
            negativeSuffix = ")"
        } else {
            switch signStrategy.negative {
            case .hidden where negativePrefix.contains(minusSign):
                negativePrefix = negativePrefix.replacingOccurrences(of: minusSign, with: "")
            case .always where !negativePrefix.contains(minusSign):
                negativePrefix = "\(minusSign ?? "")\(negativePrefix ?? "")"
            default:
                break
            }
            negativePrefix = (signStrategy.negative == .always ? minusSign : "") + currencySymbol
            negativeSuffix = ""
        }
        if value == 0 {
            switch signStrategy.zero {
            case .hidden where positivePrefix.contains(plusSign):
                positivePrefix = positivePrefix.replacingOccurrences(of: plusSign, with: "")
            case .always where !positivePrefix.contains(plusSign):
                positivePrefix = "\(plusSign ?? "")\(positivePrefix ?? "")"
            default:
                break
            }
            positivePrefix = (signStrategy.zero == .always ? plusSign : "") + currencySymbol
        } else {
            switch signStrategy.positive {
            case .hidden where positivePrefix.contains(plusSign):
                positivePrefix = positivePrefix.replacingOccurrences(of: plusSign, with: "")
            case .always where !positivePrefix.contains(plusSign):
                positivePrefix = "\(plusSign ?? "")\(positivePrefix ?? "")"
            default:
                break
            }
            positivePrefix = (signStrategy.positive == .always ? plusSign : "") + currencySymbol
        }
    }

    func applySignStrategy(_ strategy: BPNumberFormatStyleConfiguration.SignDisplayStrategy?, forValue value: Decimal) {
        let signStrategy = strategy ?? .automatic
        negativePrefix = signStrategy.negative == 0 ? minusSign : ""
        if value == 0 {
            positivePrefix = signStrategy.zero == 0 ? plusSign : ""
        } else {
            positivePrefix = signStrategy.positive == 0 ? plusSign : ""
        }
    }

    func applyGrouping(_ grouping: BPNumberFormatStyleConfiguration.Grouping?) {
        usesGroupingSeparator = (grouping ?? .automatic) == .automatic
    }

    func applyDecimalSeparator(_ strategy: BPNumberFormatStyleConfiguration.DecimalSeparatorDisplayStrategy?) {
        alwaysShowsDecimalSeparator = (strategy ?? .automatic) == .always
    }

    func applyScale(_ scale: Double?) {
        if let scale = scale {
            multiplier = NSNumber(value: scale)
        } else {
            multiplier = NSNumber(value: 1)
        }
    }

    func applyPrecision<Value: BinaryInteger>(_ precision: BPNumberFormatStyleConfiguration.Precision.Option, forValue value: Value) throws {
        switch precision {
        case let .integerAndFraction(maxFractionalLength, minFractionalLength, minIntegerLength, maxIntegerLength):
            try applyIntegerAndFractionPrecision(maxFractional: maxFractionalLength, minFractional: minFractionalLength, minInteger: minIntegerLength, maxInteger: maxIntegerLength, forValue: value)
        case let .significant(maxSignificantDigits, minSignificantDigits):
            try applySignificantPrecision(maxSignificant: maxSignificantDigits, minSignificant: minSignificantDigits, forValue: value)
        }
    }

    func applyPrecision<Value: BinaryFloatingPoint>(_ precision: BPNumberFormatStyleConfiguration.Precision.Option, forValue value: Value) throws {
        switch precision {
        case let .integerAndFraction(maxFractionalLength, minFractionalLength, minIntegerLength, maxIntegerLength):
            try applyIntegerAndFractionPrecision(maxFractional: maxFractionalLength, minFractional: minFractionalLength, minInteger: minIntegerLength, maxInteger: maxIntegerLength, forValue: value)
        case let .significant(maxSignificantDigits, minSignificantDigits):
            try applySignificantPrecision(maxSignificant: maxSignificantDigits, minSignificant: minSignificantDigits, forValue: value)
        }
    }

    func applyPrecision(_ precision: BPNumberFormatStyleConfiguration.Precision.Option, forValue value: Decimal) throws {
        switch precision {
        case let .integerAndFraction(maxFractionalLength, minFractionalLength, minIntegerLength, maxIntegerLength):
            try applyIntegerAndFractionPrecision(maxFractional: maxFractionalLength, minFractional: minFractionalLength, minInteger: minIntegerLength, maxInteger: maxIntegerLength, forValue: value)
        case let .significant(maxSignificantDigits, minSignificantDigits):
            try applySignificantPrecision(maxSignificant: maxSignificantDigits, minSignificant: minSignificantDigits, forValue: value)
        }
    }

    func applyIntegerAndFractionPrecision<Value: BinaryInteger>(maxFractional: Int?, minFractional: Int?, minInteger: Int?, maxInteger: Int?, forValue value: Value) throws {
        try applyIntegerAndFractionPrecision(maxFractional: maxFractional,
                                             minFractional: minFractional,
                                             minInteger: minInteger,
                                             maxInteger: maxInteger,
                                             defaultDecimalPlaces: 0)
    }

    func applyIntegerAndFractionPrecision<Value: BinaryFloatingPoint>(maxFractional: Int?, minFractional: Int?, minInteger: Int?, maxInteger: Int?, forValue value: Value) throws {
        try applyIntegerAndFractionPrecision(maxFractional: maxFractional,
                                             minFractional: minFractional,
                                             minInteger: minInteger,
                                             maxInteger: maxInteger,
                                             defaultDecimalPlaces: getNumberOfDecimalPlaces(value))
    }

    func applyIntegerAndFractionPrecision(maxFractional: Int?, minFractional: Int?, minInteger: Int?, maxInteger: Int?, forValue value: Decimal) throws {
        try applyIntegerAndFractionPrecision(maxFractional: maxFractional,
                                             minFractional: minFractional,
                                             minInteger: minInteger,
                                             maxInteger: maxInteger,
                                             defaultDecimalPlaces: getNumberOfDecimalPlaces(value))
    }

    func applyIntegerAndFractionPrecision(maxFractional: Int?, minFractional: Int?, minInteger: Int?, maxInteger: Int?, defaultDecimalPlaces: Int) throws {
        usesSignificantDigits = false
        maximumSignificantDigits = -1
        minimumSignificantDigits = -1

        var maxInteger = maxInteger ?? 999
        let minInteger = minInteger ?? 0

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

    func applySignificantPrecision<Value: BinaryFloatingPoint>(maxSignificant: Int?, minSignificant: Int, forValue value: Value) throws {
        usesSignificantDigits = true

        let maxSignificant = maxSignificant ?? 999
        guard maxSignificant > 0 else {
            try applyIntegerAndFractionPrecision(maxFractional: nil, minFractional: nil, minInteger: nil, maxInteger: nil, forValue: value)
            return
        }

        guard maxSignificant < 1_000 else {
            throw PrecisionError.maxSignificantTooBig
        }

        maximumSignificantDigits = maxSignificant
        minimumSignificantDigits = minSignificant
    }

    func applySignificantPrecision(maxSignificant: Int?, minSignificant: Int, forValue value: Decimal) throws {
        usesSignificantDigits = true

        let maxSignificant = maxSignificant ?? 999
        guard maxSignificant > 0 else {
            try applyIntegerAndFractionPrecision(maxFractional: nil, minFractional: nil, minInteger: nil, maxInteger: nil, forValue: value)
            return
        }

        guard maxSignificant < 1_000 else {
            throw PrecisionError.maxSignificantTooBig
        }

        maximumSignificantDigits = maxSignificant
        minimumSignificantDigits = minSignificant
    }

    func applySignificantPrecision<Value: BinaryInteger>(maxSignificant: Int?, minSignificant: Int, forValue value: Value) throws {
        usesSignificantDigits = true

        let maxSignificant = maxSignificant ?? 999
        guard maxSignificant > 0 else {
            try applyIntegerAndFractionPrecision(maxFractional: nil, minFractional: nil, minInteger: nil, maxInteger: nil, forValue: value)
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

    func getNumberOfDecimalPlaces<Value: BinaryFloatingPoint>(_ value: Value) -> Int {
        //        Self.lock.wait()
        //        defer { Self.lock.signal() }
        //
        //        let exponent = max(abs(number.decimalValue.exponent), 0)
        //        Self.decimalPlacesFormatter.maximumFractionDigits = exponent + 10
        //        Self.decimalPlacesFormatter.minimumFractionDigits = exponent + 10
        //
        //        return Self.decimalPlacesFormatter.string(from: number)?
        //            .trimmingCharacters(in: CharacterSet(charactersIn: "0"))
        //            .components(separatedBy: ".")
        //            .last?
        //            .count ?? exponent

#warning("🆘 Calculate number of decimal places depending on the value type")
        return 0
    }

    func getNumberOfDecimalPlaces(_ value: Decimal) -> Int {
        Self.lock.wait()
        defer { Self.lock.signal() }

        let exponent = max(abs(value.exponent), 0)
        Self.decimalPlacesFormatter.maximumFractionDigits = exponent + 10
        Self.decimalPlacesFormatter.minimumFractionDigits = exponent + 10

        return Self.decimalPlacesFormatter.string(from: NSDecimalNumber(decimal: value))?
            .trimmingCharacters(in: CharacterSet(charactersIn: "0"))
            .components(separatedBy: ".")
            .last?
            .count ?? exponent

        return 0
    }
}

internal extension NumberFormatter {
    func string<Value: BinaryFloatingPoint>(from value: Value) -> String? {
        if let value = value as? Double {
            return string(from: NSNumber(value: value))
        } else if let value = value as? Float {
            return string(from: NSNumber(value: value))
        } else {
            return nil
        }
    }
}

internal extension NumberFormatter {
    func string<Value: BinaryInteger>(from value: Value) -> String? {
        if let value = value as? Int {
            return string(from: NSNumber(value: value))
        } else if let value = value as? Int8 {
            return string(from: NSNumber(value: value))
        } else if let value = value as? Int16 {
            return string(from: NSNumber(value: value))
        } else if let value = value as? Int32 {
            return string(from: NSNumber(value: value))
        } else if let value = value as? Int32 {
            return string(from: NSNumber(value: value))
        } else if let value = value as? UInt {
            return string(from: NSNumber(value: value))
        } else if let value = value as? UInt8 {
            return string(from: NSNumber(value: value))
        } else if let value = value as? UInt16 {
            return string(from: NSNumber(value: value))
        } else if let value = value as? UInt32 {
            return string(from: NSNumber(value: value))
        } else if let value = value as? UInt64 {
            return string(from: NSNumber(value: value))
        } else {
            return nil
        }
    }
}
