//
//  FloatTests.swift
//  
//
//  Created by Simon Salomons on 05/07/2021.
//

import Foundation

import XCTest
@testable import BPFormatted

// Since we're comparing against api's from the base SDK's in Xcode 13, there's no reason to compile these tests
#if swift(>=5.5)

final class FloatTests: XCTestCase {

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testGeneral() {
        let double: Double = 123_456.123_456

        XCTAssertEqual(Float(double).bpFormatted(),
                       Float(double).formatted())

        XCTAssertEqual(double.bpFormatted(),
                       double.formatted())

        XCTAssertEqual(double.bpFormatted(.number),
                       double.formatted(.number))

        XCTAssertEqual(double.bpFormatted(BPFloatingPointFormatStyle()),
                       double.formatted(FloatingPointFormatStyle()))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testLocale() {
        let double: Double = 123_456.123_456

        var locale = Locale(identifier: "be-NL")
        XCTAssertEqual(double.bpFormatted(.number.locale(locale)),
                       double.formatted(.number.locale(locale)))

        XCTAssertEqual(double.bpFormatted(BPFloatingPointFormatStyle(locale: locale)),
                       double.formatted(FloatingPointFormatStyle(locale: locale)))


        locale = Locale(identifier: "en-US")
        XCTAssertEqual(double.bpFormatted(.number.locale(locale)),
                       double.formatted(.number.locale(locale)))

        XCTAssertEqual(double.bpFormatted(BPFloatingPointFormatStyle(locale: locale)),
                       double.formatted(FloatingPointFormatStyle(locale: locale)))


        locale = Locale(identifier: "en-UK")
        XCTAssertEqual(double.bpFormatted(.number.locale(locale)),
                       double.formatted(.number.locale(locale)))

        XCTAssertEqual(double.bpFormatted(BPFloatingPointFormatStyle(locale: locale)),
                       double.formatted(FloatingPointFormatStyle(locale: locale)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testSignStrategy() {
        XCTAssertEqual(Double(-1).bpFormatted(.number.sign(strategy: .automatic)),
                       Double(-1).formatted(.number.sign(strategy: .automatic)))

        XCTAssertEqual(Double(0).bpFormatted(.number.sign(strategy: .automatic)),
                       Double(0).formatted(.number.sign(strategy: .automatic)))

        XCTAssertEqual(Double(1).bpFormatted(.number.sign(strategy: .automatic)),
                       Double(1).formatted(.number.sign(strategy: .automatic)))


        XCTAssertEqual(Double(-1).bpFormatted(.number.sign(strategy: .never)),
                       Double(-1).formatted(.number.sign(strategy: .never)))

        XCTAssertEqual(Double(0).bpFormatted(.number.sign(strategy: .never)),
                       Double(0).formatted(.number.sign(strategy: .never)))

        XCTAssertEqual(Double(1).bpFormatted(.number.sign(strategy: .never)),
                       Double(1).formatted(.number.sign(strategy: .never)))


        XCTAssertEqual(Double(-1).bpFormatted(.number.sign(strategy: .always(includingZero: false))),
                       Double(-1).formatted(.number.sign(strategy: .always(includingZero: false))))

        XCTAssertEqual(Double(0).bpFormatted(.number.sign(strategy: .always(includingZero: false))),
                       Double(0).formatted(.number.sign(strategy: .always(includingZero: false))))

        XCTAssertEqual(Double(1).bpFormatted(.number.sign(strategy: .always(includingZero: false))),
                       Double(1).formatted(.number.sign(strategy: .always(includingZero: false))))


        XCTAssertEqual(Double(-1).bpFormatted(.number.sign(strategy: .always(includingZero: true))),
                       Double(-1).formatted(.number.sign(strategy: .always(includingZero: true))))

        XCTAssertEqual(Double(0).bpFormatted(.number.sign(strategy: .always(includingZero: true))),
                       Double(0).formatted(.number.sign(strategy: .always(includingZero: true))))

        XCTAssertEqual(Double(1).bpFormatted(.number.sign(strategy: .always(includingZero: true))),
                       Double(1).formatted(.number.sign(strategy: .always(includingZero: true))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testGrouping() {
        let double: Double = 123_456.123_456

        XCTAssertEqual(double.bpFormatted(.number.grouping(.never)),
                       double.formatted(.number.grouping(.never)))

        XCTAssertEqual(double.bpFormatted(.number.grouping(.automatic)),
                       double.formatted(.number.grouping(.automatic)))

        let usa = Locale(identifier: "en-US")
        XCTAssertEqual(double.bpFormatted(.number.locale(usa).grouping(.never)),
                       double.formatted(.number.locale(usa).grouping(.never)))

        XCTAssertEqual(double.bpFormatted(.number.locale(usa).grouping(.automatic)),
                       double.formatted(.number.locale(usa).grouping(.automatic)))

        let france = Locale(identifier: "fr-FR")
        XCTAssertEqual(double.bpFormatted(.number.locale(france).grouping(.never)),
                       double.formatted(.number.locale(france).grouping(.never)))

        XCTAssertEqual(double.bpFormatted(.number.locale(france).grouping(.automatic)),
                       double.formatted(.number.locale(france).grouping(.automatic)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testPrecisionSignificant() {
        let double: Double = 123_456.123_456

        XCTAssertEqual(double.bpFormatted(.number.precision(.significantDigits(3))),
                       double.formatted(.number.precision(.significantDigits(3))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.significantDigits(1))),
                       double.formatted(.number.precision(.significantDigits(1))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.significantDigits(8))),
                       double.formatted(.number.precision(.significantDigits(8))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.significantDigits(20))),
                       double.formatted(.number.precision(.significantDigits(20))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.significantDigits(1_000_000))),
                       double.formatted(.number.precision(.significantDigits(1_000_000))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.significantDigits(0))),
                       double.formatted(.number.precision(.significantDigits(0))))


        XCTAssertEqual(double.bpFormatted(.number.precision(.significantDigits(0...3))),
                       double.formatted(.number.precision(.significantDigits(0...3))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.significantDigits(0...8))),
                       double.formatted(.number.precision(.significantDigits(0...8))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.significantDigits(0...20))),
                       double.formatted(.number.precision(.significantDigits(0...20))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.significantDigits(0...1_000_000))),
                       double.formatted(.number.precision(.significantDigits(0...1_000_000))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.significantDigits(-100..<(-50)))),
                       double.formatted(.number.precision(.significantDigits(-100..<(-50)))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.significantDigits(0...))),
                       double.formatted(.number.precision(.significantDigits(0...))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.significantDigits(20...))),
                       double.formatted(.number.precision(.significantDigits(20...))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testPrecisionInteger() {
        let double: Double = 123_456.123_456

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerLength(0))),
                       double.formatted(.number.precision(.integerLength(0))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerLength(3))),
                       double.formatted(.number.precision(.integerLength(3))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerLength(8))),
                       double.formatted(.number.precision(.integerLength(8))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerLength(20))),
                       double.formatted(.number.precision(.integerLength(20))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerLength(1_000_000))),
                       double.formatted(.number.precision(.integerLength(1_000_000))))


        XCTAssertEqual(double.bpFormatted(.number.precision(.integerLength(0...3))),
                       double.formatted(.number.precision(.integerLength(0...3))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerLength(0...8))),
                       double.formatted(.number.precision(.integerLength(0...8))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerLength(0...20))),
                       double.formatted(.number.precision(.integerLength(0...20))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerLength(0...1_000_000))),
                       double.formatted(.number.precision(.integerLength(0...1_000_000))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerLength(-100..<(-50)))),
                       double.formatted(.number.precision(.integerLength(-100..<(-50)))))


        XCTAssertEqual(double.bpFormatted(.number.precision(.integerLength(0...))),
                       double.formatted(.number.precision(.integerLength(0...))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerLength(20...))),
                       double.formatted(.number.precision(.integerLength(20...))))


        XCTAssertEqual(double.bpFormatted(.number.precision(.integerLength(...0))),
                       double.formatted(.number.precision(.integerLength(...0))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerLength(...3))),
                       double.formatted(.number.precision(.integerLength(...3))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerLength(...8))),
                       double.formatted(.number.precision(.integerLength(...8))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerLength(...20))),
                       double.formatted(.number.precision(.integerLength(...20))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testPrecisionFractional() {
        let double: Double = 123_456.123_456

        XCTAssertEqual(double.bpFormatted(.number.precision(.fractionLength(0))),
                       double.formatted(.number.precision(.fractionLength(0))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.fractionLength(3))),
                       double.formatted(.number.precision(.fractionLength(3))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.fractionLength(8))),
                       double.formatted(.number.precision(.fractionLength(8))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.fractionLength(20))),
                       double.formatted(.number.precision(.fractionLength(20))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.fractionLength(1_000_000))),
                       double.formatted(.number.precision(.fractionLength(1_000_000))))


        XCTAssertEqual(double.bpFormatted(.number.precision(.fractionLength(0...3))),
                       double.formatted(.number.precision(.fractionLength(0...3))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.fractionLength(0...8))),
                       double.formatted(.number.precision(.fractionLength(0...8))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.fractionLength(0...20))),
                       double.formatted(.number.precision(.fractionLength(0...20))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.fractionLength(0...1_000_000))),
                       double.formatted(.number.precision(.fractionLength(0...1_000_000))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.fractionLength(-100..<(-50)))),
                       double.formatted(.number.precision(.fractionLength(-100..<(-50)))))


        XCTAssertEqual(double.bpFormatted(.number.precision(.fractionLength(0...))),
                       double.formatted(.number.precision(.fractionLength(0...))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.fractionLength(20...))),
                       double.formatted(.number.precision(.fractionLength(20...))))


        XCTAssertEqual(double.bpFormatted(.number.precision(.fractionLength(...0))),
                       double.formatted(.number.precision(.fractionLength(...0))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.fractionLength(...3))),
                       double.formatted(.number.precision(.fractionLength(...3))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.fractionLength(...8))),
                       double.formatted(.number.precision(.fractionLength(...8))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.fractionLength(...20))),
                       double.formatted(.number.precision(.fractionLength(...20))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testPrecisionIntegerAndFractional() {
        let double: Double = 123_456.123_456

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerAndFractionLength(integer: 0, fraction: 0))),
                       double.formatted(.number.precision(.integerAndFractionLength(integer: 0, fraction: 0))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerAndFractionLength(integer: 3, fraction: 3))),
                       double.formatted(.number.precision(.integerAndFractionLength(integer: 3, fraction: 3))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerAndFractionLength(integer: 8, fraction: 8))),
                       double.formatted(.number.precision(.integerAndFractionLength(integer: 8, fraction: 8))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerAndFractionLength(integer: 20, fraction: 20))),
                       double.formatted(.number.precision(.integerAndFractionLength(integer: 20, fraction: 20))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerAndFractionLength(integer: 1_000_000, fraction: 1_000_000))),
                       double.formatted(.number.precision(.integerAndFractionLength(integer: 1_000_000, fraction: 1_000_000))))


        XCTAssertEqual(double.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: 0...3, fractionLimits: 0...3))),
                       double.formatted(.number.precision(.integerAndFractionLength(integerLimits: 0...3, fractionLimits: 0...3))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: 0...8, fractionLimits: 0...8))),
                       double.formatted(.number.precision(.integerAndFractionLength(integerLimits: 0...8, fractionLimits: 0...8))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: 0...20, fractionLimits: 0...20))),
                       double.formatted(.number.precision(.integerAndFractionLength(integerLimits: 0...20, fractionLimits: 0...20))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: 0...1_000_000, fractionLimits: 0...1_000_000))),
                       double.formatted(.number.precision(.integerAndFractionLength(integerLimits: 0...1_000_000, fractionLimits: 0...1_000_000))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: -100..<(-50), fractionLimits: -100..<(-50)))),
                       double.formatted(.number.precision(.integerAndFractionLength(integerLimits: -100..<(-50), fractionLimits: -100..<(-50)))))


        XCTAssertEqual(double.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: 0..., fractionLimits: 0...))),
                       double.formatted(.number.precision(.integerAndFractionLength(integerLimits: 0..., fractionLimits: 0...))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: 20..., fractionLimits: 20...))),
                       double.formatted(.number.precision(.integerAndFractionLength(integerLimits: 20..., fractionLimits: 20...))))


        XCTAssertEqual(double.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: ...0, fractionLimits: ...0))),
                       double.formatted(.number.precision(.integerAndFractionLength(integerLimits: ...0, fractionLimits: ...0))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: ...3, fractionLimits: ...3))),
                       double.formatted(.number.precision(.integerAndFractionLength(integerLimits: ...3, fractionLimits: ...3))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: ...8, fractionLimits: ...8))),
                       double.formatted(.number.precision(.integerAndFractionLength(integerLimits: ...8, fractionLimits: ...8))))

        XCTAssertEqual(double.bpFormatted(.number.precision(.integerAndFractionLength(integerLimits: ...20, fractionLimits: ...20))),
                       double.formatted(.number.precision(.integerAndFractionLength(integerLimits: ...20, fractionLimits: ...20))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testDecimalSeparator() {
        let double: Double = 123_456.123_456

        XCTAssertEqual(double.bpFormatted(.number.decimalSeparator(strategy: .automatic)),
                       double.formatted(.number.decimalSeparator(strategy: .automatic)))

        XCTAssertEqual(double.bpFormatted(.number.decimalSeparator(strategy: .always)),
                       double.formatted(.number.decimalSeparator(strategy: .always)))
    }

    /*
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testRounded() {
        let double: Double = 123_456.123_456

        XCTAssertEqual(double.bpFormatted(.number.rounded(rule: .toNearestOrAwayFromZero)),
                       double.formatted(.number.rounded(rule: .toNearestOrAwayFromZero)))

        XCTAssertEqual(double.bpFormatted(.number.rounded(rule: .toNearestOrEven)),
                       double.formatted(.number.rounded(rule: .toNearestOrEven)))

        XCTAssertEqual(double.bpFormatted(.number.rounded(rule: .up)),
                       double.formatted(.number.rounded(rule: .up)))

        XCTAssertEqual(double.bpFormatted(.number.rounded(rule: .down)),
                       double.formatted(.number.rounded(rule: .down)))

        XCTAssertEqual(double.bpFormatted(.number.rounded(rule: .towardZero)),
                       double.formatted(.number.rounded(rule: .towardZero)))

        XCTAssertEqual(double.bpFormatted(.number.rounded(rule: .awayFromZero)),
                       double.formatted(.number.rounded(rule: .awayFromZero)))
    }
     */

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testScale() {
        let double: Double = 123_456.123_456

        XCTAssertEqual(double.bpFormatted(.number.scale(2)),
                       double.formatted(.number.scale(2)))

        XCTAssertEqual(double.bpFormatted(.number.scale(0)),
                       double.formatted(.number.scale(0)))

        XCTAssertEqual(double.bpFormatted(.number.scale(10)),
                       double.formatted(.number.scale(10)))

        XCTAssertEqual(double.bpFormatted(.number.scale(-5)),
                       double.formatted(.number.scale(-5)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testNotation() {
        let double: Double = 123_456.123_456

        XCTAssertEqual(double.bpFormatted(.number.notation(.automatic)),
                       double.formatted(.number.notation(.automatic)))

        print(double.formatted(.number.notation(.scientific)))

        XCTAssertEqual(double.bpFormatted(.number.notation(.scientific)),
                       double.formatted(.number.notation(.scientific)))

//        XCTAssertEqual(double.bpFormatted(.number.notation(.compactName)),
//                       double.formatted(.number.notation(.compactName)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testInteroperability() throws {
        try assertInteroperability(.number,
                                   .number)

        try assertInteroperability(.number.scale(5).notation(.scientific),
                                   .number.scale(5).notation(.scientific))

#warning("🆘 Apple's own api cannot decode a FloatingPointFormatStyle that has the integerAndFractionLength modifier :/")
//        try assertInteroperability(.number.precision(.integerAndFractionLength(integerLimits: 0...20, fractionLimits: ...20)),
//                                   .number.precision(.integerAndFractionLength(integerLimits: 0...20, fractionLimits: ...20)))

        try assertInteroperability(.number.precision(.significantDigits(6)),
                                   .number.precision(.significantDigits(6)))

        try assertInteroperability(.number.scale(5).notation(.scientific).decimalSeparator(strategy: .always).grouping(.never).precision(.significantDigits(0...20)).sign(strategy: .never),
                                   .number.scale(5).notation(.scientific).decimalSeparator(strategy: .always).grouping(.never).precision(.significantDigits(0...20)).sign(strategy: .never))

        let locale = Locale(identifier: "en-US")
        try assertInteroperability(BPFloatingPointFormatStyle(locale: locale),
                                   FloatingPointFormatStyle(locale: locale))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func assertInteroperability(_ bpFormat: BPFloatingPointFormatStyle, _ format: FloatingPointFormatStyle) throws {
        let double: Double = 123_456.123_456

        let bpEncoded = try JSONEncoder().encode(bpFormat)

        XCTAssertNoThrow(try JSONDecoder().decode(Decimal.BPFormatStyle.self, from: bpEncoded))
        let appleEncoded = try JSONEncoder().encode(format)

        // Check if both json results have the same keys
        let bpSortedKeys = (try JSONSerialization.jsonObject(with: bpEncoded, options: []) as? [String: Any])?.keys.sorted() ?? []
        let appleSortedKeys = (try JSONSerialization.jsonObject(with: appleEncoded, options: []) as? [String: Any])?.keys.sorted() ?? []
        XCTAssertEqual(bpSortedKeys, appleSortedKeys)

        // Check if Apple can decode an encoded BPFormatStyle and compare the formatted result
        let appleDecoded = try JSONDecoder().decode(FloatingPointFormatStyle.self, from: bpEncoded)
        XCTAssertEqual(double.bpFormatted(bpFormat),
                       double.formatted(appleDecoded))
    }

    // Since we're using a single NumberFormatter behind the scenes and multiple threads can call into this formatting api, we need to make sure there are no concurrency issues (without using async await)
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testConcurrency() {
        let double: Double = 123_456.123_456
        let repetitions = 1_000
        let scientificExpectation = expectation(description: "Complete scientific tests")
        scientificExpectation.expectedFulfillmentCount = repetitions
        let significantScaledPrecisionExpectation = expectation(description: "Complete significant scaled precision tests")
        significantScaledPrecisionExpectation.expectedFulfillmentCount = repetitions

        let scientificQueue = DispatchQueue(label: "Scientific")
        let significantScaledPrecisionQueue = DispatchQueue(label: "Significant scaled precision")

        scientificQueue.async {
            for _ in 0..<repetitions {
                XCTAssertEqual(double.bpFormatted(.number.notation(.scientific)),
                               double.bpFormatted(.number.notation(.scientific)))
                scientificExpectation.fulfill()
            }
        }
        significantScaledPrecisionQueue.async {
            for _ in 0..<repetitions {
                XCTAssertEqual(double.bpFormatted(.number.decimalSeparator(strategy: .always).scale(5).precision(.significantDigits(20))),
                               double.bpFormatted(.number.decimalSeparator(strategy: .always).scale(5).precision(.significantDigits(20))))
                significantScaledPrecisionExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 30, handler: nil)
    }
}
#endif
