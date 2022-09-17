//
//  SwiftCronParserTests.swift
//  SwiftCronParser
//
//  Created by Nick Watson on 17/09/2022.


import XCTest
@testable import swift_parser

class swiftCronParserTests: XCTestCase {

    func testHour() {
        let rawInput = "30 * /run_me"
        
        let cron = try! cronParser(rawInput)
        
        XCTAssertEqual(cron, SwiftCronJob(hour: nil, minute: 30, command: "/run_me"))
    }
    
    func testMinute() {
        let rawInput = "* 10 /run_me"
        
        let cron = try! cronParser(rawInput)
        
        XCTAssertEqual(cron, SwiftCronJob(hour: 10, minute: nil, command: "/run_me"))
    }
    
}
