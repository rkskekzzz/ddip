//
//  ViewModel.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/24.
//

import SwiftUI
import MapKit
import Combine

class SearchViewModel: NSObject, ObservableObject {
    @Published var searchText: String = ""
    @Published var searchResult: [MKLocalSearchCompletion] = []
    
    var center: CLLocationCoordinate2D
    
    override init() {

    }
    
    private var places: MKMapItem?
    
    private var localSearch: MKLocalSearch? {
        willSet {
            places = nil
            localSearch?.cancel()
        }
    }
    
//    @Published var completerResults: [MKLocalSearchCompletion]?
//    init(searchText: String) {
//        self.searchText = searchText
//    }
    
    func moveToLocation (result: MKLocalSearchCompletion) -> Void {
        search(for: result)
//        movePanelToTip()
//        searchBarSetDefault()
//        self.searchBar.resignFirstResponder()
    }
    
    
    private func search(for suggestedCompletion: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: suggestedCompletion)
        search(using: searchRequest)
    }

    private func search(using searchRequest: MKLocalSearch.Request) {
        // 검색 지역 설정
        searchRequest.region = MKCoordinateRegion(MKMapRect.world)
        // 검색 유형 설정
        searchRequest.resultTypes = .pointOfInterest
        // MKLocalSearch 생성
        localSearch = MKLocalSearch(request: searchRequest)
        // 비동기로 검색 실행
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
//                centerModel.mapCenter.coordinate = p.placemark.coordinate
//                centerModel.mapCenter.zoomLevel = "default"
            }
        }
    }
}
