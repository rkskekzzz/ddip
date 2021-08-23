//
//  MainViewContainer.swift
//  ProjectDDIP
//
//  Created by su on 2021/08/23.
//

import UIKit
import FloatingPanel

struct MainViewContainer {
	typealias PanelDelegate = FloatingPanelControllerDelegate & UIGestureRecognizerDelegate
    
    var mapViewController: MapViewController
	var searchViewController: SearchViewController
    
	lazy var searchViewFpc = FloatingPanelController()
	lazy var searchViewFpcDelegate: PanelDelegate = SearchViewPanelDelegate(owner: mapViewController)
	
    // guard 처리 하는게 맞는지?
    init(storyboard: UIStoryboard?) {
        mapViewController = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
		searchViewController = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
    }
}
