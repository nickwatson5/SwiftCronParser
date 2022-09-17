//
//  SwiftCronScedule.swift
//  SwiftCronParser
//
//  Created by Nick Watson on 17/09/2022.
//

import Foundation

struct SwiftCronSchedule {
    enum ScheduleDay: String {
        case today, tomorrow
    }
    
    let hour: Int
    let minute: Int
    let day: ScheduleDay
    let command: String
}
