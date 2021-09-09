//
//  MeetingPanelDelegate.swift
//  ProjectDDIP
//
//  Created by 차영훈 on 2021/08/29.
//

import UIKit
import FloatingPanel

class MeetingPanelDelegate: NSObject, FloatingPanelControllerDelegate, UIGestureRecognizerDelegate {
	unowned let owner: MainViewController

	init(owner: MainViewController) {
		self.owner = owner
	}

	func floatingPanel(_ fpc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
		let appearance = fpc.surfaceView.appearance

		if #available(iOS 13.0, *) {
			appearance.cornerCurve = .continuous
		}
		appearance.borderWidth = 0.0
		appearance.borderColor = nil
		appearance.cornerRadius = 8.0
		appearance.backgroundColor = .clear
		fpc.surfaceView.appearance = appearance
		
		return MeetingPanelLayout()
	}

	func floatingPanelDidMove(_ fpc: FloatingPanelController) {
		let loc = fpc.surfaceLocation
		let minY = fpc.surfaceLocation(for: .half).y
		fpc.surfaceLocation = CGPoint(x: loc.x, y: max(loc.y, minY))
	}
	
	func floatingPanelWillRemove(_ fpc: FloatingPanelController) {
		owner.mainViewContainer.searchPanelController.show(animated: true)
		owner.mainViewContainer.mapViewController.deSelectAnnotation()
	}
}

