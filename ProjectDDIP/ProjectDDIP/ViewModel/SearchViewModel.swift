//
//  ViewModel.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/24.
//

import SwiftUI
import UIKit
import MapKit
import Combine

final class SearchViewModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    
    @Published var searchText: String = ""
    @Published var searchResult: [MKLocalSearchCompletion] = []
    
    var center: MapCenter
    
    private var completer: MKLocalSearchCompleter
    private var cancellable: AnyCancellable?
    private var places: MKMapItem?
    private var localSearch: MKLocalSearch? {
        willSet {
            places = nil
            localSearch?.cancel()
        }
    }
    
    init(center: MapCenter) {
        completer = MKLocalSearchCompleter()
        self.center = center
        super.init()
        cancellable = $searchText.assign(to: \.queryFragment, on: self.completer)
        completer.delegate = self
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchResult = completer.results
    }
    
    func moveToLocation (result: MKLocalSearchCompletion) -> Void {
        search(for: result)
    }
    
    
    private func search(for suggestedCompletion: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: suggestedCompletion)
        search(using: searchRequest)
    }

    private func search(using searchRequest: MKLocalSearch.Request) {
        searchRequest.region = MKCoordinateRegion(MKMapRect.world)
        searchRequest.resultTypes = .pointOfInterest
        localSearch = MKLocalSearch(request: searchRequest)
        localSearch?.start { [unowned self] (response, error) in
            guard error == nil else {
                return
            }
            // 검색한 결과 : reponse의 mapItems 값을 가져온다.
            places = response?.mapItems[0]
            if let p = places {
                let a:CLCircularRegion = p.placemark.region as! CLCircularRegion
                print("p : \(p.placemark.coordinate.latitude)")
                print("p : \(p.placemark.coordinate.longitude)")
                print("p : \(a.radius)")
                center.coordinate = p.placemark.coordinate
                center.zoomLevel = "default"
            }
        }
    }
}
