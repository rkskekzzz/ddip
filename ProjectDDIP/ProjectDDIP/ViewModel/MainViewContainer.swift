//
//  MainViewContainer.swift
//  ProjectDDIP
//
//  Created by su on 2021/08/23.
//

import UIKit
import FloatingPanel

struct MainViewContainer {
    
    var mapViewController: MapViewController
	var searchViewController: SearchViewController
	
    // guard 처리 하는게 맞는지?
    init(storyboard: UIStoryboard?) {
        mapViewController = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
		searchViewController = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
    }
}
