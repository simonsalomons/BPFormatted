//
//  BPFormattedTests.swift
//
//
//  Created by Simon Salomons on 13/06/2021.
//

import XCTest
@testable import BPFormatted

final class BPFormattedTests: XCTestCase {

    let date = Date(timeIntervalSince1970: 1_623_225_158.123_456)

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testGeneral() {

        XCTAssertEqual(date.bpFormatted(),
                       date.formatted())


        XCTAssertEqual(date.bpFormatted(.dateTime),
                       date.formatted(.dateTime))


        XCTAssertEqual(date.bpFormatted(date: .numeric, time: .omitted),
                       date.formatted(date: .numeric, time: .omitted))

        XCTAssertEqual(date.bpFormatted(date: .abbreviated, time: .omitted),
                       date.formatted(date: .abbreviated, time: .omitted))

        XCTAssertEqual(date.bpFormatted(date: .complete, time: .omitted),
                       date.formatted(date: .complete, time: .omitted))

        XCTAssertEqual(date.bpFormatted(date: .long, time: .omitted),
                       date.formatted(date: .long, time: .omitted))


        XCTAssertEqual(date.bpFormatted(date: .omitted, time: .standard),
                       date.formatted(date: .omitted, time: .standard))

        XCTAssertEqual(date.bpFormatted(date: .omitted, time: .shortened),
                       date.formatted(date: .omitted, time: .shortened))

        XCTAssertEqual(date.bpFormatted(date: .omitted, time: .complete),
                       date.formatted(date: .omitted, time: .complete))


        XCTAssertEqual(date.bpFormatted(date: .omitted, time: .omitted),
                       date.formatted(date: .omitted, time: .omitted))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testEra() {
        XCTAssertEqual(date.bpFormatted(.dateTime.era()),
                       date.formatted(.dateTime.era()))

        XCTAssertEqual(date.bpFormatted(.dateTime.era(.abbreviated)),
                       date.formatted(.dateTime.era(.abbreviated)))

        XCTAssertEqual(date.bpFormatted(.dateTime.era(.wide)),
                       date.formatted(.dateTime.era(.wide)))

        XCTAssertEqual(date.bpFormatted(.dateTime.era(.narrow)),
                       date.formatted(.dateTime.era(.narrow)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testYear() {
        XCTAssertEqual(date.bpFormatted(.dateTime.year()),
                       date.formatted(.dateTime.year()))

        XCTAssertEqual(date.bpFormatted(.dateTime.year(.defaultDigits)),
                       date.formatted(.dateTime.year(.defaultDigits)))

        XCTAssertEqual(date.bpFormatted(.dateTime.year(.twoDigits)),
                       date.formatted(.dateTime.year(.twoDigits)))

        XCTAssertEqual(date.bpFormatted(.dateTime.year(.extended())),
                       date.formatted(.dateTime.year(.extended())))

        XCTAssertEqual(date.bpFormatted(.dateTime.year(.extended(minimumLength: 2))),
                       date.formatted(.dateTime.year(.extended(minimumLength: 2))))

        XCTAssertEqual(date.bpFormatted(.dateTime.year(.extended(minimumLength: 3))),
                       date.formatted(.dateTime.year(.extended(minimumLength: 3))))

        XCTAssertEqual(date.bpFormatted(.dateTime.year(.extended(minimumLength: 4))),
                       date.formatted(.dateTime.year(.extended(minimumLength: 4))))

        XCTAssertEqual(date.bpFormatted(.dateTime.year(.relatedGregorian())),
                       date.formatted(.dateTime.year(.relatedGregorian())))

        XCTAssertEqual(date.bpFormatted(.dateTime.year(.relatedGregorian(minimumLength: 2))),
                       date.formatted(.dateTime.year(.relatedGregorian(minimumLength: 2))))

        XCTAssertEqual(date.bpFormatted(.dateTime.year(.relatedGregorian(minimumLength: 3))),
                       date.formatted(.dateTime.year(.relatedGregorian(minimumLength: 3))))

        XCTAssertEqual(date.bpFormatted(.dateTime.year(.relatedGregorian(minimumLength: 4))),
                       date.formatted(.dateTime.year(.relatedGregorian(minimumLength: 4))))

        XCTAssertEqual(date.bpFormatted(.dateTime.year(.padded(1))),
                       date.formatted(.dateTime.year(.padded(1))))

        XCTAssertEqual(date.bpFormatted(.dateTime.year(.padded(2))),
                       date.formatted(.dateTime.year(.padded(2))))

        XCTAssertEqual(date.bpFormatted(.dateTime.year(.padded(3))),
                       date.formatted(.dateTime.year(.padded(3))))

        XCTAssertEqual(date.bpFormatted(.dateTime.year(.padded(4))),
                       date.formatted(.dateTime.year(.padded(4))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testQuarter() {
        XCTAssertEqual(date.bpFormatted(.dateTime.quarter()),
                       date.formatted(.dateTime.quarter()))

        XCTAssertEqual(date.bpFormatted(.dateTime.quarter(.abbreviated)),
                       date.formatted(.dateTime.quarter(.abbreviated)))

        XCTAssertEqual(date.bpFormatted(.dateTime.quarter(.wide)),
                       date.formatted(.dateTime.quarter(.wide)))

        XCTAssertEqual(date.bpFormatted(.dateTime.quarter(.twoDigits)),
                       date.formatted(.dateTime.quarter(.twoDigits)))

        #warning("🆘 Apple's api says '2nd Quarter' is the correct output for '.narrow'. This was reported in FB9165857")
        XCTAssertEqual(date.bpFormatted(.dateTime.quarter(.narrow)),
                       date.formatted(.dateTime.quarter(.narrow)))

        XCTAssertEqual(date.bpFormatted(.dateTime.quarter(.oneDigit)),
                       date.formatted(.dateTime.quarter(.oneDigit)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testMonth() {
        XCTAssertEqual(date.bpFormatted(.dateTime.month()),
                       date.formatted(.dateTime.month()))

        XCTAssertEqual(date.bpFormatted(.dateTime.month(.defaultDigits)),
                       date.formatted(.dateTime.month(.defaultDigits)))

        XCTAssertEqual(date.bpFormatted(.dateTime.month(.twoDigits)),
                       date.formatted(.dateTime.month(.twoDigits)))

        XCTAssertEqual(date.bpFormatted(.dateTime.month(.abbreviated)),
                       date.formatted(.dateTime.month(.abbreviated)))

        XCTAssertEqual(date.bpFormatted(.dateTime.month(.wide)),
                       date.formatted(.dateTime.month(.wide)))

        XCTAssertEqual(date.bpFormatted(.dateTime.month(.narrow)),
                       date.formatted(.dateTime.month(.narrow)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testWeek() {
        XCTAssertEqual(date.bpFormatted(.dateTime.week()),
                       date.formatted(.dateTime.week()))

        XCTAssertEqual(date.bpFormatted(.dateTime.week(.defaultDigits)),
                       date.formatted(.dateTime.week(.defaultDigits)))

        XCTAssertEqual(date.bpFormatted(.dateTime.week(.twoDigits)),
                       date.formatted(.dateTime.week(.twoDigits)))

        XCTAssertEqual(date.bpFormatted(.dateTime.week(.weekOfMonth)),
                       date.formatted(.dateTime.week(.weekOfMonth)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testDay() {
        XCTAssertEqual(date.bpFormatted(.dateTime.day()),
                       date.formatted(.dateTime.day()))

        XCTAssertEqual(date.bpFormatted(.dateTime.day(.defaultDigits)),
                       date.formatted(.dateTime.day(.defaultDigits)))

        XCTAssertEqual(date.bpFormatted(.dateTime.day(.twoDigits)),
                       date.formatted(.dateTime.day(.twoDigits)))

        XCTAssertEqual(date.bpFormatted(.dateTime.day(.ordinalOfDayInMonth)),
                       date.formatted(.dateTime.day(.ordinalOfDayInMonth)))

        XCTAssertEqual(date.bpFormatted(.dateTime.day(.julianModified())),
                       date.formatted(.dateTime.day(.julianModified())))

        XCTAssertEqual(date.bpFormatted(.dateTime.day(.julianModified(minimumLength: 2))),
                       date.formatted(.dateTime.day(.julianModified(minimumLength: 2))))

        XCTAssertEqual(date.bpFormatted(.dateTime.day(.julianModified(minimumLength: 3))),
                       date.formatted(.dateTime.day(.julianModified(minimumLength: 3))))

        XCTAssertEqual(date.bpFormatted(.dateTime.day(.julianModified(minimumLength: 4))),
                       date.formatted(.dateTime.day(.julianModified(minimumLength: 4))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testDayOfYear() {
        XCTAssertEqual(date.bpFormatted(.dateTime.dayOfYear()),
                       date.formatted(.dateTime.dayOfYear()))

        XCTAssertEqual(date.bpFormatted(.dateTime.dayOfYear(.defaultDigits)),
                       date.formatted(.dateTime.dayOfYear(.defaultDigits)))

        XCTAssertEqual(date.bpFormatted(.dateTime.dayOfYear(.twoDigits)),
                       date.formatted(.dateTime.dayOfYear(.twoDigits)))

        XCTAssertEqual(date.bpFormatted(.dateTime.dayOfYear(.threeDigits)),
                       date.formatted(.dateTime.dayOfYear(.threeDigits)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testWeekday() {
        XCTAssertEqual(date.bpFormatted(.dateTime.weekday()),
                       date.formatted(.dateTime.weekday()))

        XCTAssertEqual(date.bpFormatted(.dateTime.weekday(.abbreviated)),
                       date.formatted(.dateTime.weekday(.abbreviated)))

        XCTAssertEqual(date.bpFormatted(.dateTime.weekday(.wide)),
                       date.formatted(.dateTime.weekday(.wide)))

        XCTAssertEqual(date.bpFormatted(.dateTime.weekday(.narrow)),
                       date.formatted(.dateTime.weekday(.narrow)))

        XCTAssertEqual(date.bpFormatted(.dateTime.weekday(.short)),
                       date.formatted(.dateTime.weekday(.short)))

        XCTAssertEqual(date.bpFormatted(.dateTime.weekday(.oneDigit)),
                       date.formatted(.dateTime.weekday(.oneDigit)))

        XCTAssertEqual(date.bpFormatted(.dateTime.weekday(.twoDigits)),
                       date.formatted(.dateTime.weekday(.twoDigits)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testHour() {
        XCTAssertEqual(date.bpFormatted(.dateTime.hour()),
                       date.formatted(.dateTime.hour()))

        // Supplying .omitted in any amPM parameter throws a fatalError in Apple's API, so bpFormatted throws a fatalError as well 🤷‍♂️
        #warning("🆘 Check if Apple will keep a fatalError when supplying .omitted amPM parameter during the bèta period")

        XCTAssertEqual(date.bpFormatted(.dateTime.hour(.defaultDigits(amPM: .narrow))),
                       date.formatted(.dateTime.hour(.defaultDigits(amPM: .narrow))))

        XCTAssertEqual(date.bpFormatted(.dateTime.hour(.defaultDigits(amPM: .abbreviated))),
                       date.formatted(.dateTime.hour(.defaultDigits(amPM: .abbreviated))))

        XCTAssertEqual(date.bpFormatted(.dateTime.hour(.defaultDigits(amPM: .wide))),
                       date.formatted(.dateTime.hour(.defaultDigits(amPM: .wide))))


        XCTAssertEqual(date.bpFormatted(.dateTime.hour(.twoDigits(amPM: .narrow))),
                       date.formatted(.dateTime.hour(.twoDigits(amPM: .narrow))))

        XCTAssertEqual(date.bpFormatted(.dateTime.hour(.twoDigits(amPM: .abbreviated))),
                       date.formatted(.dateTime.hour(.twoDigits(amPM: .abbreviated))))

        XCTAssertEqual(date.bpFormatted(.dateTime.hour(.twoDigits(amPM: .wide))),
                       date.formatted(.dateTime.hour(.twoDigits(amPM: .wide))))


        XCTAssertEqual(date.bpFormatted(.dateTime.hour(.defaultDigitsNoAMPM)),
                       date.formatted(.dateTime.hour(.defaultDigitsNoAMPM)))


        XCTAssertEqual(date.bpFormatted(.dateTime.hour(.twoDigitsNoAMPM)),
                       date.formatted(.dateTime.hour(.twoDigitsNoAMPM)))


        XCTAssertEqual(date.bpFormatted(.dateTime.hour(.conversationalDefaultDigits(amPM: .narrow))),
                       date.formatted(.dateTime.hour(.conversationalDefaultDigits(amPM: .narrow))))

        XCTAssertEqual(date.bpFormatted(.dateTime.hour(.conversationalDefaultDigits(amPM: .abbreviated))),
                       date.formatted(.dateTime.hour(.conversationalDefaultDigits(amPM: .abbreviated))))

        XCTAssertEqual(date.bpFormatted(.dateTime.hour(.conversationalDefaultDigits(amPM: .wide))),
                       date.formatted(.dateTime.hour(.conversationalDefaultDigits(amPM: .wide))))


        XCTAssertEqual(date.bpFormatted(.dateTime.hour(.conversationalTwoDigits(amPM: .narrow))),
                       date.formatted(.dateTime.hour(.conversationalTwoDigits(amPM: .narrow))))

        XCTAssertEqual(date.bpFormatted(.dateTime.hour(.conversationalTwoDigits(amPM: .abbreviated))),
                       date.formatted(.dateTime.hour(.conversationalTwoDigits(amPM: .abbreviated))))

        XCTAssertEqual(date.bpFormatted(.dateTime.hour(.conversationalTwoDigits(amPM: .wide))),
                       date.formatted(.dateTime.hour(.conversationalTwoDigits(amPM: .wide))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testMinute() {
        XCTAssertEqual(date.bpFormatted(.dateTime.minute()),
                       date.formatted(.dateTime.minute()))

        XCTAssertEqual(date.bpFormatted(.dateTime.minute(.defaultDigits)),
                       date.formatted(.dateTime.minute(.defaultDigits)))

        XCTAssertEqual(date.bpFormatted(.dateTime.minute(.twoDigits)),
                       date.formatted(.dateTime.minute(.twoDigits)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testSecond() {
        XCTAssertEqual(date.bpFormatted(.dateTime.second()),
                       date.formatted(.dateTime.second()))

        XCTAssertEqual(date.bpFormatted(.dateTime.second(.defaultDigits)),
                       date.formatted(.dateTime.second(.defaultDigits)))

        XCTAssertEqual(date.bpFormatted(.dateTime.second(.twoDigits)),
                       date.formatted(.dateTime.second(.twoDigits)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testSecondFraction() {
        XCTAssertEqual(date.bpFormatted(.dateTime.secondFraction(.fractional(1))),
                       date.formatted(.dateTime.secondFraction(.fractional(1))))

        XCTAssertEqual(date.bpFormatted(.dateTime.secondFraction(.fractional(2))),
                       date.formatted(.dateTime.secondFraction(.fractional(2))))

        XCTAssertEqual(date.bpFormatted(.dateTime.secondFraction(.fractional(3))),
                       date.formatted(.dateTime.secondFraction(.fractional(3))))

        XCTAssertEqual(date.bpFormatted(.dateTime.secondFraction(.fractional(4))),
                       date.formatted(.dateTime.secondFraction(.fractional(4))))


        XCTAssertEqual(date.bpFormatted(.dateTime.secondFraction(.milliseconds(1))),
                       date.formatted(.dateTime.secondFraction(.milliseconds(1))))

        XCTAssertEqual(date.bpFormatted(.dateTime.secondFraction(.milliseconds(2))),
                       date.formatted(.dateTime.secondFraction(.milliseconds(2))))

        XCTAssertEqual(date.bpFormatted(.dateTime.secondFraction(.milliseconds(3))),
                       date.formatted(.dateTime.secondFraction(.milliseconds(3))))

        XCTAssertEqual(date.bpFormatted(.dateTime.secondFraction(.milliseconds(4))),
                       date.formatted(.dateTime.secondFraction(.milliseconds(4))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testTimeZone() {
        XCTAssertEqual(date.bpFormatted(.dateTime.timeZone()),
                       date.formatted(.dateTime.timeZone()))

        XCTAssertEqual(date.bpFormatted(.dateTime.timeZone(.exemplarLocation)),
                       date.formatted(.dateTime.timeZone(.exemplarLocation)))


        XCTAssertEqual(date.bpFormatted(.dateTime.timeZone(.genericLocation)),
                       date.formatted(.dateTime.timeZone(.genericLocation)))


        XCTAssertEqual(date.bpFormatted(.dateTime.timeZone(.specificName(.short))),
                       date.formatted(.dateTime.timeZone(.specificName(.short))))

        XCTAssertEqual(date.bpFormatted(.dateTime.timeZone(.specificName(.long))),
                       date.formatted(.dateTime.timeZone(.specificName(.long))))


        XCTAssertEqual(date.bpFormatted(.dateTime.timeZone(.genericName(.short))),
                       date.formatted(.dateTime.timeZone(.genericName(.short))))

        XCTAssertEqual(date.bpFormatted(.dateTime.timeZone(.genericName(.long))),
                       date.formatted(.dateTime.timeZone(.genericName(.long))))


        XCTAssertEqual(date.bpFormatted(.dateTime.timeZone(.iso8601(.short))),
                       date.formatted(.dateTime.timeZone(.iso8601(.short))))

        XCTAssertEqual(date.bpFormatted(.dateTime.timeZone(.iso8601(.long))),
                       date.formatted(.dateTime.timeZone(.iso8601(.long))))


#warning("🆘 Apple's api says '' is the correct output for '.localizedGMT(.short)'. This was reported in FB9165947")
        XCTAssertEqual(date.bpFormatted(.dateTime.timeZone(.localizedGMT(.short))),
                       date.formatted(.dateTime.timeZone(.localizedGMT(.short))))

        XCTAssertEqual(date.bpFormatted(.dateTime.timeZone(.localizedGMT(.long))),
                       date.formatted(.dateTime.timeZone(.localizedGMT(.long))))


        XCTAssertEqual(date.bpFormatted(.dateTime.timeZone(.identifier(.short))),
                       date.formatted(.dateTime.timeZone(.identifier(.short))))

        XCTAssertEqual(date.bpFormatted(.dateTime.timeZone(.identifier(.long))),
                       date.formatted(.dateTime.timeZone(.identifier(.long))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testTimeZoneInitializer() {
        var timeZone = TimeZone(abbreviation: "GMT")!
        XCTAssertEqual(date.bpFormatted(Date.BPFormatStyle(timeZone: timeZone)),
                       date.formatted(Date.FormatStyle(timeZone: timeZone)))

        timeZone = TimeZone(abbreviation: "BST")!
        XCTAssertEqual(date.bpFormatted(Date.BPFormatStyle(timeZone: timeZone)),
                       date.formatted(Date.FormatStyle(timeZone: timeZone)))

        timeZone = TimeZone(abbreviation: "ICT")!
        XCTAssertEqual(date.bpFormatted(Date.BPFormatStyle(timeZone: timeZone)),
                       date.formatted(Date.FormatStyle(timeZone: timeZone)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testLocale() {
        var locale = Locale(identifier: "be-NL")
        XCTAssertEqual(date.bpFormatted(.dateTime.locale(locale)),
                       date.formatted(.dateTime.locale(locale)))

        XCTAssertEqual(date.bpFormatted(Date.BPFormatStyle(locale: locale)),
                       date.formatted(Date.FormatStyle(locale: locale)))


        locale = Locale(identifier: "en-US")
        XCTAssertEqual(date.bpFormatted(.dateTime.locale(locale)),
                       date.formatted(.dateTime.locale(locale)))

        XCTAssertEqual(date.bpFormatted(Date.BPFormatStyle(locale: locale)),
                       date.formatted(Date.FormatStyle(locale: locale)))


        locale = Locale(identifier: "en-UK")
        XCTAssertEqual(date.bpFormatted(.dateTime.locale(locale)),
                       date.formatted(.dateTime.locale(locale)))

        XCTAssertEqual(date.bpFormatted(Date.BPFormatStyle(locale: locale)),
                       date.formatted(Date.FormatStyle(locale: locale)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testCalendar() {

        var calendar = Calendar(identifier: .gregorian)
        XCTAssertEqual(date.bpFormatted(Date.BPFormatStyle(calendar: calendar)),
                       date.formatted(Date.FormatStyle(calendar: calendar)))

        calendar = Calendar(identifier: .buddhist)
        XCTAssertEqual(date.bpFormatted(Date.BPFormatStyle(calendar: calendar)),
                       date.formatted(Date.FormatStyle(calendar: calendar)))

        calendar = Calendar(identifier: .chinese)
        XCTAssertEqual(date.bpFormatted(Date.BPFormatStyle(calendar: calendar)),
                       date.formatted(Date.FormatStyle(calendar: calendar)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testCapitalization() {
        XCTAssertEqual(date.bpFormatted(Date.BPFormatStyle(capitalizationContext: .unknown)),
                       date.formatted(Date.FormatStyle(capitalizationContext: .unknown)))

            XCTAssertEqual(date.bpFormatted(Date.BPFormatStyle(capitalizationContext: .standalone)),
                           date.formatted(Date.FormatStyle(capitalizationContext: .standalone)))

        XCTAssertEqual(date.bpFormatted(Date.BPFormatStyle(capitalizationContext: .listItem)),
                       date.formatted(Date.FormatStyle(capitalizationContext: .listItem)))

        XCTAssertEqual(date.bpFormatted(Date.BPFormatStyle(capitalizationContext: .beginningOfSentence)),
                       date.formatted(Date.FormatStyle(capitalizationContext: .beginningOfSentence)))

        XCTAssertEqual(date.bpFormatted(Date.BPFormatStyle(capitalizationContext: .middleOfSentence)),
                       date.formatted(Date.FormatStyle(capitalizationContext: .middleOfSentence)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testInteroperability() throws {
        try assertInteroperability(.dateTime,
                                   .dateTime)

        try assertInteroperability(.dateTime.day(.twoDigits).hour(.defaultDigitsNoAMPM),
                                   .dateTime.day(.twoDigits).hour(.defaultDigitsNoAMPM))

        try assertInteroperability(Date.BPFormatStyle(date: .numeric, time: .shortened),
                                   Date.FormatStyle(date: .numeric, time: .shortened))

        let locale = Locale(identifier: "en-US")
        let calendar = Calendar(identifier: .buddhist)
        let timeZone = TimeZone(abbreviation: "BST")!
        try assertInteroperability(Date.BPFormatStyle(date: .complete,
                                                      time: .complete,
                                                      locale: locale,
                                                      calendar: calendar,
                                                      timeZone: timeZone,
                                                      capitalizationContext: .beginningOfSentence),
                                   Date.FormatStyle(date: .complete,
                                                    time: .complete,
                                                    locale: locale,
                                                    calendar: calendar,
                                                    timeZone: timeZone,
                                                    capitalizationContext: .beginningOfSentence))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func assertInteroperability<T: FormatStyle>(_ bpFormat: Date.BPFormatStyle, _ format: T) throws {
        let bpEncoded = try JSONEncoder().encode(bpFormat)
        let appleEncoded = try JSONEncoder().encode(format)

        // Check if both json results have the same keys
        let bpSortedKeys = (try JSONSerialization.jsonObject(with: bpEncoded, options: []) as? [String: Any])?.keys.sorted() ?? []
        let appleSortedKeys = (try JSONSerialization.jsonObject(with: appleEncoded, options: []) as? [String: Any])?.keys.sorted() ?? []
        XCTAssertEqual(bpSortedKeys, appleSortedKeys)

        // Check if Apple can decode an encoded BPFormatStyle and compare the formatted result
        let appleDecoded = try JSONDecoder().decode(Date.FormatStyle.self, from: bpEncoded)
        XCTAssertEqual(date.bpFormatted(bpFormat),
                       date.formatted(appleDecoded))
    }

    // Since we're using a single DateFormatter behind the scenes and multiple threads can call into this formatting api, we need to make sure there are no concurrency issues (without using async await)
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
                XCTAssertEqual(self.date.bpFormatted(.dateTime.year().day().month()),
                               self.date.bpFormatted(.dateTime.year().day().month()))
                datesExpectation.fulfill()
            }
        }
        timesQueue.async {
            for _ in 0..<repetitions {
                XCTAssertEqual(self.date.bpFormatted(.dateTime.minute().second().hour()),
                               self.date.bpFormatted(.dateTime.minute().second().hour()))
                timesExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 30, handler: nil)
    }
}
