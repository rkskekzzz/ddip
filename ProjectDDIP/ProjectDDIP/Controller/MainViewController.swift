//
//  ViewController.swift
//  ProjectDDIP
//
//  Created by su on 2021/08/23.
//

import UIKit

class MainViewController: UIViewController {

    lazy var mainViewContainer = MainViewContainer(storyboard: storyboard)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainViewContainer.mapViewController.view)
        view.addSubview(mainViewContainer.searchViewController.view)
    }
}

