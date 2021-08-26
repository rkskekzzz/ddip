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
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.getAnnotationDetail), name: NSNotification.Name(rawValue:"getAnnotationData"), object:nil)
    }

    @objc func getAnnotationDetail(_ notification: Notification) {
        // update instance here
        let data = notification.userInfo!
        
        DispatchQueue.main.async {
            // update view here
            
            // test start
            print("--> getAnnotationDetail start <--")
            print(data["name"] as! String)
            print(data["loc"] as! Double)
            print(data["lloc"] as! Double)
            print(data["description"] as! String)
            print("==> getAnnotationDetail end <==")
            // test end
        }
    }
}

//extension MainViewContainer {
//
//    func getAnnotationDetail(_ notification: Notification) {
//        // update instance here
//        DispatchQueue.main.async {
//            // update view here
//        }
//    }
//}
