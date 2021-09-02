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
	var panelUp: () -> Void = {}
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
