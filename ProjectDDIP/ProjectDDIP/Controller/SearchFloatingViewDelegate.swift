//
//  SearchViewPanelDelegate.swift
//  ProjectDDIP
//
//  Created by 차영훈 on 2021/08/24.
//

import UIKit
import FloatingPanel

class SearchFloatingViewDelegate: NSObject, FloatingPanelControllerDelegate, UIGestureRecognizerDelegate {
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
		
		return SearchFloatingViewLayout()
	}

	func floatingPanelDidMove(_ vc: FloatingPanelController) {
		let loc = vc.surfaceLocation

		if vc.isAttracting == false {
			let minY = vc.surfaceLocation(for: .full).y - 6.0
			let maxY = vc.surfaceLocation(for: .tip).y + 6.0
			vc.surfaceLocation = CGPoint(x: loc.x, y: min(max(loc.y, minY), maxY))
		}

		let tipY = vc.surfaceLocation(for: .tip).y
		if loc.y > tipY - 44.0 {
			let progress = max(0.0, min((tipY  - loc.y) / 44.0, 1.0))
			owner.mainViewContainer.searchViewController.tableView.alpha = progress
		} else {
			owner.mainViewContainer.searchViewController.tableView.alpha = 1.0
		}
	}
}

