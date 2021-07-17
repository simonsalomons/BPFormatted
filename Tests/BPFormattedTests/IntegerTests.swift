//
//  IntegerTests.swift
//  
//
//  Created by Simon Salomons on 04/07/2021.
//

import Foundation

import XCTest
@testable import BPFormatted

// Since we're comparing against api's from the base SDK's in Xcode 13, there's no reason to compile these tests
#if swift(>=5.5)

final class IntegerTests: XCTestCase {

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testGeneral() {
        let integer = 123_456

        XCTAssertEqual(Int32(integer).bpFormatted(),
                       Int32(integer).formatted())

        XCTAssertEqual(integer.bpFormatted(),
                       integer.formatted())

        XCTAssertEqual(integer.bpFormatted(.number),
                       integer.formatted(.number))

        XCTAssertEqual(integer.bpFormatted(BPIntegerFormatStyle()),
                       integer.formatted(IntegerFormatStyle()))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testLocale() {
        let integer = 123_456

        var locale = Locale(identifier: "be-NL")
        XCTAssertEqual(integer.bpFormatted(.number.locale(locale)),
                       integer.formatted(.number.locale(locale)))

        XCTAssertEqual(integer.bpFormatted(BPIntegerFormatStyle(locale: locale)),
                       integer.formatted(IntegerFormatStyle(locale: locale)))


        locale = Locale(identifier: "en-US")
        XCTAssertEqual(integer.bpFormatted(.number.locale(locale)),
                       integer.formatted(.number.locale(locale)))

        XCTAssertEqual(integer.bpFormatted(BPIntegerFormatStyle(locale: locale)),
                       integer.formatted(IntegerFormatStyle(locale: locale)))


        locale = Locale(identifier: "en-UK")
        XCTAssertEqual(integer.bpFormatted(.number.locale(locale)),
                       integer.formatted(.number.locale(locale)))

        XCTAssertEqual(integer.bpFormatted(BPIntegerFormatStyle(locale: locale)),
                       integer.formatted(IntegerFormatStyle(locale: locale)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testSignStrategy() {
        XCTAssertEqual((-1).bpFormatted(.number.sign(strategy: .automatic)),
                       (-1).formatted(.number.sign(strategy: .automatic)))

        XCTAssertEqual(0.bpFormatted(.number.sign(strategy: .automatic)),
                       0.formatted(.number.sign(strategy: .automatic)))

        XCTAssertEqual(1.bpFormatted(.number.sign(strategy: .automatic)),
                       1.formatted(.number.sign(strategy: .automatic)))


        XCTAssertEqual((-1).bpFormatted(.number.sign(strategy: .never)),
                       (-1).formatted(.number.sign(strategy: .never)))

        XCTAssertEqual(0.bpFormatted(.number.sign(strategy: .never)),
                       0.formatted(.number.sign(strategy: .never)))

        XCTAssertEqual(1.bpFormatted(.number.sign(strategy: .never)),
                       1.formatted(.number.sign(strategy: .never)))


        XCTAssertEqual((-1).bpFormatted(.number.sign(strategy: .always(includingZero: false))),
                       (-1).formatted(.number.sign(strategy: .always(includingZero: false))))

        XCTAssertEqual(0.bpFormatted(.number.sign(strategy: .always(includingZero: false))),
                       0.formatted(.number.sign(strategy: .always(includingZero: false))))

        XCTAssertEqual(1.bpFormatted(.number.sign(strategy: .always(includingZero: false))),
                       1.formatted(.number.sign(strategy: .always(includingZero: false))))


        XCTAssertEqual((-1).bpFormatted(.number.sign(strategy: .always(includingZero: true))),
                       (-1).formatted(.number.sign(strategy: .always(includingZero: true))))

        XCTAssertEqual(0.bpFormatted(.number.sign(strategy: .always(includingZero: true))),
                       0.formatted(.number.sign(strategy: .always(includingZero: true))))

        XCTAssertEqual(1.bpFormatted(.number.sign(strategy: .always(includingZero: true))),
                       1.formatted(.number.sign(strategy: .always(includingZero: true))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testGrouping() {
        let integer = 123_456

        XCTAssertEqual(integer.bpFormatted(.number.grouping(.never)),
                       integer.formatted(.number.grouping(.never)))

        XCTAssertEqual(integer.bpFormatted(.number.grouping(.automatic)),
                       integer.formatted(.number.grouping(.automatic)))

        let usa = Locale(identifier: "en-US")
        XCTAssertEqual(integer.bpFormatted(.number.locale(usa).grouping(.never)),
                       integer.formatted(.number.locale(usa).grouping(.never)))

        XCTAssertEqual(integer.bpFormatted(.number.locale(usa).grouping(.automatic)),
                       integer.formatted(.number.locale(usa).grouping(.automatic)))

        let france = Locale(identifier: "fr-FR")
        XCTAssertEqual(integer.bpFormatted(.number.locale(france).grouping(.never)),
                       integer.formatted(.number.locale(france).grouping(.never)))

        XCTAssertEqual(integer.bpFormatted(.number.locale(france).grouping(.automatic)),
                       integer.formatted(.number.locale(france).grouping(.automatic)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testPrecisionSignificant() {
        let integer = 123_456

        XCTAssertEqual(integer.bpFormatted(.number.precision(.significantDigits(3))),
                       integer.formatted(.number.precision(.significantDigits(3))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.significantDigits(1))),
                       integer.formatted(.number.precision(.significantDigits(1))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.significantDigits(8))),
                       integer.formatted(.number.precision(.significantDigits(8))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.significantDigits(20))),
                       integer.formatted(.number.precision(.significantDigits(20))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.significantDigits(1_000_000))),
                       integer.formatted(.number.precision(.significantDigits(1_000_000))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.significantDigits(0))),
                       integer.formatted(.number.precision(.significantDigits(0))))


        XCTAssertEqual(integer.bpFormatted(.number.precision(.significantDigits(0...3))),
                       integer.formatted(.number.precision(.significantDigits(0...3))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.significantDigits(0...8))),
                       integer.formatted(.number.precision(.significantDigits(0...8))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.significantDigits(0...20))),
                       integer.formatted(.number.precision(.significantDigits(0...20))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.significantDigits(0...1_000_000))),
                       integer.formatted(.number.precision(.significantDigits(0...1_000_000))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.significantDigits(-100..<(-50)))),
                       integer.formatted(.number.precision(.significantDigits(-100..<(-50)))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.significantDigits(0...))),
                       integer.formatted(.number.precision(.significantDigits(0...))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.significantDigits(20...))),
                       integer.formatted(.number.precision(.significantDigits(20...))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testPrecisionInteger() {
        let integer = 123_456

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerLength(0))),
                       integer.formatted(.number.precision(.integerLength(0))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerLength(3))),
                       integer.formatted(.number.precision(.integerLength(3))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerLength(8))),
                       integer.formatted(.number.precision(.integerLength(8))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerLength(20))),
                       integer.formatted(.number.precision(.integerLength(20))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerLength(1_000_000))),
                       integer.formatted(.number.precision(.integerLength(1_000_000))))


        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerLength(0...3))),
                       integer.formatted(.number.precision(.integerLength(0...3))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerLength(0...8))),
                       integer.formatted(.number.precision(.integerLength(0...8))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerLength(0...20))),
                       integer.formatted(.number.precision(.integerLength(0...20))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerLength(0...1_000_000))),
                       integer.formatted(.number.precision(.integerLength(0...1_000_000))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerLength(-100..<(-50)))),
                       integer.formatted(.number.precision(.integerLength(-100..<(-50)))))


        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerLength(0...))),
                       integer.formatted(.number.precision(.integerLength(0...))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerLength(20...))),
                       integer.formatted(.number.precision(.integerLength(20...))))


        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerLength(...0))),
                       integer.formatted(.number.precision(.integerLength(...0))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerLength(...3))),
                       integer.formatted(.number.precision(.integerLength(...3))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerLength(...8))),
                       integer.formatted(.number.precision(.integerLength(...8))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerLength(...20))),
                       integer.formatted(.number.precision(.integerLength(...20))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testPrecisionFractional() {
        let integer = 123_456

        XCTAssertEqual(integer.bpFormatted(.number.precision(.fractionLength(0))),
                       integer.formatted(.number.precision(.fractionLength(0))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.fractionLength(3))),
                       integer.formatted(.number.precision(.fractionLength(3))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.fractionLength(8))),
                       integer.formatted(.number.precision(.fractionLength(8))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.fractionLength(20))),
                       integer.formatted(.number.precision(.fractionLength(20))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.fractionLength(1_000_000))),
                       integer.formatted(.number.precision(.fractionLength(1_000_000))))


        XCTAssertEqual(integer.bpFormatted(.number.precision(.fractionLength(0...3))),
                       integer.formatted(.number.precision(.fractionLength(0...3))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.fractionLength(0...8))),
                       integer.formatted(.number.precision(.fractionLength(0...8))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.fractionLength(0...20))),
                       integer.formatted(.number.precision(.fractionLength(0...20))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.fractionLength(0...1_000_000))),
                       integer.formatted(.number.precision(.fractionLength(0...1_000_000))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.fractionLength(-100..<(-50)))),
                       integer.formatted(.number.precision(.fractionLength(-100..<(-50)))))


        XCTAssertEqual(integer.bpFormatted(.number.precision(.fractionLength(0...))),
                       integer.formatted(.number.precision(.fractionLength(0...))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.fractionLength(20...))),
                       integer.formatted(.number.precision(.fractionLength(20...))))


        XCTAssertEqual(integer.bpFormatted(.number.precision(.fractionLength(...0))),
                       integer.formatted(.number.precision(.fractionLength(...0))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.fractionLength(...3))),
                       integer.formatted(.number.precision(.fractionLength(...3))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.fractionLength(...8))),
                       integer.formatted(.number.precision(.fractionLength(...8))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.fractionLength(...20))),
                       integer.formatted(.number.precision(.fractionLength(...20))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testPrecisionIntegerAndFractional() {
        let integer = 123_456

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerAndFractionLength(integer: 0, fraction: 0))),
                       integer.formatted(.number.precision(.integerAndFractionLength(integer: 0, fraction: 0))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerAndFractionLength(integer: 3, fraction: 3))),
                       integer.formatted(.number.precision(.integerAndFractionLength(integer: 3, fraction: 3))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerAndFractionLength(integer: 8, fraction: 8))),
                       integer.formatted(.number.precision(.integerAndFractionLength(integer: 8, fraction: 8))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerAndFractionLength(integer: 20, fraction: 20))),
                       integer.formatted(.number.precision(.integerAndFractionLength(integer: 20, fraction: 20))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerAndFractionLength(integer: 1_000_000, fraction: 1_000_000))),
                       integer.formatted(.number.precision(.integerAndFractionLength(integer: 1_000_000, fraction: 1_000_000))))


        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: 0...3, fractionLimits: 0...3))),
                       integer.formatted(.number.precision(.integerAndFractionLength(integerLimits: 0...3, fractionLimits: 0...3))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: 0...8, fractionLimits: 0...8))),
                       integer.formatted(.number.precision(.integerAndFractionLength(integerLimits: 0...8, fractionLimits: 0...8))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: 0...20, fractionLimits: 0...20))),
                       integer.formatted(.number.precision(.integerAndFractionLength(integerLimits: 0...20, fractionLimits: 0...20))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: 0...1_000_000, fractionLimits: 0...1_000_000))),
                       integer.formatted(.number.precision(.integerAndFractionLength(integerLimits: 0...1_000_000, fractionLimits: 0...1_000_000))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: -100..<(-50), fractionLimits: -100..<(-50)))),
                       integer.formatted(.number.precision(.integerAndFractionLength(integerLimits: -100..<(-50), fractionLimits: -100..<(-50)))))


        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: 0..., fractionLimits: 0...))),
                       integer.formatted(.number.precision(.integerAndFractionLength(integerLimits: 0..., fractionLimits: 0...))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: 20..., fractionLimits: 20...))),
                       integer.formatted(.number.precision(.integerAndFractionLength(integerLimits: 20..., fractionLimits: 20...))))


        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: ...0, fractionLimits: ...0))),
                       integer.formatted(.number.precision(.integerAndFractionLength(integerLimits: ...0, fractionLimits: ...0))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: ...3, fractionLimits: ...3))),
                       integer.formatted(.number.precision(.integerAndFractionLength(integerLimits: ...3, fractionLimits: ...3))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: ...8, fractionLimits: ...8))),
                       integer.formatted(.number.precision(.integerAndFractionLength(integerLimits: ...8, fractionLimits: ...8))))

        XCTAssertEqual(integer.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: ...20, fractionLimits: ...20))),
                       integer.formatted(.number.precision(.integerAndFractionLength(integerLimits: ...20, fractionLimits: ...20))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testDecimalSeparator() {
        let integer = 123_456

        XCTAssertEqual(integer.bpFormatted(.number.decimalSeparator(strategy: .automatic)),
                       integer.formatted(.number.decimalSeparator(strategy: .automatic)))

        XCTAssertEqual(integer.bpFormatted(.number.decimalSeparator(strategy: .always)),
                       integer.formatted(.number.decimalSeparator(strategy: .always)))
    }

    /*
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testRounded() {
        let integer = 123_456

        XCTAssertEqual(integer.bpFormatted(.number.rounded(rule: .toNearestOrAwayFromZero)),
                       integer.formatted(.number.rounded(rule: .toNearestOrAwayFromZero)))

        XCTAssertEqual(integer.bpFormatted(.number.rounded(rule: .toNearestOrEven)),
                       integer.formatted(.number.rounded(rule: .toNearestOrEven)))

        XCTAssertEqual(integer.bpFormatted(.number.rounded(rule: .up)),
                       integer.formatted(.number.rounded(rule: .up)))

        XCTAssertEqual(integer.bpFormatted(.number.rounded(rule: .down)),
                       integer.formatted(.number.rounded(rule: .down)))

        XCTAssertEqual(integer.bpFormatted(.number.rounded(rule: .towardZero)),
                       integer.formatted(.number.rounded(rule: .towardZero)))

        XCTAssertEqual(integer.bpFormatted(.number.rounded(rule: .awayFromZero)),
                       integer.formatted(.number.rounded(rule: .awayFromZero)))
    }
     */

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testScale() {
        let integer = 123_456

        XCTAssertEqual(integer.bpFormatted(.number.scale(2)),
                       integer.formatted(.number.scale(2)))

        XCTAssertEqual(integer.bpFormatted(.number.scale(0)),
                       integer.formatted(.number.scale(0)))

        XCTAssertEqual(integer.bpFormatted(.number.scale(10)),
                       integer.formatted(.number.scale(10)))

        XCTAssertEqual(integer.bpFormatted(.number.scale(-5)),
                       integer.formatted(.number.scale(-5)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testNotation() {
        let integer = 123_456

        XCTAssertEqual(integer.bpFormatted(.number.notation(.automatic)),
                       integer.formatted(.number.notation(.automatic)))

        XCTAssertEqual(integer.bpFormatted(.number.notation(.scientific)),
                       integer.formatted(.number.notation(.scientific)))

//        XCTAssertEqual(integer.bpFormatted(.number.notation(.compactName)),
//                       integer.formatted(.number.notation(.compactName)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testInteroperability() throws {
        try assertInteroperability(.number,
                                   .number)

        try assertInteroperability(.number.scale(5).notation(.scientific),
                                   .number.scale(5).notation(.scientific))

#warning("🆘 Apple's own api cannot decode a IntegerFormatStyle that has the integerAndFractionLength modifier :/")
//        try assertInteroperability(.number.precision(.integerAndFractionLength(integerLimits: 0...20, fractionLimits: ...20)),
//                                   .number.precision(.integerAndFractionLength(integerLimits: 0...20, fractionLimits: ...20)))

        try assertInteroperability(.number.precision(.significantDigits(6)),
                                   .number.precision(.significantDigits(6)))

        try assertInteroperability(.number.scale(5).notation(.scientific).decimalSeparator(strategy: .always).grouping(.never).precision(.significantDigits(0...20)).sign(strategy: .never),
                                   .number.scale(5).notation(.scientific).decimalSeparator(strategy: .always).grouping(.never).precision(.significantDigits(0...20)).sign(strategy: .never))

        let locale = Locale(identifier: "en-US")
        try assertInteroperability(BPIntegerFormatStyle(locale: locale),
                                   IntegerFormatStyle(locale: locale))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func assertInteroperability(_ bpFormat: BPIntegerFormatStyle, _ format: IntegerFormatStyle) throws {
        let integer = 123_456

        let bpEncoded = try JSONEncoder().encode(bpFormat)

        XCTAssertNoThrow(try JSONDecoder().decode(Decimal.BPFormatStyle.self, from: bpEncoded))
        let appleEncoded = try JSONEncoder().encode(format)

        // Check if both json results have the same keys
        let bpSortedKeys = (try JSONSerialization.jsonObject(with: bpEncoded, options: []) as? [String: Any])?.keys.sorted() ?? []
        let appleSortedKeys = (try JSONSerialization.jsonObject(with: appleEncoded, options: []) as? [String: Any])?.keys.sorted() ?? []
        XCTAssertEqual(bpSortedKeys, appleSortedKeys)

        // Check if Apple can decode an encoded BPFormatStyle and compare the formatted result
        let appleDecoded = try JSONDecoder().decode(IntegerFormatStyle.self, from: bpEncoded)
        XCTAssertEqual(integer.bpFormatted(bpFormat),
                       integer.formatted(appleDecoded))
    }

    // Since we're using a single NumberFormatter behind the scenes and multiple threads can call into this formatting api, we need to make sure there are no concurrency issues (without using async await)
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testConcurrency() {
        let integer = 123_456
        let repetitions = 1_000
        let scientificExpectation = expectation(description: "Complete scientific tests")
        scientificExpectation.expectedFulfillmentCount = repetitions
        let significantScaledPrecisionExpectation = expectation(description: "Complete significant scaled precision tests")
        significantScaledPrecisionExpectation.expectedFulfillmentCount = repetitions

        let scientificQueue = DispatchQueue(label: "Scientific")
        let significantScaledPrecisionQueue = DispatchQueue(label: "Significant scaled precision")

        scientificQueue.async {
            for _ in 0..<repetitions {
                XCTAssertEqual(integer.bpFormatted(.number.notation(.scientific)),
                               integer.bpFormatted(.number.notation(.scientific)))
                scientificExpectation.fulfill()
            }
        }
        significantScaledPrecisionQueue.async {
            for _ in 0..<repetitions {
                XCTAssertEqual(integer.bpFormatted(.number.decimalSeparator(strategy: .always).scale(5).precision(.significantDigits(20))),
                               integer.bpFormatted(.number.decimalSeparator(strategy: .always).scale(5).precision(.significantDigits(20))))
                significantScaledPrecisionExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 30, handler: nil)
    }
}
#endif
