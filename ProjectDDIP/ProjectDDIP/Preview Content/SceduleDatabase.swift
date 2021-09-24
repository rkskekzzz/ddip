//
//  SceduleDatabase.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/24.
//

import Foundation

extension ScheduleModel {
    static var data: [ScheduleModel] {
        [
            ScheduleModel(title: "면접 스터디", remainTime: 3,totalAttendees: 10, currentAttendees: 9, position: "사보이시티 잠실",startTime: 8, endTime: 24),
            ScheduleModel(title: "모여서 각자 코딩", remainTime: 3,totalAttendees: 10, currentAttendees: 9, position: "사보이시티 잠실",startTime: 8, endTime: 24),
            ScheduleModel(title: "커피마시기 모임", remainTime: 3,totalAttendees: 10, currentAttendees: 9, position: "사보이시티 잠실",startTime: 8, endTime: 24),
            ScheduleModel(title: "책읽고 독후감쓰기", remainTime: 3,totalAttendees: 10, currentAttendees: 9, position: "사보이시티 잠실",startTime: 8, endTime: 24)
        ]
    }
}
