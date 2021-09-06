//
//  ViewController.swift
//  ProjectDDIP
//
//  Created by su on 2021/08/23.
//

import UIKit
import MapKit
import FloatingPanel

class MainViewController: UIViewController {
	lazy var mainViewContainer = MainViewContainer(storyBoard: storyboard)
	
	override func viewDidLoad() {
		super.viewDidLoad()
    
		initMainView()
		initSearchView()
		initMeetingView()
	}
}

private extension MainViewController {
	func initMainView() {
		mainViewContainer.mapViewController.delegate = mainViewContainer.meetingViewController
		addChild(mainViewContainer.mapViewController)
		view.addSubview(mainViewContainer.mapViewController.view)
	}
	
	func initSearchView() {
		// SearchFloatingView
		let fpc = mainViewContainer.searchFloatingViewController
		let fpcDelegate = SearchFloatingViewDelegate(owner: self)
		
		mainViewContainer.searchFloatingViewDelegate = fpcDelegate
		fpc.delegate = fpcDelegate
		fpc.contentMode = .fitToBounds
		fpc.set(contentViewController: mainViewContainer.searchViewController)
		fpc.track(scrollView: mainViewContainer.searchViewController.tableView)
		fpc.addPanel(toParent: self)
		
		// SearchView
		mainViewContainer.searchViewController.view.backgroundColor = .clear
		mainViewContainer.searchViewController.panelUp = {
			fpc.move(to: .full, animated: true)
		}
		mainViewContainer.searchViewController.panelDown = {
			fpc.move(to: .tip, animated: true)
		}
		mainViewContainer.searchViewController.centerToSearchLocation = { (la, lo, dis) in
//			let location = CLLocation(latitude: la, longitude: lo)
			self.mainViewContainer.mapViewController.centerToLocation(self.mainViewContainer.mapViewController.convertToLocation(la, lo), dis)
		}
	}
	
	func initMeetingView() {
		// MeetingFloatingView
		let fpc = mainViewContainer.meetingFloatingViewController
		let fpcDelegate = MeetingFloatingViewDelegate(owner: self)
		
		mainViewContainer.meetingFloatingViewDelegate = fpcDelegate
		fpc.delegate = fpcDelegate
		fpc.contentMode = .fitToBounds
		fpc.set(contentViewController: mainViewContainer.meetingViewController)
		fpc.isRemovalInteractionEnabled = true

		// MeetingView
		let vc = mainViewContainer.meetingViewController
		let meetingViewFpc = mainViewContainer.meetingFloatingViewController
		let searchViewFpc = mainViewContainer.searchFloatingViewController
		
		vc.view.backgroundColor = .clear
		vc.changeViewToMeetingView = {
			meetingViewFpc.addPanel(toParent: self, animated: true, completion: nil)
			searchViewFpc.hide(animated: true, completion: nil)
		}
		vc.changeViewToMainView = {
			meetingViewFpc.dismiss(animated: true, completion: nil)
			searchViewFpc.show(animated: true, completion: nil)
		}
	}
}
