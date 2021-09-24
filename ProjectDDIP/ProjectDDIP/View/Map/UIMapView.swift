//
//  UIMapView.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/18.
//

import SwiftUI
import MapKit
import SlideOverCard

struct UIMapView: View {
    @State private var showingScheduleView:Bool = false
    @State private var searchBarPosition = CardPosition.bottom
    @State private var searchBarBackground = BackgroundStyle.solid
//    @State private var region
    
    @State var searchText: String
    @State var searchResult: [SearchLocation]
    @State var test: Int
    
    var body: some View {
        if showingScheduleView {
            ScheduleView(showingScheduleView: $showingScheduleView, mySchedule: EnvironmentObject<MySchedule>())
                .animation(.spring())
        } else {
            ZStack {

                MapView()
                Button(action: {
                    self.showingScheduleView.toggle()
                }) {
                    Text("go to schedule")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(.vertical, 100)
                .padding(.horizontal, 40)
                SlideOverCard($searchBarPosition, backgroundStyle: $searchBarBackground) {
                    VStack {
                        SearchView(searchText: searchText, searchResult: searchResult, searchBarPosition: $searchBarPosition)
                            .padding(.horizontal, 10)
                            .animation(.default)
                    }
                }
                Text("\(test)")
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
}
//
//struct UIMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        UIMapView(searchText: "", searchResult: [], test: 0)
//    }
//
//}
