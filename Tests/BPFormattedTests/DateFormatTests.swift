import XCTest
@testable import BPFormatted

final class BPFormattedTests: XCTestCase {
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testGeneral() {
        let date = Date(timeIntervalSince1970: 1_623_225_158.123_456)

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
    func testLocale() {
        let date = Date(timeIntervalSince1970: 1_623_225_158.123_456)

        var locale = Locale(identifier: "be-NL")
        XCTAssertEqual(date.bpFormatted(.dateTime.locale(locale)),
                       date.formatted(.dateTime.locale(locale)))
        locale = Locale(identifier: "en-US")
        XCTAssertEqual(date.bpFormatted(.dateTime.locale(locale)),
                       date.formatted(.dateTime.locale(locale)))
        locale = Locale(identifier: "en-UK")
        XCTAssertEqual(date.bpFormatted(.dateTime.locale(locale)),
                       date.formatted(.dateTime.locale(locale)))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func testInteroperability() throws {
        try assertInteroperability(.dateTime)
        try assertInteroperability(.dateTime.day(.twoDigits).hour(.defaultDigitsNoAMPM))
        try assertInteroperability(Date.BPFormatStyle(date: .numeric, time: .shortened))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func assertInteroperability(_ bpFormat: Date.BPFormatStyle) throws {
        let bpEncoded = try JSONEncoder().encode(bpFormat)
        let appleDecoded = try JSONDecoder().decode(Date.FormatStyle.self, from: bpEncoded)

        XCTAssertEqual(bpFormat.timeZone, appleDecoded.timeZone)
        XCTAssertEqual(bpFormat.locale, appleDecoded.locale)
        XCTAssertEqual(bpFormat.calendar, appleDecoded.calendar)

        let date = Date(timeIntervalSince1970: 1_623_225_158.123_456)
        XCTAssertEqual(date.bpFormatted(bpFormat),
                       date.formatted(appleDecoded))
    }
}
