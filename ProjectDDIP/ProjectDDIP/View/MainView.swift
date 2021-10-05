
//  UIMapView.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/18.
//

import SwiftUI
import MapKit
import SlideOverCard
import Combine

let ANNOTATION_TOUCH_EXPAND: CGFloat = 16

enum SlideCardState {
    case search
    case meeting
    case schedule
}

enum GesturePinState {
    case on
    case off
}
//
//enum NetRequestState {
//    case on
//    case off
//}


struct MainView: View {
    @State private var slideCardState: SlideCardState = .search
    @State private var gesturePinState: GesturePinState = .off
//    @State private var netRequestState: NetRequestState = .off

    var mapViewModel: MapViewModel = MapViewModel()
    var searchViewModel: SearchViewModel = SearchViewModel()
    var meetingViewModel: MeetingViewModel = MeetingViewModel()
    
    var body: some View {
        ZStack {
//            NetworkView(netRequestState: $netRequestState, mapViewModel: mapViewModel)
            MapView(mapViewModel: mapViewModel, gesturePinState: $gesturePinState)
            ButtonView(slideCardState: $slideCardState)
            SlideCardView(slideCardState: $slideCardState, searchViewModel: searchViewModel, meetingViewModel: meetingViewModel)
                .zIndex(1)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

//var networkViewModel = NetworkViewModel()

