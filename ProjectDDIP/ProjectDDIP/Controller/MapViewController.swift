//
//  MapViewController.swift
//  ProjectDDIP
//
//  Created by su on 2021/08/23.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    private var annotations: [AnnotationObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        allTest()
    }
    
    func centerToLocation(_ location: CLLocation) {
        mapView.centerToLocation(location)
    }

    func setCameraZoomMaxDistance(_ maxDistance: Double) {
        mapView.setCameraZoomRange(MKMapView.CameraZoomRange(maxCenterCoordinateDistance: maxDistance), animated: true)
    }

    func setCameraBoundary(_ region: MKCoordinateRegion) {
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
    }

    func convertToLocation(_ latitude: Double, _ longitude: Double) -> CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }

    func convertToRegion(_ center: CLLocation, latitudinalMeters: Double, longitudinalMeters: Double) -> MKCoordinateRegion {
        return MKCoordinateRegion(center: center.coordinate, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters)
    }

    func convertToRegion(_ center: CLLocationCoordinate2D, latitudinalMeters: Double, longitudinalMeters: Double) -> MKCoordinateRegion {
        return MKCoordinateRegion(center: center, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters)
    }

    func addAnnotation(_ object: AnnotationObject) {
        mapView.addAnnotation(object)
    }
    
    func addAnnotations(_ objects: [AnnotationObject]) {
        mapView.addAnnotations(objects)
    }

    private func loadInitialData() {
        guard
            let fileName = Bundle.main.url(forResource: "PublicArt", withExtension: "geojson"),
            let artworkData = try? Data(contentsOf: fileName)
        else { return }

        do {
            let features = try MKGeoJSONDecoder().decode(artworkData).compactMap { $0 as? MKGeoJSONFeature }
            let validWorks = features.compactMap(AnnotationObject.init)
            annotations.append(contentsOf: validWorks)
        } catch { print("Unexpected error: \(error).") }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotationObject = view.annotation as? AnnotationObject else { return }

        let driving = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        annotationObject.mapItem?.openInMaps(launchOptions: driving)
    }
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

extension MapViewController {
    
    func allTest() {
        
        print("call all test")
        print("call all test2")
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerToLocation(initialLocation)
        
        let oahuCenter = convertToLocation(21.4765, -157.9647)
        let region = convertToRegion(oahuCenter, latitudinalMeters: 50000, longitudinalMeters: 60000)
        setCameraBoundary(region)
        
        let distance: Double = 600000
        setCameraZoomMaxDistance(distance)
        mapView.register(AnnotationMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        loadInitialData()
        addAnnotations(annotations)
    }
}
