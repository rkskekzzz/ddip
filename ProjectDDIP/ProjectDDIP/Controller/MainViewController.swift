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
	
    lazy var mainViewContainer = MainViewContainer(storyboard: storyboard)
	
	lazy var fpc = FloatingPanelController()
	lazy var fpcDelegate: PanelDelegate = SearchViewPanelDelegate(owner: self)
		
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.addChild(mainViewContainer.mapViewController)
		self.view.addSubview(mainViewContainer.mapViewController.view)

		fpc.delegate = fpcDelegate
		fpc.set(contentViewController: mainViewContainer.searchViewController)
		fpc.layout = ychaPanelPhoneLayout()
		fpc.setAppearanceForPhone()
		
		// Track a scroll view(or the siblings) in the content view controller.
//		fpc.track(scrollView: contentVC.tableView)

		// Add and show the views managed by the `FloatingPanelController` object to self.view.
		fpc.addPanel(toParent: self)
//
////		 Add the floating panel view to the controller's view on top of other views.
//		self.view.addSubview(fpc.view)
//
//		// REQUIRED. It makes the floating panel view have the same size as the controller's view.
//		fpc.view.frame = self.view.bounds
//
//		// In addition, Auto Layout constraints are highly recommended.
//		// Constraint the fpc.view to all four edges of your controller's view.
//		// It makes the layout more robust on trait collection change.
//		fpc.view.translatesAutoresizingMaskIntoConstraints = false
//		NSLayoutConstraint.activate([
//		  fpc.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0),
//		  fpc.view.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0.0),
//		  fpc.view.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0.0),
//		  fpc.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0),
//		])
//
//		// Add the floating panel controller to the controller hierarchy.
//		self.addChild(fpc)
//
//		// Show the floating panel at the initial position defined in your `FloatingPanelLayout` object.
//		fpc.show(animated: true) {
//			// Inform the floating panel controller that the transition to the controller hierarchy has completed.
//			self.fpc.didMove(toParent: self)
//		}
		
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
//			.full: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea),
//			.half: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea),
//			.tip: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea),
//
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
