//
//  Time.swift
//  SwiftCronParser
//
//  Created by Nick Watson on 17/09/2022.
//

struct Time: Equatable {
    var hours: Int
    var minutes: Int
}

extension Time: Comparable {
    
    static func < (lhs: Time, rhs: Time) -> Bool {
        if lhs.hours < rhs.hours {
            return true
        } else if lhs.hours == rhs.hours {
            return lhs.minutes < rhs.minutes
        }
        return false
    }
}
