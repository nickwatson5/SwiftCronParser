//
//  SwiftParser.swift
//  SwiftCronParser
//
//  Created by Nick Watson on 17/09/2022.
//

enum SwiftCronParserError: Error {
    case invalidFormat(String)
}

enum TimeParsingErrors: Error {
    case invalidFormat(String)
    case invalidTimeComponentFormat(String)
    case invalidTimeComponentRange(String, ClosedRange<Int>)
}

// MARK: - Parsers

private let hoursRange = 0...23
private let minutesRange = 0...59

func timeParser(_ rawInput: String) throws -> Time {
    let components = rawInput.split(separator: ":", maxSplits: 1)
    guard components.count == 2 else {
        throw TimeParsingErrors.invalidFormat(rawInput)
    }
    let minute = try parseInt(String(components[1]), range: minutesRange)
    let hour = try parseInt(String(components[0]), range: hoursRange)
    return Time(hours: hour, minutes: minute)
}

func cronParser(_ rawInput: String) throws -> SwiftCronJob {
    let components = rawInput.split(separator: " ", maxSplits: 2)
    guard components.count == 3, let command = components.last.map({ String($0) }) else {
        throw SwiftCronParserError.invalidFormat(rawInput)
    }
    let minute = try parseCronTimeComponent(String(components[0]), range: minutesRange)
    let hour = try parseCronTimeComponent(String(components[1]), range: hoursRange)
    return SwiftCronJob(hour: hour, minute: minute, command: command)
}

// MARK: - Utility

private func parseCronTimeComponent(_ input: String, range: ClosedRange<Int>) throws -> Int? {
    guard input != "*" else {
        return nil
    }
    return try parseInt(input, range: range)
}

private func parseInt(_ input: String, range: ClosedRange<Int>) throws -> Int {
    guard let intValue = Int(input) else {
        throw TimeParsingErrors.invalidTimeComponentFormat(input)
    }
    guard range.contains(intValue) else {
        throw TimeParsingErrors.invalidTimeComponentRange(input, range)
    }
    return intValue
}
