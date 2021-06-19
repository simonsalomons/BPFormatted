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
