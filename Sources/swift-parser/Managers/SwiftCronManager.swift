//
//  SwiftCronManager.swift
//  SwiftCronParser
//
//  Created by Nick Watson on 17/09/2022.
//

final class SwiftCronManager {
    private let swiftCronJobs: [SwiftCronJob]
    
    init(swiftCronJobs: [SwiftCronJob]) {
        self.swiftCronJobs = swiftCronJobs
    }
    
    func cronSchedules(withTime: Time) -> [SwiftCronSchedule] {
        swiftCronJobs.map({ nextCronSchedule(for: $0, withTime: time) })
    }
    
    func nextCronSchedule(for swiftCronJobs: SwiftCronJob, withTime time: Time) -> SwiftCronSchedule {
        var nextRunningDay = SwiftCronSchedule.ScheduleDay.today
        
        var nextRunningTime = Time(
            hours: swiftCronJobs.hour ?? time.hours, minutes: swiftCronJobs.minute ?? time.minutes
        )
        
        if nextRunningTime < time {
            if swiftCronJobs.hour == nil {
                nextRunningTime.hours += 1
                if nextRunningTime.hours > 23 {
                    nextRunningTime.hours = 0
                    nextRunningDay = .tomorrow
                }
            } else {
                nextRunningDay = .tomorrow
            }
            
            if swiftCronJobs.minute == nil {
                if time.hours > nextRunningTime.hours {
                    nextRunningTime.minutes = 0
                }
            }
        } else {
            if swiftCronJobs.minute == nil {
                if time.hours < nextRunningTime.hours {
                    nextRunningTime.minutes = 0
                }
            }
        }
        
        return SwiftCronSchedule(
            hour: nextRunningTime.hours, minute: nextRunningTime.minutes,
            day: nextRunningDay, command: swiftCronJobs.command
        )
    }
}
