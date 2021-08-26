//
//  MainViewContainer.swift
//  ProjectDDIP
//
//  Created by su on 2021/08/23.
//

import UIKit

struct MainViewContainer {
    
    static var share: MainViewContainer? = nil
    var mapViewController: MapViewController? = nil
	var searchViewController: SearchViewController? = nil
    
    // guard 처리 하는게 맞는지?
    init(storyboard: UIStoryboard?) {
        
        if mapViewController == nil { mapViewController = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController }
        if searchViewController == nil { searchViewController = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController }
        if (MainViewContainer.share == nil) { MainViewContainer.share = self }
//        MainViewContainer.share = self
        
//        if (MainViewContainer.share == nil) {
//            mapViewController = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController
//            searchViewController = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
//            MainViewContainer.share = self
//        }
        
        
//        mapViewController = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
//        searchViewController = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
//        MainViewContainer.share = self
    }
}
