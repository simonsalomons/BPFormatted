//
//  DateRelativeTests.swift
//  
//
//  Created by Simon Salomons on 19/06/2021.
//

import XCTest
@testable import BPFormatted

final class DateRelativeTests: XCTestCase {

    let date = Date(timeIntervalSince1970: 1_623_225_158.123_456)

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testGeneral() {

        XCTAssertEqual(date.bpFormatted(.relative(presentation: .numeric)),
                       date.formatted(.relative(presentation: .numeric)))

        XCTAssertEqual(date.bpFormatted(.relative(presentation: .named)),
                       date.formatted(.relative(presentation: .named)))


        XCTAssertEqual(date.bpFormatted(Date.BPRelativeFormatStyle(presentation: .numeric)),
                       date.formatted(Date.RelativeFormatStyle(presentation: .numeric)))

        XCTAssertEqual(date.bpFormatted(Date.BPRelativeFormatStyle(presentation: .named)),
                       date.formatted(Date.RelativeFormatStyle(presentation: .named)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testUnitStyle() {

        XCTAssertEqual(date.bpFormatted(.relative(presentation: .numeric, unitsStyle: .abbreviated)),
                       date.formatted(.relative(presentation: .numeric, unitsStyle: .abbreviated)))

        XCTAssertEqual(date.bpFormatted(.relative(presentation: .named, unitsStyle: .abbreviated)),
                       date.formatted(.relative(presentation: .named, unitsStyle: .abbreviated)))


        XCTAssertEqual(date.bpFormatted(.relative(presentation: .numeric, unitsStyle: .narrow)),
                       date.formatted(.relative(presentation: .numeric, unitsStyle: .narrow)))

        XCTAssertEqual(date.bpFormatted(.relative(presentation: .named, unitsStyle: .narrow)),
                       date.formatted(.relative(presentation: .named, unitsStyle: .narrow)))


        XCTAssertEqual(date.bpFormatted(.relative(presentation: .numeric, unitsStyle: .spellOut)),
                       date.formatted(.relative(presentation: .numeric, unitsStyle: .spellOut)))

        XCTAssertEqual(date.bpFormatted(.relative(presentation: .named, unitsStyle: .spellOut)),
                       date.formatted(.relative(presentation: .named, unitsStyle: .spellOut)))


        XCTAssertEqual(date.bpFormatted(.relative(presentation: .numeric, unitsStyle: .wide)),
                       date.formatted(.relative(presentation: .numeric, unitsStyle: .wide)))

        XCTAssertEqual(date.bpFormatted(.relative(presentation: .named, unitsStyle: .wide)),
                       date.formatted(.relative(presentation: .named, unitsStyle: .wide)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testLocale() {
        var locale = Locale(identifier: "be-NL")
        XCTAssertEqual(date.bpFormatted(.relative(presentation: .named).locale(locale)),
                       date.formatted(.relative(presentation: .named).locale(locale)))

        XCTAssertEqual(date.bpFormatted(Date.BPRelativeFormatStyle(locale: locale)),
                       date.formatted(Date.RelativeFormatStyle(locale: locale)))


        locale = Locale(identifier: "en-US")
        XCTAssertEqual(date.bpFormatted(.relative(presentation: .named).locale(locale)),
                       date.formatted(.relative(presentation: .named).locale(locale)))

        XCTAssertEqual(date.bpFormatted(Date.BPRelativeFormatStyle(locale: locale)),
                       date.formatted(Date.RelativeFormatStyle(locale: locale)))


        locale = Locale(identifier: "en-UK")
        XCTAssertEqual(date.bpFormatted(.relative(presentation: .named).locale(locale)),
                       date.formatted(.relative(presentation: .named).locale(locale)))

        XCTAssertEqual(date.bpFormatted(Date.BPRelativeFormatStyle(locale: locale)),
                       date.formatted(Date.RelativeFormatStyle(locale: locale)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testCalendar() {

        var calendar = Calendar(identifier: .gregorian)
        XCTAssertEqual(date.bpFormatted(Date.BPRelativeFormatStyle(calendar: calendar)),
                       date.formatted(Date.RelativeFormatStyle(calendar: calendar)))

        calendar = Calendar(identifier: .buddhist)
        XCTAssertEqual(date.bpFormatted(Date.BPRelativeFormatStyle(calendar: calendar)),
                       date.formatted(Date.RelativeFormatStyle(calendar: calendar)))

        calendar = Calendar(identifier: .chinese)
        XCTAssertEqual(date.bpFormatted(Date.BPRelativeFormatStyle(calendar: calendar)),
                       date.formatted(Date.RelativeFormatStyle(calendar: calendar)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testCapitalization() {
        let date = Date(timeIntervalSinceNow: 10 * 60)

        XCTAssertEqual(date.bpFormatted(Date.BPRelativeFormatStyle(capitalizationContext: .unknown)),
                       date.formatted(Date.RelativeFormatStyle(capitalizationContext: .unknown)))

        XCTAssertEqual(date.bpFormatted(Date.BPRelativeFormatStyle(capitalizationContext: .standalone)),
                       date.formatted(Date.RelativeFormatStyle(capitalizationContext: .standalone)))

        XCTAssertEqual(date.bpFormatted(Date.BPRelativeFormatStyle(capitalizationContext: .listItem)),
                       date.formatted(Date.RelativeFormatStyle(capitalizationContext: .listItem)))

        XCTAssertEqual(date.bpFormatted(Date.BPRelativeFormatStyle(capitalizationContext: .beginningOfSentence)),
                       date.formatted(Date.RelativeFormatStyle(capitalizationContext: .beginningOfSentence)))

        XCTAssertEqual(date.bpFormatted(Date.BPRelativeFormatStyle(capitalizationContext: .middleOfSentence)),
                       date.formatted(Date.RelativeFormatStyle(capitalizationContext: .middleOfSentence)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testInteroperability() throws {
        try assertInteroperability(.relative(presentation: .named),
                                   .relative(presentation: .named))

        try assertInteroperability(.relative(presentation: .named, unitsStyle: .abbreviated),
                                   .relative(presentation: .named, unitsStyle: .abbreviated))

        try assertInteroperability(Date.BPRelativeFormatStyle(presentation: .named, unitsStyle: .spellOut),
                                   Date.RelativeFormatStyle(presentation: .named, unitsStyle: .spellOut))

        let locale = Locale(identifier: "en-US")
        let calendar = Calendar(identifier: .buddhist)
        try assertInteroperability(Date.BPRelativeFormatStyle(presentation: .numeric,
                                                              unitsStyle: .wide,
                                                              locale: locale,
                                                              calendar: calendar,
                                                              capitalizationContext: .beginningOfSentence),
                                   Date.RelativeFormatStyle(presentation: .numeric,
                                                            unitsStyle: .wide,
                                                            locale: locale,
                                                            calendar: calendar,
                                                            capitalizationContext: .beginningOfSentence))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func assertInteroperability<T: FormatStyle>(_ bpFormat: Date.BPRelativeFormatStyle, _ format: T) throws {
        let bpEncoded = try JSONEncoder().encode(bpFormat)
        XCTAssertNoThrow(try JSONDecoder().decode(Date.BPRelativeFormatStyle.self, from: bpEncoded))
        let appleEncoded = try JSONEncoder().encode(format)

        // Check if both json results have the same keys
        let bpSortedKeys = (try JSONSerialization.jsonObject(with: bpEncoded, options: []) as? [String: Any])?.keys.sorted() ?? []
        let appleSortedKeys = (try JSONSerialization.jsonObject(with: appleEncoded, options: []) as? [String: Any])?.keys.sorted() ?? []
        XCTAssertEqual(bpSortedKeys, appleSortedKeys)

        // Check if Apple can decode an encoded BPFormatStyle and compare the formatted result
        let appleDecoded = try JSONDecoder().decode(Date.RelativeFormatStyle.self, from: bpEncoded)
        XCTAssertEqual(date.bpFormatted(bpFormat),
                       date.formatted(appleDecoded))
    }

    // Since we're using a single DateFormatter behind the scenes and multiple threads can call into this formatting api, we need to make sure there are no concurrency issues (without using async await)
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testConcurrency() {
        let repetitions = 1_000
        let numericExpectation = expectation(description: "Complete numeric tests")
        numericExpectation.expectedFulfillmentCount = repetitions
        let namedExpectation = expectation(description: "Complete named tests")
        namedExpectation.expectedFulfillmentCount = repetitions

        let numericQueue = DispatchQueue(label: "Numeric")
        let namedQueue = DispatchQueue(label: "Named")

        numericQueue.async {
            for _ in 0..<repetitions {
                XCTAssertEqual(self.date.bpFormatted(.relative(presentation: .numeric)),
                               self.date.bpFormatted(.relative(presentation: .numeric)))
                numericExpectation.fulfill()
            }
        }
        namedQueue.async {
            for _ in 0..<repetitions {
                XCTAssertEqual(self.date.bpFormatted(Date.BPRelativeFormatStyle(presentation: .named, unitsStyle: .spellOut)),
                               self.date.bpFormatted(Date.BPRelativeFormatStyle(presentation: .named, unitsStyle: .spellOut)))
                namedExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 30, handler: nil)
    }
}
