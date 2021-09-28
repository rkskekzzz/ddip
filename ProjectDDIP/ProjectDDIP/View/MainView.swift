//
//  UIMapView.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/18.
//

import SwiftUI
import MapKit
import SlideOverCard
import Combine

struct MainView: View {
	var mapViewModel: MapViewModel = MapViewModel()
	var searchViewModel: SearchViewModel = SearchViewModel()
	var meetingViewModel: MeetingViewModel = MeetingViewModel()
   
    var body: some View {
            NavigationView {
                ZStack {
					MapView(mapViewModel: mapViewModel)
					ButtonView()
					SlideCardView(searchViewModel: searchViewModel, meetingViewModel: meetingViewModel)
                }
            }
            .edgesIgnoringSafeArea(.all)
    }
}
