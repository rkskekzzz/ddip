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

enum SlideCardState {
	case none
	case search
	case meeting
}

struct SlideCardView: View {
    @State private var slideCardState: SlideCardState = .search
    @State private var backgroundStyle = BackgroundStyle.solid
	
	@State private var searchViewPosition = CardPosition.bottom
	@State private var meetingViewPosition = CardPosition.middle
	
	var searchViewModel: SearchViewModel = SearchViewModel()
	var meetingViewModel: MeetingViewModel
	
	var body: some View {
        switch slideCardState {
        case .none:
            Spacer()
        case .search:
            SlideOverCard($searchViewPosition, backgroundStyle: $backgroundStyle) {
                SearchView(searchBarPosition: $searchViewPosition, viewModel: searchViewModel)
                    .padding(.horizontal, 10)
                    .animation(.default, value: 3)
            }
        case .meeting:
            SlideOverCard($meetingViewPosition, backgroundStyle: $backgroundStyle) {
                MeetingView()
                    .padding(.horizontal, 10)
                    .animation(.default, value: 3)
            }
        }
        
		
		
	}
}

