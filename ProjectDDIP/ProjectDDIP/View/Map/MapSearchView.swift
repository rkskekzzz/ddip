//
//  MapSearchView.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/24.
//

import SwiftUI
import MapKit
import SlideOverCard
import Combine

struct MapSearchView: View {
    @ObservedObject var viewModel: MapViewModel = MapViewModel()
    @State private var searchBarPosition = CardPosition.bottom
    
    var searchViewModel: SearchViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                MapView(viewModel: viewModel)
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
        }
        .edgesIgnoringSafeArea(.all)
    }
}
}

//struct MapSearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapSearchView()
//    }
//}
