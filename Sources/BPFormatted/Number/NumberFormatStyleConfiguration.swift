//
//  NumberFormatStyleConfiguration.swift
//  
//
//  Created by Simon Salomons on 19/06/2021.
//

import Foundation

@available(iOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "NumberFormatStyleConfiguration")
@available(macOS, deprecated: 12.0, message: "Consider using Apple's API", renamed: "NumberFormatStyleConfiguration")
@available(tvOS, deprecated: 15.0, message: "Consider using Apple's API", renamed: "NumberFormatStyleConfiguration")
@available(watchOS, deprecated: 8.0, message: "Consider using Apple's API", renamed: "NumberFormatStyleConfiguration")
public enum BPNumberFormatStyleConfiguration {

    public typealias RoundingRule = FloatingPointRoundingRule

    public struct Grouping : Codable, Hashable, CustomStringConvertible {

        internal let option: Option

        public static var automatic: Grouping {
            Grouping(option: .automatic)
        }

        public static var never: Grouping {
            Grouping(option: .never)
        }

        internal enum Option: Int, Codable {
            case automatic
            case never
        }

        public var description: String {
            String(describing: option)
        }
    }

    public struct Precision : Codable, Hashable {

        internal let option: Option

        public static func significantDigits<R>(_ limits: R) -> Precision where R : RangeExpression, R.Bound == Int {
            Precision(option: .significant(maxSignificantDigits: limits.upper.map({ min(999, max(1, $0)) }),
                                           minSignificantDigits: min(999, max(1, limits.lower ?? 1))))
        }

        public static func significantDigits(_ digits: Int) -> Precision {
            precondition(digits >= 0, "Negative count not allowed")

            return Precision(option: .significant(maxSignificantDigits: digits,
                                                  minSignificantDigits: digits))
        }

        public static func integerAndFractionLength<R1, R2>(integerLimits: R1, fractionLimits: R2) -> Precision where R1 : RangeExpression, R2 : RangeExpression, R1.Bound == Int, R2.Bound == Int {
            return Precision(option: .integerAndFraction(maxFractionalLength: fractionLimits.upper.map({ min(999, max(0, $0)) }),
                                                         minFractionalLength: fractionLimits.lower.map({ min(999, max(0, $0)) }),
                                                         minIntegerLength: integerLimits.lower.map({ min(999, max(0, $0)) }),
                                                         maxIntegerLength: integerLimits.upper.map({ min(999, max(0, $0)) })))
        }

        public static func integerAndFractionLength(integer: Int, fraction: Int) -> Precision {
            return Precision(option: .integerAndFraction(maxFractionalLength: fraction,
                                                         minFractionalLength: fraction,
                                                         minIntegerLength: integer,
                                                         maxIntegerLength: integer))
        }

        public static func integerLength<R>(_ limits: R) -> Precision where R : RangeExpression, R.Bound == Int {
            return Precision(option: .integerAndFraction(maxFractionalLength: nil,
                                                         minFractionalLength: nil,
                                                         minIntegerLength: limits.lower.map({ min(999, max(0, $0)) }),
                                                         maxIntegerLength: limits.upper.map({ min(999, max(0, $0)) })))
        }

        public static func integerLength(_ length: Int) -> Precision {
            return Precision(option: .integerAndFraction(maxFractionalLength: nil,
                                                         minFractionalLength: nil,
                                                         minIntegerLength: length,
                                                         maxIntegerLength: length))
        }

        public static func fractionLength<R>(_ limits: R) -> Precision where R : RangeExpression, R.Bound == Int {
            return Precision(option: .integerAndFraction(maxFractionalLength: limits.upper.map({ min(999, max(0, $0)) }),
                                                         minFractionalLength: limits.lower.map({ min(999, max(0, $0)) }),
                                                         minIntegerLength: nil,
                                                         maxIntegerLength: nil))
        }

        public static func fractionLength(_ length: Int) -> Precision {
            precondition(length >= 0, "Negative count not allowed")

            return Precision(option: .integerAndFraction(maxFractionalLength: length,
                                                         minFractionalLength: length,
                                                         minIntegerLength: nil,
                                                         maxIntegerLength: nil))
        }

        internal enum Option: Codable, Hashable {
            case integerAndFraction(maxFractionalLength: Int?,
                                    minFractionalLength: Int?,
                                    minIntegerLength: Int?,
                                    maxIntegerLength: Int?)
            case significant(maxSignificantDigits: Int?,
                             minSignificantDigits: Int)

