//
//  FormatStyle.swift
//
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

/// A type that can convert a given data type into a representation.
public protocol BPFormatStyle: Decodable, Encodable, Hashable {
    /// The type of data to format.
    associatedtype FormatInput

    /// The type of the formatted data.
    associatedtype FormatOutput

    /// Creates a `FormatOutput` instance from `value`.
    func format(_ value: Self.FormatInput) -> Self.FormatOutput

    /// If the format allows selecting a locale, returns a copy of this format with the new locale set. Default implementation returns an unmodified self.
    func locale(_ locale: Locale) -> Self
}

extension BPFormatStyle {
    public func locale(_ locale: Locale) -> Self {
        return self
    }
}

extension BPFormatStyle where Self == Date.BPFormatStyle {

    public static var dateTime: Date.BPFormatStyle {
        Date.BPFormatStyle(date: .numeric, time: .shortened)
    }
}

@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
extension BPFormatStyle where Self == Date.BPISO8601FormatStyle {

    public static var iso8601: Date.BPISO8601FormatStyle {
        Date.BPISO8601FormatStyle()
    }
}

extension BPFormatStyle where Self == Date.BPIntervalFormatStyle {

    public static var interval: Date.BPIntervalFormatStyle {
        Date.BPIntervalFormatStyle()
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension BPFormatStyle where Self == Date.BPRelativeFormatStyle {

    public static func relative(presentation: Date.BPRelativeFormatStyle.Presentation, unitsStyle: Date.BPRelativeFormatStyle.UnitsStyle = .wide) -> Self {
        Date.BPRelativeFormatStyle(presentation: presentation, unitsStyle: unitsStyle)
    }
}

extension BPFormatStyle where Self == Decimal.BPFormatStyle {
    public static var number: Decimal.BPFormatStyle {
        Decimal.BPFormatStyle()
    }
}

extension BPFormatStyle where Self == BPIntegerFormatStyle<Int> {
    public static var number: BPIntegerFormatStyle<Int> {
        BPIntegerFormatStyle()
    }
}
extension BPFormatStyle where Self == BPIntegerFormatStyle<Int16> {
    public static var number: BPIntegerFormatStyle<Int16> {
        BPIntegerFormatStyle()
    }
}
extension BPFormatStyle where Self == BPIntegerFormatStyle<Int32> {
    public static var number: BPIntegerFormatStyle<Int32> {
        BPIntegerFormatStyle()
    }
}
extension BPFormatStyle where Self == BPIntegerFormatStyle<Int64> {
    public static var number: BPIntegerFormatStyle<Int64> {
        BPIntegerFormatStyle()
    }
}
extension BPFormatStyle where Self == BPIntegerFormatStyle<Int8> {
    public static var number: BPIntegerFormatStyle<Int8> {
        BPIntegerFormatStyle()
    }
}
extension BPFormatStyle where Self == BPIntegerFormatStyle<UInt> {
    public static var number: BPIntegerFormatStyle<UInt> {
        BPIntegerFormatStyle()
    }
}
extension BPFormatStyle where Self == BPIntegerFormatStyle<UInt16> {
    public static var number: BPIntegerFormatStyle<UInt16> {
        BPIntegerFormatStyle()
    }
}
extension BPFormatStyle where Self == BPIntegerFormatStyle<UInt32> {
    public static var number: BPIntegerFormatStyle<UInt32> {
        BPIntegerFormatStyle()
    }
}
extension BPFormatStyle where Self == BPIntegerFormatStyle<UInt64> {
    public static var number: BPIntegerFormatStyle<UInt64> {
        BPIntegerFormatStyle()
    }
}
extension BPFormatStyle where Self == BPIntegerFormatStyle<UInt8> {
    public static var number: BPIntegerFormatStyle<UInt8> {
        BPIntegerFormatStyle()
    }
}

extension BPFormatStyle where Self == BPFloatingPointFormatStyle<Double> {
    public static var number: BPFloatingPointFormatStyle<Double> {
        BPFloatingPointFormatStyle()
    }
}
extension BPFormatStyle where Self == BPFloatingPointFormatStyle<Float> {
    public static var number: BPFloatingPointFormatStyle<Float> {
        BPFloatingPointFormatStyle()
    }
}

//extension BPFormatStyle where Self == Decimal.BPFormatStyle.Currency {
//
//    public static func currency(code: String) -> Self {
//
//    }
//}

extension BPFormatStyle {
    public static func currency<V>(code: String) -> Self where Self == BPIntegerFormatStyle<V>.Currency, V: BinaryInteger {
        BPIntegerFormatStyle.Currency(code: code)
    }
}
