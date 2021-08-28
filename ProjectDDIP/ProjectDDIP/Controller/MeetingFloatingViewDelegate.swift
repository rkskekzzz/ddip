//
//  MeetingFloatingViewDelegate.swift
//  ProjectDDIP
//
//  Created by 차영훈 on 2021/08/29.
//

import UIKit
import FloatingPanel

class MeetingFloatingViewDelegate: NSObject, FloatingPanelControllerDelegate, UIGestureRecognizerDelegate {
	unowned let owner: MainViewController

	init(owner: MainViewController) {
		self.owner = owner
	}

	func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
		let appearance = vc.surfaceView.appearance

		if #available(iOS 13.0, *) {
			appearance.cornerCurve = .continuous
		}
		appearance.borderWidth = 0.0
		appearance.borderColor = nil
		appearance.cornerRadius = 8.0
		appearance.backgroundColor = .clear
		vc.surfaceView.appearance = appearance
		
		return MeetingFloatingViewLayout()
	}
	
	func floatingPanelDidMove(_ vc: FloatingPanelController) {
		let loc = vc.surfaceLocation
		let maxY = vc.surfaceLocation(for: .half).y
		vc.surfaceLocation = CGPoint(x: loc.x, y: min(loc.y, maxY))
	}
	
	func floatingPanelWillEndDragging(_ vc: FloatingPanelController, withVelocity velocity: CGPoint, targetState: UnsafeMutablePointer<FloatingPanelState>) {
		if targetState.pointee == .tip {
			vc.contentMode = .static
		}
	}
	
	func floatingPanelDidEndAttracting(_ fpc: FloatingPanelController) {
		fpc.contentMode = .fitToBounds
	}
}

