//
//  ScheduleView.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/18.
//

import SwiftUI

class EnData: ObservableObject {
    @Published var score = Schedule.data
    
}

struct ScheduleView: View {
    @Binding var showingScheduleView: Bool
    @State private var activateDeleteButton:Bool = false

    @EnvironmentObject var mySchedule: EnData

    func deleteSchedule(id: UUID) {
        mySchedule.score = mySchedule.score.filter { $0.id != id }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(mySchedule.score, id: \.id) { schedule in
                        ScheduleCard(activateDeleteButton: $activateDeleteButton, schedule: schedule, deleteScheldule: deleteSchedule)
                    }.background(RoundedRectangle(cornerRadius: 20).fill(Color.white).shadow(radius: 4))
                    .padding(.vertical, 5)
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            .navigationTitle("Schedule")
            .navigationBarItems(leading: Button(action: { showingScheduleView = false }, label: {
                Text("back")
            }), trailing: Button(action: { activateDeleteButton.toggle() }, label: {
                Text("edit")
            }))
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(showingScheduleView: .constant(true)).environmentObject(EnData())
    }
}
