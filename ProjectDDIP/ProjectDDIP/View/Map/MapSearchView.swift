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
    @State private var searchBarPosition = CardPosition.bottom
    
    var searchViewModel: SearchViewModel
    
    var body: some View {
        ZStack {
            MapView(viewModel: searchViewModel)
            SlideOverCard($searchBarPosition, backgroundStyle: BackgroundStyle.solid) {
                VStack {
                    SearchView(searchText: searchViewModel, searchResult: searchResult, searchBarPosition: $searchBarPosition)
                        .padding(.horizontal, 10)
                        .animation(.default)
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
