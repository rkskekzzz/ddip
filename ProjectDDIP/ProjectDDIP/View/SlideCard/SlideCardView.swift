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

struct SlideCardView: View {
    @Binding var slideCardState: SlideCardState
    
    @State private var searchViewPosition = CardPosition.bottom
    @State private var meetingViewPosition = CardPosition.middle
    @State private var scheduleViewPosition = CardPosition.top
    
    var searchViewModel: SearchViewModel = SearchViewModel()
    var meetingViewModel: MeetingViewModel
    
    var body: some View {
        ZStack {
            SlideOverCard($searchViewPosition, backgroundStyle: .constant(BackgroundStyle.solid)) {
                SearchView(searchBarPosition: $searchViewPosition, viewModel: searchViewModel)
                    .padding(.horizontal, 10)
                    .animation(.default, value: 3)
            }
            .transition(.offset(x: 0, y: 80))
            .animation(.easeInOut(duration: 1), value: 0.5)
            .zIndex(1)
            if slideCardState == .meeting {
                SlideOverCard($meetingViewPosition, backgroundStyle: .constant(BackgroundStyle.solid)) {
                    MeetingView(slideCardState: $slideCardState)
                        .padding(.horizontal, 10)
                        .animation(.default, value: 3)
                }
                .onDisappear { meetingViewPosition = .middle }
                .transition(.offset(x: 0, y: getSlideCardPositionValue(meetingViewPosition)))
                .animation(.easeInOut(duration: 1), value: 0.5)
                .zIndex(2)
            }
            if slideCardState == .schedule {
                SlideOverCard($scheduleViewPosition, backgroundStyle: .constant(BackgroundStyle.solid)) {
                    ScheduleView(slideCardState: $slideCardState, mySchedule: EnvironmentObject<MySchedule>())
                        .padding(.horizontal, 10)
                        .animation(.default, value: 3)
                }
                .onDisappear { scheduleViewPosition = .top }
                .transition(.offset(x: 0, y: getSlideCardPositionValue(scheduleViewPosition)))
                .animation(.easeInOut(duration: 1), value: 0.5)
                .zIndex(3)
            }
        }
        
        
    }
}

