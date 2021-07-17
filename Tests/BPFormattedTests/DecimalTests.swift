//
//  DecimalTests.swift
//  
//
//  Created by Simon Salomons on 19/06/2021.
//

import Foundation

import XCTest
@testable import BPFormatted

// Since we're comparing against api's from the base SDK's in Xcode 13, there's no reason to compile these tests
#if swift(>=5.5)

final class DecimalTests: XCTestCase {

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testGeneral() {
        let decimal = Decimal(100_000.123_456)

        XCTAssertEqual(decimal.bpFormatted(),
                       decimal.formatted())

        XCTAssertEqual(decimal.bpFormatted(.number),
                       decimal.formatted(.number))

        XCTAssertEqual(decimal.bpFormatted(Decimal.BPFormatStyle()),
                       decimal.formatted(Decimal.FormatStyle()))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testLocale() {
        let decimal = Decimal(100_000.123_456)

        var locale = Locale(identifier: "be-NL")
        XCTAssertEqual(decimal.bpFormatted(.number.locale(locale)),
                       decimal.formatted(.number.locale(locale)))

        XCTAssertEqual(decimal.bpFormatted(Decimal.BPFormatStyle(locale: locale)),
                       decimal.formatted(Decimal.FormatStyle(locale: locale)))


        locale = Locale(identifier: "en-US")
        XCTAssertEqual(decimal.bpFormatted(.number.locale(locale)),
                       decimal.formatted(.number.locale(locale)))

        XCTAssertEqual(decimal.bpFormatted(Decimal.BPFormatStyle(locale: locale)),
                       decimal.formatted(Decimal.FormatStyle(locale: locale)))


        locale = Locale(identifier: "en-UK")
        XCTAssertEqual(decimal.bpFormatted(.number.locale(locale)),
                       decimal.formatted(.number.locale(locale)))

        XCTAssertEqual(decimal.bpFormatted(Decimal.BPFormatStyle(locale: locale)),
                       decimal.formatted(Decimal.FormatStyle(locale: locale)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testSignStrategy() {
        XCTAssertEqual(Decimal(-1).bpFormatted(.number.sign(strategy: .automatic)),
                       Decimal(-1).formatted(.number.sign(strategy: .automatic)))

        XCTAssertEqual(Decimal(0).bpFormatted(.number.sign(strategy: .automatic)),
                       Decimal(0).formatted(.number.sign(strategy: .automatic)))

        XCTAssertEqual(Decimal(1).bpFormatted(.number.sign(strategy: .automatic)),
                       Decimal(1).formatted(.number.sign(strategy: .automatic)))


        XCTAssertEqual(Decimal(-1).bpFormatted(.number.sign(strategy: .never)),
                       Decimal(-1).formatted(.number.sign(strategy: .never)))

        XCTAssertEqual(Decimal(0).bpFormatted(.number.sign(strategy: .never)),
                       Decimal(0).formatted(.number.sign(strategy: .never)))

        XCTAssertEqual(Decimal(1).bpFormatted(.number.sign(strategy: .never)),
                       Decimal(1).formatted(.number.sign(strategy: .never)))


        XCTAssertEqual(Decimal(-1).bpFormatted(.number.sign(strategy: .always(includingZero: false))),
                       Decimal(-1).formatted(.number.sign(strategy: .always(includingZero: false))))

        XCTAssertEqual(Decimal(0).bpFormatted(.number.sign(strategy: .always(includingZero: false))),
                       Decimal(0).formatted(.number.sign(strategy: .always(includingZero: false))))

        XCTAssertEqual(Decimal(1).bpFormatted(.number.sign(strategy: .always(includingZero: false))),
                       Decimal(1).formatted(.number.sign(strategy: .always(includingZero: false))))


        XCTAssertEqual(Decimal(-1).bpFormatted(.number.sign(strategy: .always(includingZero: true))),
                       Decimal(-1).formatted(.number.sign(strategy: .always(includingZero: true))))

        XCTAssertEqual(Decimal(0).bpFormatted(.number.sign(strategy: .always(includingZero: true))),
                       Decimal(0).formatted(.number.sign(strategy: .always(includingZero: true))))

        XCTAssertEqual(Decimal(1).bpFormatted(.number.sign(strategy: .always(includingZero: true))),
                       Decimal(1).formatted(.number.sign(strategy: .always(includingZero: true))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testGrouping() {
        let decimal = Decimal(100_000.123_456)

        XCTAssertEqual(decimal.bpFormatted(.number.grouping(.never)),
                       decimal.formatted(.number.grouping(.never)))

        XCTAssertEqual(decimal.bpFormatted(.number.grouping(.automatic)),
                       decimal.formatted(.number.grouping(.automatic)))

        let usa = Locale(identifier: "en-US")
        XCTAssertEqual(decimal.bpFormatted(.number.locale(usa).grouping(.never)),
                       decimal.formatted(.number.locale(usa).grouping(.never)))

        XCTAssertEqual(decimal.bpFormatted(.number.locale(usa).grouping(.automatic)),
                       decimal.formatted(.number.locale(usa).grouping(.automatic)))

        let france = Locale(identifier: "fr-FR")
        XCTAssertEqual(decimal.bpFormatted(.number.locale(france).grouping(.never)),
                       decimal.formatted(.number.locale(france).grouping(.never)))

        XCTAssertEqual(decimal.bpFormatted(.number.locale(france).grouping(.automatic)),
                       decimal.formatted(.number.locale(france).grouping(.automatic)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testPrecisionSignificant() {
        let decimal = Decimal(123_456.123_456)

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.significantDigits(3))),
                       decimal.formatted(.number.precision(.significantDigits(3))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.significantDigits(1))),
                       decimal.formatted(.number.precision(.significantDigits(1))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.significantDigits(8))),
                       decimal.formatted(.number.precision(.significantDigits(8))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.significantDigits(20))),
                       decimal.formatted(.number.precision(.significantDigits(20))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.significantDigits(1_000_000))),
                       decimal.formatted(.number.precision(.significantDigits(1_000_000))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.significantDigits(0))),
                       decimal.formatted(.number.precision(.significantDigits(0))))


        XCTAssertEqual(decimal.bpFormatted(.number.precision(.significantDigits(0...3))),
                       decimal.formatted(.number.precision(.significantDigits(0...3))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.significantDigits(0...8))),
                       decimal.formatted(.number.precision(.significantDigits(0...8))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.significantDigits(0...20))),
                       decimal.formatted(.number.precision(.significantDigits(0...20))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.significantDigits(0...1_000_000))),
                       decimal.formatted(.number.precision(.significantDigits(0...1_000_000))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.significantDigits(-100..<(-50)))),
                       decimal.formatted(.number.precision(.significantDigits(-100..<(-50)))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.significantDigits(0...))),
                       decimal.formatted(.number.precision(.significantDigits(0...))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.significantDigits(20...))),
                       decimal.formatted(.number.precision(.significantDigits(20...))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testPrecisionInteger() {
        let decimal = Decimal(123_456.123_456)

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerLength(0))),
                       decimal.formatted(.number.precision(.integerLength(0))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerLength(3))),
                       decimal.formatted(.number.precision(.integerLength(3))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerLength(8))),
                       decimal.formatted(.number.precision(.integerLength(8))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerLength(20))),
                       decimal.formatted(.number.precision(.integerLength(20))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerLength(1_000_000))),
                       decimal.formatted(.number.precision(.integerLength(1_000_000))))


        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerLength(0...3))),
                       decimal.formatted(.number.precision(.integerLength(0...3))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerLength(0...8))),
                       decimal.formatted(.number.precision(.integerLength(0...8))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerLength(0...20))),
                       decimal.formatted(.number.precision(.integerLength(0...20))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerLength(0...1_000_000))),
                       decimal.formatted(.number.precision(.integerLength(0...1_000_000))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerLength(-100..<(-50)))),
                       decimal.formatted(.number.precision(.integerLength(-100..<(-50)))))


        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerLength(0...))),
                       decimal.formatted(.number.precision(.integerLength(0...))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerLength(20...))),
                       decimal.formatted(.number.precision(.integerLength(20...))))


        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerLength(...0))),
                       decimal.formatted(.number.precision(.integerLength(...0))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerLength(...3))),
                       decimal.formatted(.number.precision(.integerLength(...3))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerLength(...8))),
                       decimal.formatted(.number.precision(.integerLength(...8))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerLength(...20))),
                       decimal.formatted(.number.precision(.integerLength(...20))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testPrecisionFractional() {
        let decimal = Decimal(123_456.123_456)

        print(decimal.bpFormatted(.number.precision(.fractionLength(20))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.fractionLength(0))),
                       decimal.formatted(.number.precision(.fractionLength(0))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.fractionLength(3))),
                       decimal.formatted(.number.precision(.fractionLength(3))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.fractionLength(8))),
                       decimal.formatted(.number.precision(.fractionLength(8))))

