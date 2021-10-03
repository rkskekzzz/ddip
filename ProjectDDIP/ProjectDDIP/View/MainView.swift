
//  UIMapView.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/18.
//

import SwiftUI
import MapKit
import SlideOverCard
import Combine


enum SlideCardState {
    case search
    case meeting
}

struct MainView: View {
    @State private var slideCardState: SlideCardState = .search
    var mapViewModel: MapViewModel = MapViewModel()
    var searchViewModel: SearchViewModel = SearchViewModel()
    var meetingViewModel: MeetingViewModel = MeetingViewModel()
    
    var body: some View {
        ZStack {
            MapView(mapViewModel: mapViewModel)
            ButtonView(slideCardState: $slideCardState)
            SlideCardView(slideCardState: $slideCardState, searchViewModel: searchViewModel, meetingViewModel: meetingViewModel)
                .zIndex(1)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

