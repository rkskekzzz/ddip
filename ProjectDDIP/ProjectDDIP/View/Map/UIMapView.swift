//
//  UIMapView.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/18.
//

import SwiftUI
import MapKit
import SlideOverCard

struct UIMapView: View {
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 25.7617,
            longitude: 80.1918
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 10,
            longitudeDelta: 10
        )
    )
    
    @State private var position = CardPosition.top
    @State private var background = BackgroundStyle.solid
    
    @State var searchText: String
    @State var searchResult: [SearchLocation]
    @State var test: Int
    
    var body: some View {
        ZStack {
            Map(
                coordinateRegion: $region,
                interactionModes: MapInteractionModes.all,
                showsUserLocation: true,
                userTrackingMode: $userTrackingMode
            )
            
            SlideOverCard($position, backgroundStyle: $background) {
                VStack {
                    SearchView(searchText: searchText, searchResult: searchResult, test: test)
                        .padding(.horizontal, 10)
                        .animation(.default)
                }
            }
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct UIMapView_Previews: PreviewProvider {
    static var previews: some View {
        UIMapView(searchText: "", searchResult: [], test: 0)
    }
    
}
