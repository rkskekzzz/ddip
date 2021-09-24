//
//  Schedule.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/24.
//

import Foundation

struct ScheduleModel: Identifiable {
    let id: UUID
    var title: String
    var remainTime: Int
    
    var totalAttendees: Int
    var currentAttendees: Int
    
    var position: String
    
    var startTime: Int
    var endTime: Int

    init(id: UUID = UUID(), title: String, remainTime: Int, totalAttendees: Int, currentAttendees: Int, position: String, startTime: Int, endTime: Int) {
        self.id = id
        self.title = title
        self.remainTime = remainTime
        self.totalAttendees = totalAttendees
        self.currentAttendees = currentAttendees
        self.position = position
        self.startTime = startTime
        self.endTime = endTime
    }
}
