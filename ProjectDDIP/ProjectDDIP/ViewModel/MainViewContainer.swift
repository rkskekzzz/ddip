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
	
    let mapViewController: MapViewController
	
	let searchFloatingViewController = FloatingPanelController()
  	let searchViewController: SearchViewController
    
    // guard 처리 하는게 맞는지?
    init(storyBoard: UIStoryboard?) {
		let storyboard = storyBoard!
		
		mapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
		searchViewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
		
    }
}
