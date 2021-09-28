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
    
    @State var searchText: String
    @State var searchResult: [SearchLocation]
    
    
    var body: some View {
        NavigationView {
            ZStack {
                MapView()
                HStack {
                    NavigationLink(destination: NewMeetingView()) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(100)
                            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                    }
                    NavigationLink(destination: ScheduleView()) {
                        Image(systemName: "calendar.circle")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                            .background(Color.pink)
                            .cornerRadius(100)
                            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                    }
                    .buttonStyle(.plain)
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
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct UIMapView_Previews: PreviewProvider {
    static var previews: some View {
        UIMapView(searchText: "", searchResult: [])
    }

}
