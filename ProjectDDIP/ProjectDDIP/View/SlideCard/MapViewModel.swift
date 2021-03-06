//
//  MapViewModel.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/24.
//

import SwiftUI
import MapKit
import Combine

class MapItemModel: ObservableObject {
    @Published var mapItem: MKMapItem?
}

final class MapViewModel: ObservableObject {
    
    @Published var selectedPin: DdipPinModel? = nil
    @Published var gesturePin = DdipPinModel(id: "", meetingName: "", location: CLLocationCoordinate2D(latitude: 0, longitude: 0)) // PinTemplate
    
    init() {
        
//        setAnnotation()
//        UIGestureInit()
    }
    
//    func center(to location: CLLocation, zoomLevel: String) {
//
//    }
    
}
