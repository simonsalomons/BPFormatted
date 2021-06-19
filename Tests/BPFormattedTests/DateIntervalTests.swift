//
//  DateIntervalTests.swift
//  
//
//  Created by Simon Salomons on 19/06/2021.
//


import XCTest
@testable import BPFormatted

final class DateIntervalTests: XCTestCase {

    let date1 = Date(timeIntervalSince1970: 1_580_025_657.654_321)
    let date2 = Date(timeIntervalSince1970: 1_623_225_158.123_456)
    var dateRange: Range<Date> { (date1..<date2) }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testGeneral() {
        XCTAssertEqual(dateRange.bpFormatted(),
                       dateRange.formatted())


        XCTAssertEqual(dateRange.bpFormatted(.interval),
                       dateRange.formatted(.interval))


        XCTAssertEqual(dateRange.bpFormatted(date: .numeric, time: .omitted),
                       dateRange.formatted(date: .numeric, time: .omitted))

        XCTAssertEqual(dateRange.bpFormatted(date: .abbreviated, time: .omitted),
                       dateRange.formatted(date: .abbreviated, time: .omitted))

        XCTAssertEqual(dateRange.bpFormatted(date: .complete, time: .omitted),
                       dateRange.formatted(date: .complete, time: .omitted))

        XCTAssertEqual(dateRange.bpFormatted(date: .long, time: .omitted),
                       dateRange.formatted(date: .long, time: .omitted))


        XCTAssertEqual(dateRange.bpFormatted(date: .omitted, time: .standard),
                       dateRange.formatted(date: .omitted, time: .standard))

        XCTAssertEqual(dateRange.bpFormatted(date: .omitted, time: .shortened),
                       dateRange.formatted(date: .omitted, time: .shortened))

        XCTAssertEqual(dateRange.bpFormatted(date: .omitted, time: .complete),
                       dateRange.formatted(date: .omitted, time: .complete))


        XCTAssertEqual(dateRange.bpFormatted(date: .omitted, time: .omitted),
                       dateRange.formatted(date: .omitted, time: .omitted))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testYear() {
        XCTAssertEqual(dateRange.bpFormatted(.interval.year()),
                       dateRange.formatted(.interval.year()))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testMonth() {
        XCTAssertEqual(dateRange.bpFormatted(.interval.month()),
                       dateRange.formatted(.interval.month()))

        XCTAssertEqual(dateRange.bpFormatted(.interval.month(.defaultDigits)),
                       dateRange.formatted(.interval.month(.defaultDigits)))

        XCTAssertEqual(dateRange.bpFormatted(.interval.month(.twoDigits)),
                       dateRange.formatted(.interval.month(.twoDigits)))

        XCTAssertEqual(dateRange.bpFormatted(.interval.month(.abbreviated)),
                       dateRange.formatted(.interval.month(.abbreviated)))

        XCTAssertEqual(dateRange.bpFormatted(.interval.month(.wide)),
                       dateRange.formatted(.interval.month(.wide)))

        XCTAssertEqual(dateRange.bpFormatted(.interval.month(.narrow)),
                       dateRange.formatted(.interval.month(.narrow)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testDay() {
        XCTAssertEqual(dateRange.bpFormatted(.interval.day()),
                       dateRange.formatted(.interval.day()))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testWeekday() {
        XCTAssertEqual(dateRange.bpFormatted(.interval.weekday()),
                       dateRange.formatted(.interval.weekday()))

        XCTAssertEqual(dateRange.bpFormatted(.interval.weekday(.abbreviated)),
                       dateRange.formatted(.interval.weekday(.abbreviated)))

        XCTAssertEqual(dateRange.bpFormatted(.interval.weekday(.wide)),
                       dateRange.formatted(.interval.weekday(.wide)))

        XCTAssertEqual(dateRange.bpFormatted(.interval.weekday(.narrow)),
                       dateRange.formatted(.interval.weekday(.narrow)))

        XCTAssertEqual(dateRange.bpFormatted(.interval.weekday(.short)),
                       dateRange.formatted(.interval.weekday(.short)))

        XCTAssertEqual(dateRange.bpFormatted(.interval.weekday(.oneDigit)),
                       dateRange.formatted(.interval.weekday(.oneDigit)))

        XCTAssertEqual(dateRange.bpFormatted(.interval.weekday(.twoDigits)),
                       dateRange.formatted(.interval.weekday(.twoDigits)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testHour() {
        XCTAssertEqual(dateRange.bpFormatted(.interval.hour()),
                       dateRange.formatted(.interval.hour()))

        // Supplying .omitted in any amPM parameter throws a fatalError in Apple's API, so bpFormatted throws a fatalError as well 🤷‍♂️
        #warning("🆘 Check if Apple will keep a fatalError when supplying .omitted amPM parameter during the bèta period")

        XCTAssertEqual(dateRange.bpFormatted(.interval.hour(.defaultDigits(amPM: .narrow))),
                       dateRange.formatted(.interval.hour(.defaultDigits(amPM: .narrow))))

        XCTAssertEqual(dateRange.bpFormatted(.interval.hour(.defaultDigits(amPM: .abbreviated))),
                       dateRange.formatted(.interval.hour(.defaultDigits(amPM: .abbreviated))))

        XCTAssertEqual(dateRange.bpFormatted(.interval.hour(.defaultDigits(amPM: .wide))),
                       dateRange.formatted(.interval.hour(.defaultDigits(amPM: .wide))))


        XCTAssertEqual(dateRange.bpFormatted(.interval.hour(.twoDigits(amPM: .narrow))),
                       dateRange.formatted(.interval.hour(.twoDigits(amPM: .narrow))))

        XCTAssertEqual(dateRange.bpFormatted(.interval.hour(.twoDigits(amPM: .abbreviated))),
                       dateRange.formatted(.interval.hour(.twoDigits(amPM: .abbreviated))))

        XCTAssertEqual(dateRange.bpFormatted(.interval.hour(.twoDigits(amPM: .wide))),
                       dateRange.formatted(.interval.hour(.twoDigits(amPM: .wide))))


        XCTAssertEqual(dateRange.bpFormatted(.interval.hour(.defaultDigitsNoAMPM)),
                       dateRange.formatted(.interval.hour(.defaultDigitsNoAMPM)))


        XCTAssertEqual(dateRange.bpFormatted(.interval.hour(.twoDigitsNoAMPM)),
                       dateRange.formatted(.interval.hour(.twoDigitsNoAMPM)))


        XCTAssertEqual(dateRange.bpFormatted(.interval.hour(.conversationalDefaultDigits(amPM: .narrow))),
                       dateRange.formatted(.interval.hour(.conversationalDefaultDigits(amPM: .narrow))))

        XCTAssertEqual(dateRange.bpFormatted(.interval.hour(.conversationalDefaultDigits(amPM: .abbreviated))),
                       dateRange.formatted(.interval.hour(.conversationalDefaultDigits(amPM: .abbreviated))))

        XCTAssertEqual(dateRange.bpFormatted(.interval.hour(.conversationalDefaultDigits(amPM: .wide))),
                       dateRange.formatted(.interval.hour(.conversationalDefaultDigits(amPM: .wide))))


        XCTAssertEqual(dateRange.bpFormatted(.interval.hour(.conversationalTwoDigits(amPM: .narrow))),
                       dateRange.formatted(.interval.hour(.conversationalTwoDigits(amPM: .narrow))))

        XCTAssertEqual(dateRange.bpFormatted(.interval.hour(.conversationalTwoDigits(amPM: .abbreviated))),
                       dateRange.formatted(.interval.hour(.conversationalTwoDigits(amPM: .abbreviated))))

        XCTAssertEqual(dateRange.bpFormatted(.interval.hour(.conversationalTwoDigits(amPM: .wide))),
                       dateRange.formatted(.interval.hour(.conversationalTwoDigits(amPM: .wide))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testMinute() {
        XCTAssertEqual(dateRange.bpFormatted(.interval.minute()),
                       dateRange.formatted(.interval.minute()))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testSecond() {
        XCTAssertEqual(dateRange.bpFormatted(.interval.second()),
                       dateRange.formatted(.interval.second()))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testTimeZone() {
        XCTAssertEqual(dateRange.bpFormatted(.interval.timeZone()),
                       dateRange.formatted(.interval.timeZone()))

        XCTAssertEqual(dateRange.bpFormatted(.interval.timeZone(.exemplarLocation)),
                       dateRange.formatted(.interval.timeZone(.exemplarLocation)))


        XCTAssertEqual(dateRange.bpFormatted(.interval.timeZone(.genericLocation)),
                       dateRange.formatted(.interval.timeZone(.genericLocation)))


        XCTAssertEqual(dateRange.bpFormatted(.interval.timeZone(.specificName(.short))),
                       dateRange.formatted(.interval.timeZone(.specificName(.short))))

        XCTAssertEqual(dateRange.bpFormatted(.interval.timeZone(.specificName(.long))),
                       dateRange.formatted(.interval.timeZone(.specificName(.long))))


        XCTAssertEqual(dateRange.bpFormatted(.interval.timeZone(.genericName(.short))),
                       dateRange.formatted(.interval.timeZone(.genericName(.short))))

        XCTAssertEqual(dateRange.bpFormatted(.interval.timeZone(.genericName(.long))),
                       dateRange.formatted(.interval.timeZone(.genericName(.long))))


        XCTAssertEqual(dateRange.bpFormatted(.interval.timeZone(.iso8601(.short))),
                       dateRange.formatted(.interval.timeZone(.iso8601(.short))))

        XCTAssertEqual(dateRange.bpFormatted(.interval.timeZone(.iso8601(.long))),
                       dateRange.formatted(.interval.timeZone(.iso8601(.long))))


#warning("🆘 Apple's api says '' is the correct output for '.localizedGMT(.short)'. This was reported in FB9165947")
#warning("🆘 For some reason, all timeZones except localizedGMT also format a day, month and year. This localizedGMT seems the only one correctly giving only TimeZone. Let's wait and see what the beta's do.")
        XCTAssertEqual(dateRange.bpFormatted(.interval.timeZone(.localizedGMT(.short))),
                       dateRange.formatted(.interval.timeZone(.localizedGMT(.short))))

        XCTAssertEqual(dateRange.bpFormatted(.interval.timeZone(.localizedGMT(.long))),
                       dateRange.formatted(.interval.timeZone(.localizedGMT(.long))))


        XCTAssertEqual(dateRange.bpFormatted(.interval.timeZone(.identifier(.short))),
                       dateRange.formatted(.interval.timeZone(.identifier(.short))))

        XCTAssertEqual(dateRange.bpFormatted(.interval.timeZone(.identifier(.long))),
                       dateRange.formatted(.interval.timeZone(.identifier(.long))))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testTimeZoneInitializer() {
        var timeZone = TimeZone(abbreviation: "GMT")!
        XCTAssertEqual(dateRange.bpFormatted(Date.BPIntervalFormatStyle(timeZone: timeZone)),
                       dateRange.formatted(Date.IntervalFormatStyle(timeZone: timeZone)))

        timeZone = TimeZone(abbreviation: "BST")!
        XCTAssertEqual(dateRange.bpFormatted(Date.BPIntervalFormatStyle(timeZone: timeZone)),
                       dateRange.formatted(Date.IntervalFormatStyle(timeZone: timeZone)))

        timeZone = TimeZone(abbreviation: "ICT")!
        XCTAssertEqual(dateRange.bpFormatted(Date.BPIntervalFormatStyle(timeZone: timeZone)),
                       dateRange.formatted(Date.IntervalFormatStyle(timeZone: timeZone)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testLocale() {
#warning("🆘 All locales except en-US return a 4-digit year. Something seems not quite right yet in Apple's implementation")

        var locale = Locale(identifier: "be-NL")
        XCTAssertEqual(dateRange.bpFormatted(.interval.locale(locale)),
                       dateRange.formatted(.interval.locale(locale)))

        XCTAssertEqual(dateRange.bpFormatted(Date.BPIntervalFormatStyle(locale: locale)),
                       dateRange.formatted(Date.IntervalFormatStyle(locale: locale)))


        locale = Locale(identifier: "en-US")
        XCTAssertEqual(dateRange.bpFormatted(.interval.locale(locale)),
                       dateRange.formatted(.interval.locale(locale)))

        XCTAssertEqual(dateRange.bpFormatted(Date.BPIntervalFormatStyle(locale: locale)),
                       dateRange.formatted(Date.IntervalFormatStyle(locale: locale)))


        locale = Locale(identifier: "en-UK")
        XCTAssertEqual(dateRange.bpFormatted(.interval.locale(locale)),
                       dateRange.formatted(.interval.locale(locale)))

        XCTAssertEqual(dateRange.bpFormatted(Date.BPIntervalFormatStyle(locale: locale)),
                       dateRange.formatted(Date.IntervalFormatStyle(locale: locale)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testCalendar() {

        var calendar = Calendar(identifier: .gregorian)
        XCTAssertEqual(dateRange.bpFormatted(Date.BPIntervalFormatStyle(calendar: calendar)),
                       dateRange.formatted(Date.IntervalFormatStyle(calendar: calendar)))

        calendar = Calendar(identifier: .buddhist)
        XCTAssertEqual(dateRange.bpFormatted(Date.BPIntervalFormatStyle(calendar: calendar)),
                       dateRange.formatted(Date.IntervalFormatStyle(calendar: calendar)))

        calendar = Calendar(identifier: .chinese)
        XCTAssertEqual(dateRange.bpFormatted(Date.BPIntervalFormatStyle(calendar: calendar)),
                       dateRange.formatted(Date.IntervalFormatStyle(calendar: calendar)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testInteroperability() throws {
        try assertInteroperability(.interval,
                                   .interval)

        try assertInteroperability(.interval.day().hour(.defaultDigitsNoAMPM),
                                   .interval.day().hour(.defaultDigitsNoAMPM))

        try assertInteroperability(Date.BPIntervalFormatStyle(date: .numeric, time: .shortened),
                                   Date.IntervalFormatStyle(date: .numeric, time: .shortened))

        let locale = Locale(identifier: "en-US")
        let calendar = Calendar(identifier: .buddhist)
        let timeZone = TimeZone(abbreviation: "BST")!
        try assertInteroperability(Date.BPIntervalFormatStyle(date: .complete,
                                                      time: .complete,
                                                      locale: locale,
                                                      calendar: calendar,
                                                      timeZone: timeZone),
                                   Date.IntervalFormatStyle(date: .complete,
                                                    time: .complete,
                                                    locale: locale,
                                                    calendar: calendar,
                                                    timeZone: timeZone))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func assertInteroperability<T: FormatStyle>(_ bpFormat: Date.BPIntervalFormatStyle, _ format: T) throws {
        let bpEncoded = try JSONEncoder().encode(bpFormat)
        let appleEncoded = try JSONEncoder().encode(format)

        // Check if both json results have the same keys
        let bpSortedKeys = (try JSONSerialization.jsonObject(with: bpEncoded, options: []) as? [String: Any])?.keys.sorted() ?? []
        let appleSortedKeys = (try JSONSerialization.jsonObject(with: appleEncoded, options: []) as? [String: Any])?.keys.sorted() ?? []
        XCTAssertEqual(bpSortedKeys, appleSortedKeys)

        // Check if Apple can decode an encoded BPFormatStyle and compare the formatted result
        let appleDecoded = try JSONDecoder().decode(Date.IntervalFormatStyle.self, from: bpEncoded)
        XCTAssertEqual(dateRange.bpFormatted(bpFormat),
                       dateRange.formatted(appleDecoded))
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
                XCTAssertEqual(self.dateRange.bpFormatted(.interval.year().day().month()),
                               self.dateRange.bpFormatted(.interval.year().day().month()))
                datesExpectation.fulfill()
            }
        }
        timesQueue.async {
            for _ in 0..<repetitions {
                XCTAssertEqual(self.dateRange.bpFormatted(.interval.minute().second().hour()),
                               self.dateRange.bpFormatted(.interval.minute().second().hour()))
                timesExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 30, handler: nil)
    }
}
