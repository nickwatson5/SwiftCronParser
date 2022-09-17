//
//  main.swift
//  SwiftCronParser
//
//  Created by Nick Watson on 17/09/2022.
//

// Parse CLI arguments

import Darwin

let time: Time
var swiftCronJobs: [SwiftCronJob] = []

guard CommandLine.arguments.count >= 2 else {
    print("Provide an hour command line arg: 10:30")
    exit(1)
}

do {
    time = try timeParser(CommandLine.arguments[1])
} catch {
    print("Invalid argument format. It should be a hour string: 10:30")
    exit(1)
}

while let line = readLine(), !line.isEmpty {
    do {
        swiftCronJobs.append(try cronParser(line))
    } catch {
        print(error)
    }
}

let manager = SwiftCronManager(swiftCronJobs: swiftCronJobs)
let schedules = manager.cronSchedules(withTime: time)

for schedule in schedules {
    print(String(format: "%d:%02d %@ - %@", schedule.hour, schedule.minute, schedule.day.rawValue, schedule.command))
}
