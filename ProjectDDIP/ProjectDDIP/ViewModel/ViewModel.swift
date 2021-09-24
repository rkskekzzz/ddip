//
//  ViewModel.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/24.
//

import SwiftUI
import MapKit
import Combine

class ViewModel: ObservableObject {
    @Published var searchText: String = ""
    
//    @Published var completerResults: [MKLocalSearchCompletion]?
//    init(searchText: String) {
//        self.searchText = searchText
//    }
    
}

//
//extension ViewModel: MKLocalSearchCompleterDelegate {
//    // completer가 결과를 업데이트 할때
//    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
//        completerResults = completer.results
//        // tableView reload
//    }
//
//    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
//        if let error = error as NSError? {
//            print("MKLocalSearchCompleter encountered an error: \(error.localizedDescription). The query fragment is: \"\(completer.queryFragment)\"")
//        }
//    }
//}
