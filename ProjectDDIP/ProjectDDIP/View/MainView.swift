//
//  UIMapView.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/18.
//

import SwiftUI

enum MainViewState {
    case mapview
    case sceduleview
}

struct MainView: View {
    @State var viewState:MainViewState = .mapview
   
    var body: some View {
        switch viewState {
        case .mapview:
            MapSearchView(viewState: $viewState, searchViewModel: SearchViewModel())
        case .sceduleview:
            ScheduleView(viewState: $viewState, mySchedule: EnvironmentObject<MySchedule>())
                .animation(.spring())
        }
    }
}
//
//struct UIMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        UIMapView(searchText: "", searchResult: [], test: 0)
//    }
//
//}
