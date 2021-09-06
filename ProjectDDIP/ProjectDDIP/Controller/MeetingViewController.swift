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
	
    var createFloatingView: () -> Void = {}
	var removeFloatingView: () -> Void = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let height: CGFloat = 50
        let weight: CGFloat = 100
        
        let button = UIButton(frame: CGRect.init(x: (self.view.frame.size.width - weight) / 2,
                                                 y: (self.view.frame.size.height - height) / 4,
                                                 width: weight,
                                                 height: height))
        button.backgroundColor = .green
        button.setTitle("Test Button", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
		removeFloatingView()
    }
    
}

extension MeetingViewController: MapViewControllerDelegate {
    func didUpdateMapVCAnnotation(annotationObject: AnnotationObject) {
        DispatchQueue.main.async {
            self.label.text = "\(annotationObject.title!)\n \(annotationObject.locationName!)"
            self.createFloatingView()
        }
    }
}