#warning("🆘 Apple's API loses decimal precision in this output")
        XCTAssertEqual(decimal.bpFormatted(.number.precision(.fractionLength(20))),
                       decimal.formatted(.number.precision(.fractionLength(20))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.fractionLength(1_000_000))),
                       decimal.formatted(.number.precision(.fractionLength(1_000_000))))


        XCTAssertEqual(decimal.bpFormatted(.number.precision(.fractionLength(0...3))),
                       decimal.formatted(.number.precision(.fractionLength(0...3))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.fractionLength(0...8))),
                       decimal.formatted(.number.precision(.fractionLength(0...8))))

#warning("🆘 Apple's API loses decimal precision in this output")
        XCTAssertEqual(decimal.bpFormatted(.number.precision(.fractionLength(0...20))),
                       decimal.formatted(.number.precision(.fractionLength(0...20))))

#warning("🆘 Apple's API loses decimal precision in this output")
        XCTAssertEqual(decimal.bpFormatted(.number.precision(.fractionLength(0...1_000_000))),
                       decimal.formatted(.number.precision(.fractionLength(0...1_000_000))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.fractionLength(-100..<(-50)))),
                       decimal.formatted(.number.precision(.fractionLength(-100..<(-50)))))


#warning("🆘 Apple's API loses decimal precision in this output")
        XCTAssertEqual(decimal.bpFormatted(.number.precision(.fractionLength(0...))),
                       decimal.formatted(.number.precision(.fractionLength(0...))))

