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
	
	lazy var fpc = FloatingPanelController()
	lazy var fpcDelegate: PanelDelegate = SearchViewPanelDelegate(owner: self)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		mainViewContainer.mapViewController.delegate = self
        mainViewContainer.searchViewController.panelUp = {
            print("in closure")
            self.fpc.move(to: .full, animated: true)
        }
        mainViewContainer.searchViewController.panelDown = {
            print("in closure")
            self.fpc.move(to: .tip, animated: true)
        }
		self.addChild(mainViewContainer.mapViewController)
		self.view.addSubview(mainViewContainer.mapViewController.view)
		
		fpc.delegate = fpcDelegate
		
		fpc.set(contentViewController: mainViewContainer.searchViewController)
		fpc.track(scrollView: mainViewContainer.searchViewController.tableView)
		fpc.layout = ychaPanelPhoneLayout()
		fpc.setAppearanceForPhone()
		
		fpc.addPanel(toParent: self)
	}
}


extension FloatingPanelController {
	func setAppearanceForPhone() {
		let appearance = SurfaceAppearance()
		if #available(iOS 13.0, *) {
			appearance.cornerCurve = .continuous
		}
		appearance.cornerRadius = 8.0
		appearance.backgroundColor = .clear
		surfaceView.appearance = appearance
	}
}

class ychaPanelPhoneLayout: FloatingPanelLayout {
	let position: FloatingPanelPosition  = .bottom
	var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] {
		return [
			.full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
			.half: FloatingPanelLayoutAnchor(fractionalInset: 0.7, edge: .bottom, referenceGuide: .safeArea),
			.tip: FloatingPanelLayoutAnchor(absoluteInset: 44.0, edge: .bottom, referenceGuide: .safeArea),
		]
	}
	let initialState: FloatingPanelState = .tip
	func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
		return 0.0
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
