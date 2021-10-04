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
    
    @Binding var searchBarPosition: CardPosition
    @ObservedObject var viewModel: SearchViewModel
    
    let searchView = UISearchBar()
    
    func makeUIView(context: Context) -> UIViewType {
        searchView.searchBarStyle = .minimal
        searchView.delegate = context.coordinator
        return searchView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if searchBarPosition != .top {
            uiView.text = nil
            uiView.resignFirstResponder()
//            self.viewModel.searchText = ""
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

extension SearchBar {
    class Coordinator: NSObject, UISearchBarDelegate, MKLocalSearchCompleterDelegate {
        var parent: SearchBar
 
        init(_ parent: SearchBar) {
            self.parent = parent
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            parent.viewModel.searchText = searchText
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
            searchBar.resignFirstResponder()
        }
        
        func searchCanceled(_ searchBar: UISearchBar) {
            searchBarCancelButtonClicked(searchBar)
        }
    }
}
