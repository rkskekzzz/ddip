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
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var slideCardState: SlideCardState
    @State private var activateDeleteButton:Bool = false
    
    
    @EnvironmentObject var mySchedule: MySchedule
    
//    지워도 될듯
//    func deleteSchedule(id: UUID) {
//        mySchedule.item = mySchedule.item.filter { $0.id != id }
//    }
    
    var body: some View {
        
        NavigationView {
            //            List(mySchedule.item) { schedule in
            List {
                ForEach(mySchedule.item, id: \.id) { schedule in
                    ScheduleCard(activateDeleteButton: $activateDeleteButton, schedule: schedule)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white).shadow(radius: 4))
                        .padding(.vertical, 5)
                    //
                }
                .onDelete(perform: onDelete)
                .onMove(perform: onMove)
                
            }
            .listStyle(.plain)
            .navigationBarHidden(false)
            .navigationBarBackButtonHidden(false)
            .navigationTitle("Schedule")
            .navigationBarItems(leading: Button(action: {
                //                slideCardState = .search
                presentationMode.wrappedValue.dismiss()
            }, label: { Text("back")
            }), trailing: EditButton() )
            
        }
    }
    
    private func onDelete(at offsets: IndexSet) {
        mySchedule.item.remove(atOffsets: offsets)
    }
    
    private func onMove(source: IndexSet, destination: Int) {
        mySchedule.item.move(fromOffsets: source, toOffset: destination)
    }
    
}

//struct ScheduleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScheduleView(showingScheduleView: .constant(true)).environmentObject(EnData())
//    }
//}