#warning("🆘 Apple's API loses decimal precision in this output")
        XCTAssertEqual(decimal.bpFormatted(.number.precision(.fractionLength(20...))),
                       decimal.formatted(.number.precision(.fractionLength(20...))))


        XCTAssertEqual(decimal.bpFormatted(.number.precision(.fractionLength(...0))),
                       decimal.formatted(.number.precision(.fractionLength(...0))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.fractionLength(...3))),
                       decimal.formatted(.number.precision(.fractionLength(...3))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.fractionLength(...8))),
                       decimal.formatted(.number.precision(.fractionLength(...8))))

#warning("🆘 Apple's API loses decimal precision in this output")
        XCTAssertEqual(decimal.bpFormatted(.number.precision(.fractionLength(...20))),
                       decimal.formatted(.number.precision(.fractionLength(...20))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testPrecisionIntegerAndFractional() {
        let decimal = Decimal(123_456.123_456)

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerAndFractionLength(integer: 0, fraction: 0))),
                       decimal.formatted(.number.precision(.integerAndFractionLength(integer: 0, fraction: 0))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerAndFractionLength(integer: 3, fraction: 3))),
                       decimal.formatted(.number.precision(.integerAndFractionLength(integer: 3, fraction: 3))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerAndFractionLength(integer: 8, fraction: 8))),
                       decimal.formatted(.number.precision(.integerAndFractionLength(integer: 8, fraction: 8))))

#warning("🆘 Apple's API loses decimal precision in this output")
        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerAndFractionLength(integer: 20, fraction: 20))),
                       decimal.formatted(.number.precision(.integerAndFractionLength(integer: 20, fraction: 20))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerAndFractionLength(integer: 1_000_000, fraction: 1_000_000))),
                       decimal.formatted(.number.precision(.integerAndFractionLength(integer: 1_000_000, fraction: 1_000_000))))


        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: 0...3, fractionLimits: 0...3))),
                       decimal.formatted(.number.precision(.integerAndFractionLength(integerLimits: 0...3, fractionLimits: 0...3))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: 0...8, fractionLimits: 0...8))),
                       decimal.formatted(.number.precision(.integerAndFractionLength(integerLimits: 0...8, fractionLimits: 0...8))))

