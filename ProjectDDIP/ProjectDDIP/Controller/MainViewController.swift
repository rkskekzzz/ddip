//
//  ViewController.swift
//  ProjectDDIP
//
//  Created by su on 2021/08/23.
//

import UIKit
import FloatingPanel

class MainViewController: UIViewController {
	
    lazy var mainViewContainer = MainViewContainer(storyboard: storyboard)
		
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.addChild(mainViewContainer.mapViewController)
		self.view.addSubview(mainViewContainer.mapViewController.view)
		
		mainViewContainer.searchViewFpc.contentMode = .fitToBounds
		mainViewContainer.searchViewFpc.delegate = mainViewContainer.searchViewFpcDelegate
		mainViewContainer.searchViewFpc.set(contentViewController: mainViewContainer.searchViewController)
//		fpc.track(scrollView: searchVC.tableView)
		
		mainViewContainer.searchViewFpc.addPanel(toParent: self, animated: true)
		mainViewContainer.searchViewFpc.setAppearanceForPhone()
		mainViewContainer.searchViewFpc.move(to: .tip, animated: true)
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
