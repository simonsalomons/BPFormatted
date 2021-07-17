//
//  NumberFormatStyleCollection.swift
//  
//
//  Created by Simon Salomons on 04/07/2021.
//

import Foundation

internal struct BPNumberFormatStyleCollection: Codable, Hashable {
    var rounding: BPNumberFormatStyleConfiguration.RoundingRule?
    var roundingIncrement: RoundingIncrement?
    var group: BPNumberFormatStyleConfiguration.Grouping?
    var precision: BPNumberFormatStyleConfiguration.Precision?
    var signDisplayStrategy: BPNumberFormatStyleConfiguration.SignDisplayStrategy?
    var decimalSeparatorStrategy: BPNumberFormatStyleConfiguration.DecimalSeparatorDisplayStrategy?
    var scale: Double?
    var notation: BPNumberFormatStyleConfiguration.Notation?
}

internal struct RoundingIncrement: Codable, Hashable {
    var integer: Int
}

#if swift(<5.5)
extension BPNumberFormatStyleConfiguration.RoundingRule: RawRepresentable, Codable {
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
#endif
