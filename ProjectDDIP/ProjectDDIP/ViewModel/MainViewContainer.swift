//
//  MainViewContainer.swift
//  ProjectDDIP
//
//  Created by su on 2021/08/23.
//

import UIKit
import FloatingPanel

struct MainViewContainer {
    
    let mapViewController: MapViewController
  	let searchViewController: SearchViewController
    
    // guard 처리 하는게 맞는지?
    init(storyBoard: UIStoryboard?) {
		let storyboard = storyBoard!
		
		mapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
		searchViewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
//		print(searchViewController)
		
//        if (MainViewContainer.share == nil) { MainViewContainer.share = self }
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
