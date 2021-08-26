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
        mainViewContainer.mapViewController?.delegate = self
        view.addSubview(mainViewContainer.mapViewController!.view)
    }
}

extension MainViewController: MapViewControllerDelegate {
    func didUpdateMapVCAnnotation(annotationObject: AnnotationObject) {
        DispatchQueue.main.async {
            print(annotationObject.locationName as Any)
            print(annotationObject.coordinate.latitude)
            print(annotationObject.coordinate.longitude)
            print(annotationObject.discipline as Any)
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

