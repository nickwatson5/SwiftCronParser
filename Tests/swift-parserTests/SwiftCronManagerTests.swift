//
//  SwiftCronManagerTests.swift
//  SwiftCronParser
//
//  Created by Nick Watson on 17/09/2022.


import XCTest
@testable import swift_parser

class SwiftCronManagerTests: XCTestCase {
    
    let manager = SwiftCronManager(swiftCronJobs: [])

    func test_fixedCron_sameMoment() {
        validateCronResult(
            job: "30 10 test",
            time: Time(hours: 10, minutes: 30),
            resHour: 10,
            resMinute: 30,
            resDay: .today
        )
    }
    
    func test_fixedCron_pastMoment() {
        validateCronResult(
            job: "30 10 test",
            time: Time(hours: 10, minutes: 20),
            resHour: 10,
            resMinute: 30,
            resDay: .today
        )
    }
    
    func test_fixedCron_futureMoment() {
        validateCronResult(
            job: "30 10 test",
            time: Time(hours: 10, minutes: 40),
            resHour: 10,
            resMinute: 30,
            resDay: .tomorrow
        )
    }
    
    func test_hourCron_sameMoment() {
        validateCronResult(
            job: "30 * test",
            time: Time(hours: 10, minutes: 30),
            resHour: 10,
            resMinute: 30,
            resDay: .today
        )
    }
    
    func test_hourCron_pastMoment() {
        validateCronResult(
            job: "30 * test",
            time: Time(hours: 10, minutes: 20),
            resHour: 10,
            resMinute: 30,
            resDay: .today
        )
    }
    
    func test_hourCron_futureMoment() {
        validateCronResult(
            job: "30 * test",
            time: Time(hours: 10, minutes: 40),
            resHour: 11,
            resMinute: 30,
            resDay: .today
        )
    }
    
    func test_minuteCron_sameMoment() {
        validateCronResult(
            job: "* 10 test",
            time: Time(hours: 10, minutes: 30),
            resHour: 10,
            resMinute: 30,
            resDay: .today
        )
    }
    
    func test_minuteCron_futureMoment() {
        validateCronResult(
            job: "* 10 test",
            time: Time(hours: 11, minutes: 40),
            resHour: 10,
            resMinute: 0,
            resDay: .tomorrow
        )
    }
    
    func test_cron_anyMoment() {
        validateCronResult(
            job: "* * test",
            time: Time(hours: 10, minutes: 20),
            resHour: 10,
            resMinute: 20,
            resDay: .today
        )
    }
    
    private func validateCronResult(
        job: String,
        time: Time,
        resHour: Int,
        resMinute: Int,
        resDay: SwiftCronSchedule.ScheduleDay
    ) {
        let cron = try! cronParser(job)
        
        let schedule = manager.nextCronSchedule(for: cron, withTime: time)
        
        XCTAssertEqual(schedule.hour, resHour, "Hours not matching")
        XCTAssertEqual(schedule.minute, resMinute, "Minutes not matching")
        XCTAssertEqual(schedule.day, resDay, "Days not matching")
    }
}
