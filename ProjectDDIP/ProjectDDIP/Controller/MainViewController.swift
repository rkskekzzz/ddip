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
		
		// MainView
		mainViewContainer.mapViewController.delegate = self
		addChild(mainViewContainer.mapViewController)
		view.addSubview(mainViewContainer.mapViewController.view)
		
		// SearchFloatingView
		let fpcDelegate: PanelDelegate = SearchFloatingViewDelegate(owner: self)
		mainViewContainer.searchFloatingViewController.delegate = fpcDelegate
		mainViewContainer.searchFloatingViewController.set(contentViewController: mainViewContainer.searchViewController)
		mainViewContainer.searchFloatingViewController.track(scrollView: mainViewContainer.searchViewController.tableView)
		mainViewContainer.searchFloatingViewController.addPanel(toParent: self)
		
		// SearchView
        mainViewContainer.searchViewController.panelUp = {
			self.mainViewContainer.searchFloatingViewController.move(to: .full, animated: true)
        }
        mainViewContainer.searchViewController.panelDown = {
			self.mainViewContainer.searchFloatingViewController.move(to: .tip, animated: true)
        }
	}
}

extension MainViewController: MapViewControllerDelegate {
	func didUpdateMapVCAnnotation(annotationObject: AnnotationObject) {
		DispatchQueue.main.async {
			print(annotationObject.locationName as Any)
			print(annotationObject.coordinate.latitude)
			print(annotationObject.coordinate.longitude)
			print(annotationObject.discipline as Any)
		}
	}
}
