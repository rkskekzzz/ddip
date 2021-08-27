//
//  SearchViewPanelDelegate.swift
//  ProjectDDIP
//
//  Created by 차영훈 on 2021/08/24.
//

import UIKit
import FloatingPanel

class SearchViewPanelDelegate: NSObject, FloatingPanelControllerDelegate, UIGestureRecognizerDelegate {
	unowned let owner: MainViewController

	init(owner: MainViewController) {
		self.owner = owner
	}

	func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
		let appearance = vc.surfaceView.appearance
		appearance.borderWidth = 0.0
		appearance.borderColor = nil
		vc.surfaceView.appearance = appearance
		return FloatingPanelBottomLayout()
	}

	func floatingPanelDidMove(_ vc: FloatingPanelController) {
		debugPrint("surfaceLocation: ", vc.surfaceLocation)
		debugPrint("NearbyState : ",vc.nearbyState)
	}

	func floatingPanelWillBeginDragging(_ vc: FloatingPanelController) {
	}

	func floatingPanelWillEndDragging(_ vc: FloatingPanelController, withVelocity velocity: CGPoint, targetState: UnsafeMutablePointer<FloatingPanelState>) {
		if targetState.pointee != .full {
		}
		if targetState.pointee == .tip {
			vc.contentMode = .static
		}
	}
	
	func floatingPanelDidEndAttracting(_ fpc: FloatingPanelController) {
		fpc.contentMode = .fitToBounds
	}
}

