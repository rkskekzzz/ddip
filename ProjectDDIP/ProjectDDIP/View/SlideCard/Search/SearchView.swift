//
//  SwiftUIView.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/18.
//

import SwiftUI
import MapKit
import SlideOverCard

extension MKLocalSearchCompletion: Identifiable {}

struct SearchView: View {
    @Binding var searchBarPosition: CardPosition

    @ObservedObject var viewModel: SearchViewModel
    @EnvironmentObject var mapItem: MapItemModel
    
    var body: some View {
        VStack {
            SearchBar(searchBarPosition: $searchBarPosition, viewModel: viewModel)
            List(viewModel.searchResult) { result in
                Button(action: {
                    viewModel.moveToLocation(result: result)
                    mapItem.mapItem = viewModel.resultItem
                }) {
                    VStack(alignment: .leading) {
                        Text("\(result.title)")
                            .font(.headline)
                        if !result.subtitle.isEmpty {
                            Text("\(result.subtitle)")
                                .font(.caption)
                        }
                    }
                }
                .foregroundColor(Color.black)
            }
            .listStyle(.plain)
            .animation(nil, value: 3)
        }
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView(searchText: "", searchResult: [], test: 0, searchBarPosition: .constant(.bottom))
//    }
//}