#warning("🆘 Apple's API loses decimal precision in this output")
        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: 0...20, fractionLimits: 0...20))),
                       decimal.formatted(.number.precision(.integerAndFractionLength(integerLimits: 0...20, fractionLimits: 0...20))))

#warning("🆘 Apple's API loses decimal precision in this output")
        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: 0...1_000_000, fractionLimits: 0...1_000_000))),
                       decimal.formatted(.number.precision(.integerAndFractionLength(integerLimits: 0...1_000_000, fractionLimits: 0...1_000_000))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: -100..<(-50), fractionLimits: -100..<(-50)))),
                       decimal.formatted(.number.precision(.integerAndFractionLength(integerLimits: -100..<(-50), fractionLimits: -100..<(-50)))))


#warning("🆘 Apple's API loses decimal precision in this output")
        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: 0..., fractionLimits: 0...))),
                       decimal.formatted(.number.precision(.integerAndFractionLength(integerLimits: 0..., fractionLimits: 0...))))

#warning("🆘 Apple's API loses decimal precision in this output")
        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: 20..., fractionLimits: 20...))),
                       decimal.formatted(.number.precision(.integerAndFractionLength(integerLimits: 20..., fractionLimits: 20...))))


        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: ...0, fractionLimits: ...0))),
                       decimal.formatted(.number.precision(.integerAndFractionLength(integerLimits: ...0, fractionLimits: ...0))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: ...3, fractionLimits: ...3))),
                       decimal.formatted(.number.precision(.integerAndFractionLength(integerLimits: ...3, fractionLimits: ...3))))

        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: ...8, fractionLimits: ...8))),
                       decimal.formatted(.number.precision(.integerAndFractionLength(integerLimits: ...8, fractionLimits: ...8))))

