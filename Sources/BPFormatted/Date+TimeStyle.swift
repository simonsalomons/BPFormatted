//
//  Date.TimeStyle.swift
//  
//
//  Created by Simon Salomons on 13/06/2021.
//

import Foundation

extension Date.BPFormatStyle {

    /// Predefined time styles varied in lengths or the components included. The exact format depends on the locale.
    public struct TimeStyle: Hashable {
        internal let style: Style

        /// Excludes the time part.
        public static var omitted: Date.BPFormatStyle.TimeStyle {
            return TimeStyle(style: .omitted)
        }

        /// For example, `04:29 PM`, `16:29`.
        public static var shortened: Date.BPFormatStyle.TimeStyle {
            return TimeStyle(style: .shortened)
        }

        /// For example, `4:29:24 PM`, `16:29:24`.
        public static var standard: Date.BPFormatStyle.TimeStyle {
            return TimeStyle(style: .standard)
        }

        /// For example, `4:29:24 PM PDT`, `16:29:24 GMT`.
        public static var complete: Date.BPFormatStyle.TimeStyle {
            return TimeStyle(style: .complete)
        }

        internal enum Style: Int, Codable, Hashable {
            case omitted
            case shortened
            case standard
            case complete
        }
    }
}

extension Date.BPFormatStyle.TimeStyle: Codable {

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
