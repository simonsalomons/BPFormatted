//
//  CurrencyTests.swift
//
//  Created by Simon Salomons on 17/07/2021.
//

import XCTest
@testable import BPFormatted

// Since we're comparing against api's from the base SDK's in Xcode 13, there's no reason to compile these tests
#if swift(>=5.5)

final class CurrencyTests: XCTestCase {

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testGeneral() {
        let integer = 123_456

        XCTAssertEqual(integer.bpFormatted(.currency(code: "EUR")),
                       integer.formatted(.currency(code: "EUR")))

        XCTAssertEqual(integer.bpFormatted(.currency(code: "USD")),
                       integer.formatted(.currency(code: "USD")))

        XCTAssertEqual(integer.bpFormatted(.currency(code: "JPY")),
                       integer.formatted(.currency(code: "JPY")))

        XCTAssertEqual(integer.bpFormatted(BPIntegerFormatStyle.Currency(code: "EUR")),
                       integer.formatted(IntegerFormatStyle.Currency(code: "EUR")))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testLocale() {
        let integer = 123_456

        var locale = Locale(identifier: "be-NL")
        XCTAssertEqual(integer.bpFormatted(.currency(code: "EUR").locale(locale)),
                       integer.formatted(.currency(code: "EUR").locale(locale)))

        XCTAssertEqual(integer.bpFormatted(BPIntegerFormatStyle.Currency(code: "EUR", locale: locale)),
                       integer.formatted(IntegerFormatStyle.Currency(code: "EUR", locale: locale)))


        locale = Locale(identifier: "en-US")
        XCTAssertEqual(integer.bpFormatted(.currency(code: "EUR").locale(locale)),
                       integer.formatted(.currency(code: "EUR").locale(locale)))

        XCTAssertEqual(integer.bpFormatted(BPIntegerFormatStyle.Currency(code: "EUR", locale: locale)),
                       integer.formatted(IntegerFormatStyle.Currency(code: "EUR", locale: locale)))


        locale = Locale(identifier: "en-UK")
        XCTAssertEqual(integer.bpFormatted(.currency(code: "EUR").locale(locale)),
                       integer.formatted(.currency(code: "EUR").locale(locale)))

        XCTAssertEqual(integer.bpFormatted(BPIntegerFormatStyle.Currency(code: "EUR", locale: locale)),
                       integer.formatted(IntegerFormatStyle.Currency(code: "EUR", locale: locale)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testSignStrategy() {
        XCTAssertEqual((-1).bpFormatted(.currency(code: "EUR").sign(strategy: .automatic)),
                       (-1).formatted(.currency(code: "EUR").sign(strategy: .automatic)))

        XCTAssertEqual(0.bpFormatted(.currency(code: "EUR").sign(strategy: .automatic)),
                       0.formatted(.currency(code: "EUR").sign(strategy: .automatic)))

        XCTAssertEqual(1.bpFormatted(.currency(code: "EUR").sign(strategy: .automatic)),
                       1.formatted(.currency(code: "EUR").sign(strategy: .automatic)))


        XCTAssertEqual((-1).bpFormatted(.currency(code: "EUR").sign(strategy: .never)),
                       (-1).formatted(.currency(code: "EUR").sign(strategy: .never)))

        XCTAssertEqual(0.bpFormatted(.currency(code: "EUR").sign(strategy: .never)),
                       0.formatted(.currency(code: "EUR").sign(strategy: .never)))

        XCTAssertEqual(1.bpFormatted(.currency(code: "EUR").sign(strategy: .never)),
                       1.formatted(.currency(code: "EUR").sign(strategy: .never)))


        XCTAssertEqual((-1).bpFormatted(.currency(code: "EUR").sign(strategy: .always(showZero: true))),
                       (-1).formatted(.currency(code: "EUR").sign(strategy: .always(showZero: true))))

        XCTAssertEqual(0.bpFormatted(.currency(code: "EUR").sign(strategy: .always(showZero: true))),
                       0.formatted(.currency(code: "EUR").sign(strategy: .always(showZero: true))))

        XCTAssertEqual(1.bpFormatted(.currency(code: "EUR").sign(strategy: .always(showZero: true))),
                       1.formatted(.currency(code: "EUR").sign(strategy: .always(showZero: true))))


        XCTAssertEqual((-1).bpFormatted(.currency(code: "EUR").sign(strategy: .always(showZero: false))),
                       (-1).formatted(.currency(code: "EUR").sign(strategy: .always(showZero: false))))

        XCTAssertEqual(0.bpFormatted(.currency(code: "EUR").sign(strategy: .always(showZero: false))),
                       0.formatted(.currency(code: "EUR").sign(strategy: .always(showZero: false))))

        XCTAssertEqual(1.bpFormatted(.currency(code: "EUR").sign(strategy: .always(showZero: false))),
                       1.formatted(.currency(code: "EUR").sign(strategy: .always(showZero: false))))


        XCTAssertEqual((-1).bpFormatted(.currency(code: "EUR").sign(strategy: .accounting)),
                       (-1).formatted(.currency(code: "EUR").sign(strategy: .accounting)))

        XCTAssertEqual(0.bpFormatted(.currency(code: "EUR").sign(strategy: .accounting)),
                       0.formatted(.currency(code: "EUR").sign(strategy: .accounting)))

        XCTAssertEqual(1.bpFormatted(.currency(code: "EUR").sign(strategy: .accounting)),
                       1.formatted(.currency(code: "EUR").sign(strategy: .accounting)))


        XCTAssertEqual((-1).bpFormatted(.currency(code: "EUR").sign(strategy: .accountingAlways(showZero: true))),
                       (-1).formatted(.currency(code: "EUR").sign(strategy: .accountingAlways(showZero: true))))

        XCTAssertEqual(0.bpFormatted(.currency(code: "EUR").sign(strategy: .accountingAlways(showZero: true))),
                       0.formatted(.currency(code: "EUR").sign(strategy: .accountingAlways(showZero: true))))

        XCTAssertEqual(1.bpFormatted(.currency(code: "EUR").sign(strategy: .accountingAlways(showZero: true))),
                       1.formatted(.currency(code: "EUR").sign(strategy: .accountingAlways(showZero: true))))


        XCTAssertEqual((-1).bpFormatted(.currency(code: "EUR").sign(strategy: .accountingAlways(showZero: false))),
                       (-1).formatted(.currency(code: "EUR").sign(strategy: .accountingAlways(showZero: false))))

        XCTAssertEqual(0.bpFormatted(.currency(code: "EUR").sign(strategy: .accountingAlways(showZero: false))),
                       0.formatted(.currency(code: "EUR").sign(strategy: .accountingAlways(showZero: false))))

        XCTAssertEqual(1.bpFormatted(.currency(code: "EUR").sign(strategy: .accountingAlways(showZero: false))),
                       1.formatted(.currency(code: "EUR").sign(strategy: .accountingAlways(showZero: false))))



        let france = Locale(identifier: "fr-FR")

        XCTAssertEqual((-1).bpFormatted(.currency(code: "EUR").locale(france).sign(strategy: .automatic)),
                       (-1).formatted(.currency(code: "EUR").locale(france).sign(strategy: .automatic)))

        XCTAssertEqual(0.bpFormatted(.currency(code: "EUR").locale(france).sign(strategy: .automatic)),
                       0.formatted(.currency(code: "EUR").locale(france).sign(strategy: .automatic)))

        XCTAssertEqual(1.bpFormatted(.currency(code: "EUR").locale(france).sign(strategy: .automatic)),
                       1.formatted(.currency(code: "EUR").locale(france).sign(strategy: .automatic)))


        XCTAssertEqual((-1).bpFormatted(.currency(code: "EUR").locale(france).sign(strategy: .never)),
                       (-1).formatted(.currency(code: "EUR").locale(france).sign(strategy: .never)))

        XCTAssertEqual(0.bpFormatted(.currency(code: "EUR").locale(france).sign(strategy: .never)),
                       0.formatted(.currency(code: "EUR").locale(france).sign(strategy: .never)))

        XCTAssertEqual(1.bpFormatted(.currency(code: "EUR").locale(france).sign(strategy: .never)),
                       1.formatted(.currency(code: "EUR").locale(france).sign(strategy: .never)))


        XCTAssertEqual((-1).bpFormatted(.currency(code: "EUR").locale(france).sign(strategy: .always(showZero: true))),
                       (-1).formatted(.currency(code: "EUR").locale(france).sign(strategy: .always(showZero: true))))

        XCTAssertEqual(0.bpFormatted(.currency(code: "EUR").locale(france).sign(strategy: .always(showZero: true))),
                       0.formatted(.currency(code: "EUR").locale(france).sign(strategy: .always(showZero: true))))

        XCTAssertEqual(1.bpFormatted(.currency(code: "EUR").locale(france).sign(strategy: .always(showZero: true))),
                       1.formatted(.currency(code: "EUR").locale(france).sign(strategy: .always(showZero: true))))


        XCTAssertEqual((-1).bpFormatted(.currency(code: "EUR").locale(france).sign(strategy: .always(showZero: false))),
                       (-1).formatted(.currency(code: "EUR").locale(france).sign(strategy: .always(showZero: false))))

        XCTAssertEqual(0.bpFormatted(.currency(code: "EUR").locale(france).sign(strategy: .always(showZero: false))),
                       0.formatted(.currency(code: "EUR").locale(france).sign(strategy: .always(showZero: false))))

        XCTAssertEqual(1.bpFormatted(.currency(code: "EUR").locale(france).sign(strategy: .always(showZero: false))),
                       1.formatted(.currency(code: "EUR").locale(france).sign(strategy: .always(showZero: false))))


        XCTAssertEqual((-1).bpFormatted(.currency(code: "EUR").locale(france).sign(strategy: .accounting)),
                       (-1).formatted(.currency(code: "EUR").locale(france).sign(strategy: .accounting)))

        XCTAssertEqual(0.bpFormatted(.currency(code: "EUR").locale(france).sign(strategy: .accounting)),
                       0.formatted(.currency(code: "EUR").locale(france).sign(strategy: .accounting)))

        XCTAssertEqual(1.bpFormatted(.currency(code: "EUR").locale(france).sign(strategy: .accounting)),
                       1.formatted(.currency(code: "EUR").locale(france).sign(strategy: .accounting)))


        XCTAssertEqual((-1).bpFormatted(.currency(code: "EUR").locale(france).sign(strategy: .accountingAlways(showZero: true))),
                       (-1).formatted(.currency(code: "EUR").locale(france).sign(strategy: .accountingAlways(showZero: true))))

        XCTAssertEqual(0.bpFormatted(.currency(code: "EUR").locale(france).sign(strategy: .accountingAlways(showZero: true))),
                       0.formatted(.currency(code: "EUR").locale(france).sign(strategy: .accountingAlways(showZero: true))))

        XCTAssertEqual(1.bpFormatted(.currency(code: "EUR").locale(france).sign(strategy: .accountingAlways(showZero: true))),
                       1.formatted(.currency(code: "EUR").locale(france).sign(strategy: .accountingAlways(showZero: true))))


        XCTAssertEqual((-1).bpFormatted(.currency(code: "EUR").locale(france).sign(strategy: .accountingAlways(showZero: false))),
                       (-1).formatted(.currency(code: "EUR").locale(france).sign(strategy: .accountingAlways(showZero: false))))

        XCTAssertEqual(0.bpFormatted(.currency(code: "EUR").locale(france).sign(strategy: .accountingAlways(showZero: false))),
                       0.formatted(.currency(code: "EUR").locale(france).sign(strategy: .accountingAlways(showZero: false))))

        XCTAssertEqual(1.bpFormatted(.currency(code: "EUR").locale(france).sign(strategy: .accountingAlways(showZero: false))),
                       1.formatted(.currency(code: "EUR").locale(france).sign(strategy: .accountingAlways(showZero: false))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testGrouping() {
        let integer = 123_456

        XCTAssertEqual(integer.bpFormatted(.currency(code: "EUR").grouping(.never)),
                       integer.formatted(.currency(code: "EUR").grouping(.never)))

        XCTAssertEqual(integer.bpFormatted(.currency(code: "EUR").grouping(.automatic)),
                       integer.formatted(.currency(code: "EUR").grouping(.automatic)))

        let usa = Locale(identifier: "en-US")
        XCTAssertEqual(integer.bpFormatted(.currency(code: "EUR").locale(usa).grouping(.never)),
                       integer.formatted(.currency(code: "EUR").locale(usa).grouping(.never)))

        XCTAssertEqual(integer.bpFormatted(.currency(code: "EUR").locale(usa).grouping(.automatic)),
                       integer.formatted(.currency(code: "EUR").locale(usa).grouping(.automatic)))

        let france = Locale(identifier: "fr-FR")
        XCTAssertEqual(integer.bpFormatted(.currency(code: "EUR").locale(france).grouping(.never)),
                       integer.formatted(.currency(code: "EUR").locale(france).grouping(.never)))

        XCTAssertEqual(integer.bpFormatted(.currency(code: "EUR").locale(france).grouping(.automatic)),
                       integer.formatted(.currency(code: "EUR").locale(france).grouping(.automatic)))
    }
}

#endif
