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
}
