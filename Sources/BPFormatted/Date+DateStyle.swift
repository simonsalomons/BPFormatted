//
//  Date+DateStyle.swift
//  
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

extension Date.BPFormatStyle {

    /// Predefined date styles varied in lengths or the components included. The exact format depends on the locale.
    public struct DateStyle: Hashable {
        internal let style: Style

        /// Excludes the date part.
        public static var omitted: Date.BPFormatStyle.DateStyle {
            return DateStyle(style: .omitted)
        }

        /// Shows date components in their numeric form. For example, "10/21/2015".
        public static var numeric: Date.BPFormatStyle.DateStyle {
            return DateStyle(style: .numeric)
        }

        /// Shows date components in their abbreviated form if possible. For example, "Oct 21, 2015".
        public static var abbreviated: Date.BPFormatStyle.DateStyle {
            return DateStyle(style: .abbreviated)
        }

        /// Shows date components in their long form if possible. For example, "October 21, 2015".
        public static var long: Date.BPFormatStyle.DateStyle {
            return DateStyle(style: .long)
        }

        /// Shows the complete day. For example, "Wednesday, October 21, 2015".
        public static var complete: Date.BPFormatStyle.DateStyle {
            return DateStyle(style: .complete)
        }

        internal enum Style: Int, Codable, Hashable {
            case omitted
            case numeric
            case abbreviated
            case long
            case complete
        }
    }
}

extension Date.BPFormatStyle.DateStyle: Codable {

    enum CodingKeys: String, CodingKey {
        case rawValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        style = try container.decode(Style.self, forKey: .rawValue)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(style, forKey: .rawValue)
    }
}
