//
//  DateISO8601Tests.swift
//  
//
//  Created by Simon Salomons on 14/06/2021.
//

import XCTest
@testable import BPFormatted

final class DateISO8601Tests: XCTestCase {

    let date = Date(timeIntervalSince1970: 1_623_225_158.123_456)

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testGeneral() {
        XCTAssertEqual(date.bpFormatted(.iso8601),
                       date.formatted(.iso8601))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testLocale() {
        var locale = Locale(identifier: "be-NL")
        XCTAssertEqual(date.bpFormatted(.iso8601.locale(locale)),
                       date.formatted(.iso8601.locale(locale)))


        locale = Locale(identifier: "en-US")
        XCTAssertEqual(date.bpFormatted(.iso8601.locale(locale)),
                       date.formatted(.iso8601.locale(locale)))


        locale = Locale(identifier: "en-UK")
        XCTAssertEqual(date.bpFormatted(.iso8601.locale(locale)),
                       date.formatted(.iso8601.locale(locale)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testYear() {
        XCTAssertEqual(date.bpFormatted(.iso8601.year()),
                       date.formatted(.iso8601.year()))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testWeekOfYear() {
        XCTAssertEqual(date.bpFormatted(.iso8601.weekOfYear()),
                       date.formatted(.iso8601.weekOfYear()))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testMonth() {
        XCTAssertEqual(date.bpFormatted(.iso8601.month()),
                       date.formatted(.iso8601.month()))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testDay() {
        XCTAssertEqual(date.bpFormatted(.iso8601.day()),
                       date.formatted(.iso8601.day()))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testTime() {
        XCTAssertEqual(date.bpFormatted(.iso8601.time(includingFractionalSeconds: true)),
                       date.formatted(.iso8601.time(includingFractionalSeconds: true)))

        XCTAssertEqual(date.bpFormatted(.iso8601.time(includingFractionalSeconds: false)),
                       date.formatted(.iso8601.time(includingFractionalSeconds: false)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testTimeZone() {
        XCTAssertEqual(date.bpFormatted(.iso8601.timeZone(separator: .omitted)),
                       date.formatted(.iso8601.timeZone(separator: .omitted)))

        XCTAssertEqual(date.bpFormatted(.iso8601.timeZone(separator: .colon)),
                       date.formatted(.iso8601.timeZone(separator: .colon)))


        XCTAssertEqual(date.bpFormatted(.iso8601.timeZoneSeparator(.omitted)),
                       date.formatted(.iso8601.timeZoneSeparator(.omitted)))

        XCTAssertEqual(date.bpFormatted(.iso8601.timeZoneSeparator(.colon)),
                       date.formatted(.iso8601.timeZoneSeparator(.colon)))
    }


    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testDateSeparator() {
        XCTAssertEqual(date.bpFormatted(.iso8601.dateSeparator(.omitted)),
                       date.formatted(.iso8601.dateSeparator(.omitted)))

        XCTAssertEqual(date.bpFormatted(.iso8601.dateSeparator(.dash)),
                       date.formatted(.iso8601.dateSeparator(.dash)))
    }


    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testDateTimeSeparator() {
        XCTAssertEqual(date.bpFormatted(.iso8601.dateTimeSeparator(.standard)),
                       date.formatted(.iso8601.dateTimeSeparator(.standard)))

        XCTAssertEqual(date.bpFormatted(.iso8601.dateTimeSeparator(.space)),
                       date.formatted(.iso8601.dateTimeSeparator(.space)))
    }


    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testTimeSeparator() {
        XCTAssertEqual(date.bpFormatted(.iso8601.timeSeparator(.omitted)),
                       date.formatted(.iso8601.timeSeparator(.omitted)))

        XCTAssertEqual(date.bpFormatted(.iso8601.timeSeparator(.colon)),
                       date.formatted(.iso8601.timeSeparator(.colon)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testInteroperability() throws {
        try assertInteroperability(.iso8601,
                                   .iso8601)

        try assertInteroperability(.iso8601.day().year().month(),
                                   .iso8601.day().year().month())

        let timeZone = TimeZone(abbreviation: "BST")!
        try assertInteroperability(Date.BPISO8601FormatStyle(dateSeparator: .dash, dateTimeSeparator: .space, timeZone: timeZone),
                                   Date.ISO8601FormatStyle(dateSeparator: .dash, dateTimeSeparator: .space, timeZone: timeZone))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func assertInteroperability<U: FormatStyle>(_ bpFormat: Date.BPISO8601FormatStyle, _ format: U) throws {
        let bpEncoded = try JSONEncoder().encode(bpFormat)
        XCTAssertNoThrow(try JSONDecoder().decode(Date.BPISO8601FormatStyle.self, from: bpEncoded))
        let appleEncoded = try JSONEncoder().encode(format)

        // Check if both json results have the same keys
        let bpSortedKeys = (try JSONSerialization.jsonObject(with: bpEncoded, options: []) as? [String: Any])?.keys.sorted() ?? []
        let appleSortedKeys = (try JSONSerialization.jsonObject(with: appleEncoded, options: []) as? [String: Any])?.keys.sorted() ?? []
        XCTAssertEqual(bpSortedKeys, appleSortedKeys)

        // Check if Apple can decode an encoded BPFormatStyle and compare the formatted result
        let appleDecoded = try JSONDecoder().decode(Date.ISO8601FormatStyle.self, from: bpEncoded)
        XCTAssertEqual(date.bpFormatted(bpFormat),
                       date.formatted(appleDecoded))
    }

    // Since we're using a single ISO8601DateFormatter behind the scenes and multiple threads can call into this formatting api, we need to make sure there are no concurrency issues (without using async await)
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testConcurrency() {
        let repetitions = 1_000
        let datesExpectation = expectation(description: "Complete date tests")
        datesExpectation.expectedFulfillmentCount = repetitions
        let timesExpectation = expectation(description: "Complete time tests")
        timesExpectation.expectedFulfillmentCount = repetitions

        let datesQueue = DispatchQueue(label: "Dates")
        let timesQueue = DispatchQueue(label: "Times")

        datesQueue.async {
            for _ in 0..<repetitions {
                XCTAssertEqual(self.date.bpFormatted(.iso8601.year().day().month()),
                               self.date.bpFormatted(.iso8601.year().day().month()))
                datesExpectation.fulfill()
            }
        }
        timesQueue.async {
            for _ in 0..<repetitions {
                XCTAssertEqual(self.date.bpFormatted(.iso8601.timeZone(separator: .colon).dateSeparator(.dash)),
                               self.date.bpFormatted(.iso8601.timeZone(separator: .colon).dateSeparator(.dash)))
                timesExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 30, handler: nil)
    }
}
