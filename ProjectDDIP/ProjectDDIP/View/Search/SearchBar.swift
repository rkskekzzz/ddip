//
//  UISearchView.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/18.

import MapKit
import UIKit
import SwiftUI
import SlideOverCard

struct SearchBar: UIViewRepresentable {
    typealias UIViewType = UISearchBar
    
    @Binding var searchText: String
    @Binding var searchResult: [SearchLocation]
    @Binding var searchBarPosition: CardPosition
    
    @Binding var test: Int
    
    
    
    func makeUIView(context: Context) -> UIViewType {
        let view = UISearchBar()
        view.searchBarStyle = .minimal

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.delegate = context.coordinator
    }
    

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, UISearchBarDelegate, MKLocalSearchCompleterDelegate {
        private var searchCompleterDelegate: MKLocalSearchCompleterDelegate
        private var searchCompleter = MKLocalSearchCompleter()
        var searchbar: SearchBar
        
        init(_ searchBar: SearchBar) {
            self.searchbar = searchBar
            self.searchCompleterDelegate = SearchCompleterDelegate(searchbar)
            self.searchCompleter.delegate = self.searchCompleterDelegate
            self.searchCompleter.resultTypes = .query
            self.searchCompleter.region = MKCoordinateRegion(MKMapRect.world)
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchbar.searchText = searchText
            self.searchCompleter.queryFragment = searchText
        }
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchbar.searchBarPosition = .top
        }
        
        class SearchCompleterDelegate: NSObject, MKLocalSearchCompleterDelegate {
            var searchbar: SearchBar

            init(_ searchBar: SearchBar) {
                
                self.searchbar = searchBar
            }
            
            // completer가 결과를 업데이트 할때
            func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
                searchbar.test += 1
                searchbar.searchResult.removeAll()
                for (index, item) in completer.results.enumerated() {
                    searchbar.searchResult.append(SearchLocation(id: index, title: item.title, subtitle: item.subtitle))
                }
            }
            
            func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
                searchbar.test += 1
                if let error = error as NSError? { // 나중에 가드로 수정해주세요 to 의민
                    print("MKLocalSearchCompleter encountered an error: \(error.localizedDescription). The query fragment is: \"\(completer.queryFragment)\"")
                    searchbar.searchResult.removeAll()
                }
            }
        }
       
    }
}