#warning("🆘 Apple's API loses decimal precision in this output")
        XCTAssertEqual(decimal.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: ...20, fractionLimits: ...20))),
                       decimal.formatted(.number.precision(.integerAndFractionLength(integerLimits: ...20, fractionLimits: ...20))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testDecimalSeparator() {
        let decimal = Decimal(123_456)

        XCTAssertEqual(decimal.bpFormatted(.number.decimalSeparator(strategy: .automatic)),
                       decimal.formatted(.number.decimalSeparator(strategy: .automatic)))

        XCTAssertEqual(decimal.bpFormatted(.number.decimalSeparator(strategy: .always)),
                       decimal.formatted(.number.decimalSeparator(strategy: .always)))
    }

    /*
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testRounded() {
        let decimal = Decimal(123_456.123_456)

        XCTAssertEqual(decimal.bpFormatted(.number.rounded(rule: .toNearestOrAwayFromZero)),
                       decimal.formatted(.number.rounded(rule: .toNearestOrAwayFromZero)))

        XCTAssertEqual(decimal.bpFormatted(.number.rounded(rule: .toNearestOrEven)),
                       decimal.formatted(.number.rounded(rule: .toNearestOrEven)))

        XCTAssertEqual(decimal.bpFormatted(.number.rounded(rule: .up)),
                       decimal.formatted(.number.rounded(rule: .up)))

        XCTAssertEqual(decimal.bpFormatted(.number.rounded(rule: .down)),
                       decimal.formatted(.number.rounded(rule: .down)))

        XCTAssertEqual(decimal.bpFormatted(.number.rounded(rule: .towardZero)),
                       decimal.formatted(.number.rounded(rule: .towardZero)))

        XCTAssertEqual(decimal.bpFormatted(.number.rounded(rule: .awayFromZero)),
                       decimal.formatted(.number.rounded(rule: .awayFromZero)))
    }
     */

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testScale() {
        let decimal = Decimal(123_456.123_456)

        XCTAssertEqual(decimal.bpFormatted(.number.scale(2)),
                       decimal.formatted(.number.scale(2)))

        XCTAssertEqual(decimal.bpFormatted(.number.scale(0)),
                       decimal.formatted(.number.scale(0)))

        XCTAssertEqual(decimal.bpFormatted(.number.scale(10)),
                       decimal.formatted(.number.scale(10)))

        XCTAssertEqual(decimal.bpFormatted(.number.scale(-5)),
                       decimal.formatted(.number.scale(-5)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testNotation() {
        let decimal = Decimal(123_456.123_456)

        XCTAssertEqual(decimal.bpFormatted(.number.notation(.automatic)),
                       decimal.formatted(.number.notation(.automatic)))

        XCTAssertEqual(decimal.bpFormatted(.number.notation(.scientific)),
                       decimal.formatted(.number.notation(.scientific)))

//        XCTAssertEqual(decimal.bpFormatted(.number.notation(.compactName)),
//                       decimal.formatted(.number.notation(.compactName)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testInteroperability() throws {
        try assertInteroperability(.number,
                                   .number)

        try assertInteroperability(.number.scale(5).notation(.scientific),
                                   .number.scale(5).notation(.scientific))

#warning("🆘 Apple's own api cannot decode a Decimal.FormatStyle that has the integerAndFractionLength modifier :/")
//        try assertInteroperability(.number.precision(.integerAndFractionLength(integerLimits: 0...20, fractionLimits: ...20)),
//                                   .number.precision(.integerAndFractionLength(integerLimits: 0...20, fractionLimits: ...20)))

        try assertInteroperability(.number.precision(.significantDigits(6)),
                                   .number.precision(.significantDigits(6)))

        try assertInteroperability(.number.scale(5).notation(.scientific).decimalSeparator(strategy: .always).grouping(.never).precision(.significantDigits(0...20)).sign(strategy: .never),
                                   .number.scale(5).notation(.scientific).decimalSeparator(strategy: .always).grouping(.never).precision(.significantDigits(0...20)).sign(strategy: .never))

        let locale = Locale(identifier: "en-US")
        try assertInteroperability(Decimal.BPFormatStyle(locale: locale),
                                   Decimal.FormatStyle(locale: locale))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func assertInteroperability(_ bpFormat: Decimal.BPFormatStyle, _ format: Decimal.FormatStyle) throws {
        let decimal = Decimal(123_456.123_456)

        let bpEncoded = try JSONEncoder().encode(bpFormat)

        XCTAssertNoThrow(try JSONDecoder().decode(Decimal.BPFormatStyle.self, from: bpEncoded))
        let appleEncoded = try JSONEncoder().encode(format)

        // Check if both json results have the same keys
        let bpSortedKeys = (try JSONSerialization.jsonObject(with: bpEncoded, options: []) as? [String: Any])?.keys.sorted() ?? []
        let appleSortedKeys = (try JSONSerialization.jsonObject(with: appleEncoded, options: []) as? [String: Any])?.keys.sorted() ?? []
        XCTAssertEqual(bpSortedKeys, appleSortedKeys)

        // Check if Apple can decode an encoded BPFormatStyle and compare the formatted result
        let appleDecoded = try JSONDecoder().decode(Decimal.FormatStyle.self, from: bpEncoded)
        XCTAssertEqual(decimal.bpFormatted(bpFormat),
                       decimal.formatted(appleDecoded))
    }

    // Since we're using a single NumberFormatter behind the scenes and multiple threads can call into this formatting api, we need to make sure there are no concurrency issues (without using async await)
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testConcurrency() {
        let decimal = Decimal(123_456.123_456)
        let repetitions = 1_000
        let scientificExpectation = expectation(description: "Complete scientific tests")
        scientificExpectation.expectedFulfillmentCount = repetitions
        let significantScaledPrecisionExpectation = expectation(description: "Complete significant scaled precision tests")
        significantScaledPrecisionExpectation.expectedFulfillmentCount = repetitions

        let scientificQueue = DispatchQueue(label: "Scientific")
        let significantScaledPrecisionQueue = DispatchQueue(label: "Significant scaled precision")

        scientificQueue.async {
            for _ in 0..<repetitions {
                XCTAssertEqual(decimal.bpFormatted(.number.notation(.scientific)),
                               decimal.bpFormatted(.number.notation(.scientific)))
                scientificExpectation.fulfill()
            }
        }
        significantScaledPrecisionQueue.async {
            for _ in 0..<repetitions {
                XCTAssertEqual(decimal.bpFormatted(.number.decimalSeparator(strategy: .always).scale(5).precision(.significantDigits(20))),
                               decimal.bpFormatted(.number.decimalSeparator(strategy: .always).scale(5).precision(.significantDigits(20))))
                significantScaledPrecisionExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 30, handler: nil)
    }
}

#endif
