//
//  RangeExpression+Bounds.swift
//  
//
//  Created by Simon Salomons on 27/06/2021.
//

import Foundation

internal extension RangeExpression {
    var upper: Bound? {
        if let range = self as? Range<Bound> {
            return range.upperBound
        } else if let closedRange = self as? ClosedRange<Bound> {
            return closedRange.upperBound
        } else if let partialRangeUpTo = self as? PartialRangeUpTo<Bound> {
            return partialRangeUpTo.upperBound
        } else if let partialRangeThrough = self as? PartialRangeThrough<Bound> {
            return partialRangeThrough.upperBound
        } else {
            return nil
        }
    }

    var lower: Bound? {
        if let range = self as? Range<Bound> {
            return range.lowerBound
        } else if let closedRange = self as? ClosedRange<Bound> {
            return closedRange.lowerBound
        } else if let partialRangeUpTo = self as? PartialRangeFrom<Bound> {
            return partialRangeUpTo.lowerBound
        } else {
            return nil
        }
    }
}
