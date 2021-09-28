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
	@State private var slideCardState: SlideCardState = .none
	
	@State private var searchViewPosition = CardPosition.bottom
	@State private var meetingViewPosition = CardPosition.middle
	
	var searchViewModel: SearchViewModel
	var meetingViewModel: MeetingViewModel
	
	var body: some View {
		SlideOverCard($searchViewPosition, backgroundStyle: BackgroundStyle.solid) {
			SearchView()
				.padding(.horizontal, 10)
				.animation(.default)
		}
		SlideOverCard($meetingViewPosition, backgroundStyle: BackgroundStyle.solid) {
			MeetingView()
				.padding(.horizontal, 10)
				.animation(.default)
		}
	}
}

