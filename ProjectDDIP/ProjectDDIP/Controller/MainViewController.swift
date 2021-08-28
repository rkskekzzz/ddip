//
//  ViewController.swift
//  ProjectDDIP
//
//  Created by su on 2021/08/23.
//

import UIKit
import FloatingPanel

class MainViewController: UIViewController {
	typealias PanelDelegate = FloatingPanelControllerDelegate & UIGestureRecognizerDelegate
	
	lazy var mainViewContainer = MainViewContainer(storyBoard: storyboard)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initMainView()
		initSearchView()
		initMeetingView()
	}
}

extension MainViewController {
	func initMainView() {
		mainViewContainer.mapViewController.delegate = mainViewContainer.meetingViewController
		addChild(mainViewContainer.mapViewController)
		view.addSubview(mainViewContainer.mapViewController.view)
	}
	
	func initSearchView() {
		// SearchFloatingView
		let fpc = mainViewContainer.searchFloatingViewController
		let fpcDelegate: PanelDelegate = SearchFloatingViewDelegate(owner: self)
		
		fpc.delegate = fpcDelegate
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
	}
	
	func initMeetingView() {
		// MeetingFloatingView
		let fpc = mainViewContainer.meetingFloatingViewController
		let fpcDelegate: PanelDelegate = MeetingFloatingViewDelegate(owner: self)
		
		fpc.delegate = fpcDelegate
		fpc.set(contentViewController: mainViewContainer.meetingViewController)
		fpc.isRemovalInteractionEnabled = true

		// MeetingView
		mainViewContainer.meetingViewController.view.backgroundColor = .clear
		mainViewContainer.meetingViewController.panelUp = {
			fpc.addPanel(toParent: self, animated: true, completion: nil)
		}
	}
}
