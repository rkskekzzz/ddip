//
//  SearchPanelDelegate.swift
//  ProjectDDIP
//
//  Created by 차영훈 on 2021/08/24.
//

import UIKit
import FloatingPanel

class SearchPanelDelegate: NSObject, FloatingPanelControllerDelegate, UIGestureRecognizerDelegate {
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
		
		return SearchPanelLayout()
	}
	
	func floatingPanelDidMove(_ fpc: FloatingPanelController) {
		let loc = fpc.surfaceLocation
		
		if fpc.isAttracting == false {
			let minY = fpc.surfaceLocation(for: .full).y - 6.0
			let maxY = fpc.surfaceLocation(for: .tip).y + 6.0
			if loc.y < maxY + 100 {
				fpc.surfaceLocation = CGPoint(x: loc.x, y: min(max(loc.y, minY), maxY))
			}
		}

		let tipY = fpc.surfaceLocation(for: .tip).y
		if loc.y > tipY - 44.0 {
			let progress = max(0.0, min((tipY  - loc.y) / 44.0, 1.0))
			owner.mainViewContainer.searchViewController.tableView.alpha = progress
		} else {
			owner.mainViewContainer.searchViewController.tableView.alpha = 1.0
		}
	}
	
	func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
		if fpc.state == .tip {
			owner.mainViewContainer.searchViewController.searchBarSetDefault()
		}
	}
}

