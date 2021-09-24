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
    
    let searchView = UISearchBar()
    
    @Binding var searchBarPosition: CardPosition
    
    @ObservedObject var viewModel: SearchViewModel
    
    func makeUIView(context: Context) -> UIViewType {
        searchView.searchBarStyle = .minimal
        searchView.delegate = context.coordinator
        return searchView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        viewModel.test = 10
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

extension SearchBar {
    class Coordinator: NSObject, UISearchBarDelegate, MKLocalSearchCompleterDelegate {
        var parent: SearchBar
        
        private var searchCompleterDelegate: MKLocalSearchCompleterDelegate
        private var searchCompleter = MKLocalSearchCompleter()
        
        init(_ parent: SearchBar) {
            self.parent = parent
            self.searchCompleterDelegate = SearchCompleterDelegate(parent)
            self.searchCompleter.delegate = self.searchCompleterDelegate
            self.searchCompleter.resultTypes = .query
            self.searchCompleter.region = MKCoordinateRegion(MKMapRect.world)
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            parent.viewModel.searchText = searchText
            self.searchCompleter.queryFragment = searchText
        }
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            parent.searchBarPosition = .top
            searchBar.setShowsCancelButton(true, animated: true)
        }
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            parent.searchBarPosition = .bottom
            searchBar.setShowsCancelButton(false, animated: true)
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            parent.searchBarPosition = .bottom
            searchBar.text = nil
            
            self.searchCompleter.queryFragment = ""
            searchBar.resignFirstResponder()
        }
    }
}
