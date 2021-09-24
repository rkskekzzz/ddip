//
//  SearchDelegate.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/24.
//

import UIKit
import MapKit

class SearchCompleterDelegate: NSObject, MKLocalSearchCompleterDelegate {
    var searchbar: SearchBar

    init(_ searchBar: SearchBar) {

        self.searchbar = searchBar
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchbar.viewModel.searchResult = completer.results
        print(self.searchbar.viewModel.searchResult.count)
//        self.searchbar.viewModel.searchResult.removeAll()
//
//        for (index, item) in completer.results.enumerated() {
//            self.searchbar.viewModel.searchResult.append(SearchLocation(id: index, title: item.title, subtitle: item.subtitle))
//        }
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        if let error = error as NSError? { // 나중에 가드로 수정해주세요 to 의민
            print("MKLocalSearchCompleter encountered an error: \(error.localizedDescription). The query fragment is: \"\(completer.queryFragment)\"")
            self.searchbar.viewModel.searchResult.removeAll()
        }
    }
}
