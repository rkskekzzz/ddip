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
	
  	let searchViewController: SearchViewController
	let searchPanelController = FloatingPanelController()
	var searchPanelDelegate: PanelDelegate?
	
	let meetingViewController: MeetingViewController
	let meetingPanelController = FloatingPanelController()
	var meetingPanelDelegate: PanelDelegate?
    
    // guard 처리 하는게 맞는지?
    init(storyBoard: UIStoryboard?) {
		let storyboard = storyBoard!
		
		mapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
		
		searchPanelDelegate = nil
		searchViewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
		
		meetingPanelDelegate = nil
		meetingViewController = storyboard.instantiateViewController(withIdentifier: "MeetingViewController") as! MeetingViewController
    }
}
