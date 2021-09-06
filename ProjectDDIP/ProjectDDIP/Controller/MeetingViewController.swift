//
//  MeetingViewController.swift
//  ProjectDDIP
//
//  Created by 차영훈 on 2021/08/29.
//

import UIKit
import MapKit

class MeetingViewController: UIViewController {
	
	@IBOutlet weak var label: UILabel!
    weak var button: UIButton!
	var panelUp: () -> Void = {}
    
    override func viewDidLoad() {
      super.viewDidLoad()

      let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
      button.backgroundColor = .green
      button.setTitle("Test Button", for: .normal)
      button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

      self.view.addSubview(button)
    }

    @objc func buttonAction(sender: UIButton!) {
      print("Button tapped")
    }
    
}

extension MeetingViewController: MapViewControllerDelegate {
	func didUpdateMapVCAnnotation(annotationObject: AnnotationObject) {
		DispatchQueue.main.async {
			self.label.text = "\(annotationObject.title!)\n \(annotationObject.locationName!)"
			self.panelUp()

//			print(annotationObject.locationName as Any)
//			print(annotationObject.coordinate.latitude)
//			print(annotationObject.coordinate.longitude)
//			print(annotationObject.discipline as Any)
		}
	}
}
