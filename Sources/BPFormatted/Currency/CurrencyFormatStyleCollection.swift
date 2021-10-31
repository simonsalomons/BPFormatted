//
//  CurrencyFormatStyleCollection.swift
//
//  Created by Simon Salomons on 17/07/2021.
//

import Foundation

internal struct BPCurrencyFormatStyleCollection: Codable, Hashable {
    var rounding: BPCurrencyFormatStyleConfiguration.RoundingRule?
    var roundingIncrement: RoundingIncrement?
    var group: BPCurrencyFormatStyleConfiguration.Grouping?
    var precision: BPCurrencyFormatStyleConfiguration.Precision?
    var signDisplayStrategy: BPCurrencyFormatStyleConfiguration.SignDisplayStrategy?
    var decimalSeparatorStrategy: BPCurrencyFormatStyleConfiguration.DecimalSeparatorDisplayStrategy?
    var scale: Double?
    var presentation: BPCurrencyFormatStyleConfiguration.Presentation?
}
