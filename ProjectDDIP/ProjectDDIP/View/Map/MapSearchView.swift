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
    
    @Binding var viewState:ViewState
    var searchViewModel: SearchViewModel
    
    var body: some View {
        ZStack {
            MapView(viewModel: viewModel)
            Button(action: {
                self.viewState = .sceduleview
            }) {
                Text("go to schedule")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(.vertical, 100)
            .padding(.horizontal, 40)
            SlideOverCard($searchBarPosition) {
                VStack {
                    SearchView(searchBarPosition: $searchBarPosition, viewModel: searchViewModel)
                        .padding(.horizontal, 10)
                        .animation(.default)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

//struct MapSearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapSearchView()
//    }
//}
