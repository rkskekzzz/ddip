//
//  MainViewController.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/21.
//

import Foundation
import UIKit
import SwiftUI

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBSegueAction func addSwiftUIVuew(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: UIMapView(searchText: "", searchResult: [], test: 0))
    }
}