            internal static var `default`: Option {
                    .integerAndFraction(maxFractionalLength: nil, minFractionalLength: nil, minIntegerLength: nil, maxIntegerLength: nil)
            }

            enum CodingKeys: CodingKey {
                case maxFractionalLength
                case minFractionalLength
                case minIntegerLength
                case maxIntegerLength
                case maxSignificantDigits
                case minSignificantDigits
            }

            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                if let maxSignificantDigits = try container.decodeIfPresent(Int?.self, forKey: .maxSignificantDigits),
                   let minSignificantDigits = try container.decodeIfPresent(Int.self, forKey: .minSignificantDigits) {
                    self = .significant(maxSignificantDigits: maxSignificantDigits, minSignificantDigits: minSignificantDigits)
                } else {
                    self = .integerAndFraction(maxFractionalLength: try container.decode(Int?.self, forKey: .maxFractionalLength),
                                               minFractionalLength: try container.decode(Int?.self, forKey: .minFractionalLength),
                                               minIntegerLength: try container.decode(Int?.self, forKey: .minIntegerLength),
                                               maxIntegerLength: try container.decode(Int?.self, forKey: .maxIntegerLength))
                }
            }

            func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                switch self {
                case let .integerAndFraction(maxFractionalLength, minFractionalLength, minIntegerLength, maxIntegerLength):
                    try container.encode(maxFractionalLength, forKey: .maxFractionalLength)
                    try container.encode(minFractionalLength, forKey: .minFractionalLength)
                    try container.encode(minIntegerLength, forKey: .minIntegerLength)
                    try container.encode(maxIntegerLength, forKey: .maxIntegerLength)
                case let .significant(maxSignificantDigits, minSignificantDigits):
                    try container.encode(maxSignificantDigits, forKey: .maxSignificantDigits)
                    try container.encode(minSignificantDigits, forKey: .minSignificantDigits)
                }
            }
        }
    }

    public struct DecimalSeparatorDisplayStrategy : Codable, Hashable, CustomStringConvertible {

        internal let option: Option

        public static var automatic: DecimalSeparatorDisplayStrategy {
            DecimalSeparatorDisplayStrategy(option: .automatic)
        }

        public static var always: DecimalSeparatorDisplayStrategy {
            DecimalSeparatorDisplayStrategy(option: .always)
        }

        internal enum Option: Int, Codable {
            case automatic
            case always
        }

        public var description: String {
            String(describing: option)
        }
    }

    // I don't know what Apple is doing here, the encoded version of the SignDisplayStrategy uses integers instead of booleans that mean the exact opposite of what they represent.
    public struct SignDisplayStrategy: Codable, Hashable, CustomStringConvertible {

        internal let negative: Int
        internal let zero: Int
        internal let positive: Int

        public static var automatic: SignDisplayStrategy {
            SignDisplayStrategy(negative: 0, zero: 1, positive: 1)
        }

        public static var never: SignDisplayStrategy {
            SignDisplayStrategy(negative: 1, zero: 1, positive: 1)
        }

        public static func always(includingZero: Bool = true) -> SignDisplayStrategy {
            SignDisplayStrategy(negative: 0, zero: includingZero ? 0 : 1, positive: 0)
        }

        public var description: String {
            if negative == 1 && positive == 1 && zero == 1 {
                return "never"
            } else if positive == 1 && negative == 0 {
                return "automatic"
            } else {
                if zero == 1 {
                    return "always(includingZero: false)"
                } else {
                    return "always(includingZero: true)"
                }
            }
        }
    }

    public struct Notation : Codable, Hashable, CustomStringConvertible {

        internal let option: Option

        public static var scientific: Notation {
            Notation(option: .scientific)
        }

        public static var automatic: Notation {
            Notation(option: .automatic)
        }

        // Excluded .compactName for now since this is something new to iOS 15 and you cannot replicate this with a NumberFormatter

        /*
        /// Formats the number with localized prefixes or suffixes corresponding to powers of ten. Rounds to integer while showing at least two significant digits by default.
        /// For example, "42.3K" for 42300 for the "en_US" locale.
        /// - note: We do not support parsing a number string containing localized prefixes or suffixes.
        public static var compactName: Notation {
            Notation(option: .compactName)
        }
         */

        internal enum Option: Int, Codable {
            case automatic
            case scientific
            case compactName
        }

        public var description: String {
            String(describing: option)
        }
    }
}
