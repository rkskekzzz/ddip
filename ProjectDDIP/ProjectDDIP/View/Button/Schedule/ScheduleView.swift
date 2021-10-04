//
//  ScheduleView.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/18.
//

import SwiftUI
import MapKit

class MySchedule: ObservableObject {
    @Published var item = ScheduleModel.data
}

struct ScheduleView: View {
    @Binding var slideCardState: SlideCardState
    @State private var activateDeleteButton:Bool = false
    
    
    @EnvironmentObject var mySchedule: MySchedule
    
    func deleteSchedule(id: UUID) {
        mySchedule.item = mySchedule.item.filter { $0.id != id }
    }
    
    var body: some View {
        NavigationView {
            List(mySchedule.item) { schedule in
                ScheduleCard(activateDeleteButton: $activateDeleteButton, schedule: schedule, deleteScheldule: deleteSchedule)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.white).shadow(radius: 4))
                    .padding(.vertical, 5)
            }
            .listStyle(.plain)
            .navigationBarHidden(false)
            .navigationBarBackButtonHidden(false)
            .navigationTitle("Schedule")
            .navigationBarItems(leading: Button(action: {
                slideCardState = .search
            }, label: {
                Text("back")
            }), trailing: Button(action: { activateDeleteButton.toggle() }, label: {
                Text("edit")
            }))
        }
    }
}

//struct ScheduleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScheduleView(showingScheduleView: .constant(true)).environmentObject(EnData())
//    }
//}
