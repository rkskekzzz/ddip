
//  UIMapView.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/18.
//

import SwiftUI
import MapKit
import SlideOverCard
import Combine
//
//extension CGFloat {
//    enum SlideCardViewState {
//        case up
//        case down
//    }
//}

struct MainView: View {
    @State private var slideCardViewState = false
    var mapViewModel: MapViewModel = MapViewModel()
    var searchViewModel: SearchViewModel = SearchViewModel()
    var meetingViewModel: MeetingViewModel = MeetingViewModel()
    
    var body: some View {
//        ZStack {
            NavigationView {
                ZStack {
                    MapView(mapViewModel: mapViewModel)
                    ButtonView(slideCardViewState: $slideCardViewState)
                }
                .edgesIgnoringSafeArea(.all)
            }
            .overlay {
                VStack {
                    if slideCardViewState {
                        SlideCardView(searchViewModel: searchViewModel, meetingViewModel: meetingViewModel)
//                            .transition(.asymmetric(insertion: .offset(x: 0, y: 80), removal: .offset(x: 0, y: 80)))
                            .transition(.offset(x: 0, y: 80))
                            .animation(.easeInOut(duration: 1), value: 0.5)
                        
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear { slideCardViewState = true }
                
//        }
    }
}

