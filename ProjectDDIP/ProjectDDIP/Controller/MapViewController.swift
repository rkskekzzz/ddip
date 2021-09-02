//
//  MapViewController.swift
//  ProjectDDIP
//
//  Created by su on 2021/08/23.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    }
	
	private func initMap(_ initialLocation: CLLocation) {
		self.centerToLocation(initialLocation)
		
		let region = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: 50000, longitudinalMeters: 60000)
		setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
		
		let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
		setCameraZoomRange(zoomRange, animated: true)
	}
}
