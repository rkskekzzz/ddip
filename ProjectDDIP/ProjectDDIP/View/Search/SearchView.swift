//
//  SwiftUIView.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/18.
//

import SwiftUI
import MapKit

struct SearchLocation: Identifiable, Hashable {
    var id: Int
    
    var title: String
    var subtitle: String
}

struct SearchView: View {
    @State var searchText: String
    @State var searchResult: [SearchLocation]
    @State var test: Int
    
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText, searchResult: $searchResult, searchBarPosition: $searchBarPosition, test: $test)

            List(searchResult) { result in
                Button(action: { }) {
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
            .animation(nil)
        }
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView(searchText: "", searchResult: [], test: 0, searchBarPosition: .constant(.bottom))
//    }
//}
