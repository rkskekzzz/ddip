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
//		let loc = vc.surfaceLocation
//
//		if vc.isAttracting == false {
//			let minY = vc.surfaceLocation(for: .full).y - 6.0
//			let maxY = vc.surfaceLocation(for: .tip).y + 6.0
//			vc.surfaceLocation = CGPoint(x: loc.x, y: min(max(loc.y, minY), maxY))
//		}
//
//		let tipY = vc.surfaceLocation(for: .tip).y
//		if loc.y > tipY - 44.0 {
//			let progress = max(0.0, min((tipY  - loc.y) / 44.0, 1.0))
//			owner.searchVC.tableView.alpha = progress
//		} else {
//			owner.searchVC.tableView.alpha = 1.0
//		}
		debugPrint("NearbyState : ",vc.nearbyState)
	}

	func floatingPanelWillBeginDragging(_ vc: FloatingPanelController) {
//		if vc.state == .full {
//			owner.searchVC.searchBar.showsCancelButton = false
//			owner.searchVC.searchBar.resignFirstResponder()
//		}
	}

	func floatingPanelWillEndDragging(_ vc: FloatingPanelController, withVelocity velocity: CGPoint, targetState: UnsafeMutablePointer<FloatingPanelState>) {
		if targetState.pointee != .full {
//			owner.searchVC.hideHeader(animated: true)
		}
		if targetState.pointee == .tip {
			vc.contentMode = .static
		}
	}

	func floatingPanelDidEndAttracting(_ fpc: FloatingPanelController) {
		fpc.contentMode = .fitToBounds
	}
}


