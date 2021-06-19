//
//  Date.SymbolsConfig.swift
//  
//
//  Created by Simon Salomons on 19/06/2021.
//

import Foundation

extension Date.BPFormatStyle {

    internal struct SymbolsConfig: Hashable, Codable {
        var era: String?
        var year: String?
        var quarter: String?
        var month: String?
        var week: String?
        var day: String?
        var dayOfYear: String?
        var weekday: String?
        var hour: String?
        var minute: String?
        var second: String?
        var secondFraction: String?
        var timeZoneSymbol: String?

        var components: [String] {
            [era, year, quarter, month, week, day, dayOfYear, weekday, hour, minute, second, secondFraction, timeZoneSymbol].compactMap({ $0 })
        }

        var template: String {
            components.joined(separator: " ")
        }

        init() {}

        init(era: Symbol.Era? = nil,
             year: Symbol.Year? = nil,
             quarter: Symbol.Quarter? = nil,
             month: Symbol.Month? = nil,
             week: Symbol.Week? = nil,
             day: Symbol.Day? = nil,
             dayOfYear: Symbol.DayOfYear? = nil,
             weekday: Symbol.Weekday? = nil,
             hour: Symbol.Hour? = nil,
             minute: Symbol.Minute? = nil,
             second: Symbol.Second? = nil,
             secondFraction: Symbol.SecondFraction? = nil,
             timeZone: Symbol.TimeZone? = nil) {
            self.era = era?.value
            self.year = year?.value
            self.quarter = quarter?.value
            self.month = month?.value
            self.week = week?.value
            self.day = day?.value
            self.dayOfYear = dayOfYear?.value
            self.weekday = weekday?.value
            self.hour = hour?.value
            self.minute = minute?.value
            self.second = second?.value
            self.secondFraction = secondFraction?.value
            self.timeZoneSymbol = timeZone?.value
        }

        init(date: DateStyle?, time: TimeStyle?) {
            switch date?.style {
            case .none, .omitted:
                break
            case .abbreviated:
                year = Symbol.Year.defaultDigits.value
                month = Symbol.Month.abbreviated.value
                day = Symbol.Day.defaultDigits.value
            case .numeric:
                year = Symbol.Year.defaultDigits.value
                month = Symbol.Month.defaultDigits.value
                day = Symbol.Day.defaultDigits.value
            case .long:
                year = Symbol.Year.defaultDigits.value
                month = Symbol.Month.wide.value
                day = Symbol.Day.defaultDigits.value
            case .complete:
                year = Symbol.Year.defaultDigits.value
                month = Symbol.Month.wide.value
                day = Symbol.Day.defaultDigits.value
                weekday = Symbol.Weekday.wide.value
            }

            switch time?.style {
            case .none, .omitted:
                break
            case .shortened:
                minute = Symbol.Minute.twoDigits.value
                hour = Symbol.Hour.defaultDigits(amPM: .abbreviated).value
            case .standard:
                minute = Symbol.Minute.twoDigits.value
                hour = Symbol.Hour.defaultDigits(amPM: .abbreviated).value
                second = Symbol.Second.twoDigits.value
            case .complete:
                minute = Symbol.Minute.twoDigits.value
                hour = Symbol.Hour.defaultDigits(amPM: .abbreviated).value
                second = Symbol.Second.twoDigits.value
                timeZoneSymbol = Symbol.TimeZone.specificName(.short).value
            }
        }
    }
}
