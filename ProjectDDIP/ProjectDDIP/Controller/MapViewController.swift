//
//  MapViewController.swift
//  ProjectDDIP
//
//  Created by su on 2021/08/23.
//

import AVFoundation
import Foundation
import UIKit
import MapKit

protocol MapViewControllerDelegate {
//    func didUpdateMapVCAnnotation(_ mapViewController: MapViewController, annotationObject: AnnotationObject)
    func didUpdateMapVCAnnotation(annotationObject: AnnotationObject)
//    func didUpdateMapVCAnnotationFail(error: Error)
}

class MapViewController: UIViewController {
    var delegate: MapViewControllerDelegate?

    @IBOutlet weak var mapView: MKMapView!
    private var gesturePin = AnnotationObject(title: nil, locationName: nil, discipline: nil, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    private var annotations: [AnnotationObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.pointOfInterestFilter = .excludingAll
        UIGestureInit()

        allTest()
    }
    
    func centerToLocation(_ location: CLLocation, _ radius: Double) {
        centerToLocation(location)
        let span = MKCoordinateSpan(latitudeDelta: radius / 111320, longitudeDelta: radius / 111320)
        let mapCoordinate = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(mapCoordinate, animated: true)
    }
    func centerToLocation(_ location: CLLocation) { mapView.centerToLocation(location) }
    func centerToLocation(_ location: CLLocationCoordinate2D) { mapView.centerToLocation(location) }
    func setCameraZoomMaxDistance(_ maxDistance: Double) { mapView.setCameraZoomRange(MKMapView.CameraZoomRange(maxCenterCoordinateDistance: maxDistance), animated: true) }
    func setCameraBoundary(_ region: MKCoordinateRegion) { mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true) }
    func convertToLocation2D(_ latitude: Double, _ longitude: Double) -> CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: latitude, longitude: longitude) }
    func convertToLocation(_ latitude: Double, _ longitude: Double) -> CLLocation { return CLLocation(latitude: latitude, longitude: longitude) }
    func convertToRegion(_ center: CLLocation, latitudinalMeters: Double, longitudinalMeters: Double) -> MKCoordinateRegion { return MKCoordinateRegion(center: center.coordinate, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters) }
    func convertToRegion(_ center: CLLocationCoordinate2D, latitudinalMeters: Double, longitudinalMeters: Double) -> MKCoordinateRegion { return MKCoordinateRegion(center: center, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters) }
    func removeAnnotation(_ object: AnnotationObject) { mapView.removeAnnotation(object) }
    func addAnnotation(_ object: AnnotationObject) { mapView.addAnnotation(object) }
    func removeAnnotations(_ objects: [AnnotationObject]) { mapView.removeAnnotations(objects) }
    func addAnnotations(_ objects: [AnnotationObject]) { mapView.addAnnotations(objects) }
    func replocateAnnotation(_ object: AnnotationObject) { removeAnnotation(object); addAnnotation(object) }

    private func loadInitialData() {
        guard
            let fileName = Bundle.main.url(forResource: "Directions", withExtension: "geojson"),
            let artworkData = try? Data(contentsOf: fileName)
        else { return }

        do {
            let features = try MKGeoJSONDecoder().decode(artworkData).compactMap { $0 as? MKGeoJSONFeature }
            let validWorks = features.compactMap(AnnotationObject.init)
            annotations.append(contentsOf: validWorks)
        } catch { print("Unexpected error: \(error)") }
    }
}

extension MapViewController: UIGestureRecognizerDelegate {
    
    func UIGestureInit() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MapViewController.handleTapGesture(gestureRecognizer:)))
        mapView.addGestureRecognizer(tapGesture)
    }

    @objc func handleTapGesture(gestureRecognizer: UITapGestureRecognizer) {

        if mapView.selectedAnnotations.count > 0 { return }
        if mapView.hitTest(gestureRecognizer.location(in: mapView), with: nil)!.accessibilityElements == nil { return }
        // ...
        // If the UI policy has changed, more validators are needed.
        // This condition is created under the assumption that there is no button in the annotation.
        // ...
        
        if  gestureRecognizer.state == UIGestureRecognizer.State.ended {
            let locationCoordinate = mapView.convert(gestureRecognizer.location(in: mapView), toCoordinateFrom: mapView)
            self.gesturePin.resetAttributes("title", "location name", "discipline", locationCoordinate)
            replocateAnnotation(gesturePin)
            print("Tapped at Latitiude: \(locationCoordinate.latitude), Longitude: \(locationCoordinate.longitude)")
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotationObject = view.annotation as? AnnotationObject else { return }

        let driving = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        annotationObject.mapItem?.openInMaps(launchOptions: driving)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotationObject = view.annotation as? AnnotationObject else { return }
        delegate?.didUpdateMapVCAnnotation(annotationObject: annotationObject)
    }
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }

    func centerToLocation(_ location: CLLocationCoordinate2D, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
    
    func visibleAnnotations() -> [MKAnnotation] {
        return self.annotations(in: self.visibleMapRect).map { obj -> MKAnnotation in return obj as! MKAnnotation }
    }
}

extension MapViewController {
    
    
    func allTest() {
        
        let startLocation = convertToLocation(37.529510664039876, 127.02840863820876)
        let distance: Double = 60000
        let span = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        let mapCoordinate = MKCoordinateRegion(center: startLocation.coordinate, span: span)
        
        centerToLocation(startLocation)
        mapView.setRegion(mapCoordinate, animated: true)
        setCameraZoomMaxDistance(distance)

        mapView.register(AnnotationMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        loadInitialData()
        addAnnotations(annotations)
//        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
//        centerToLocation(initialLocation)
//
////        let oahuCenter = convertToLocation(21.4765, -157.9647)
////        let region = convertToRegion(oahuCenter, latitudinalMeters: 50000, longitudinalMeters: 60000)
////        setCameraBoundary(region)
//
//        let distance: Double = 600000
//        setCameraZoomMaxDistance(distance)
//        mapView.register(AnnotationMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
//        loadInitialData()
//        addAnnotations(annotations)
        
//        print(mapView.overlays.count)
//        for obj in mapView.overlays {
//            print(obj.title)
//            print(obj.description)
//        }
//        print("-------------")
//        print(mapView.pointOfInterestFilter)
//        print("-------------")
//        print(mapView.interactions.count)
//        for obj in mapView.interactions {
//            print(obj.description)
//        }
//
//        print("-------------")
//        print(mapView.activityItemsConfiguration)
//        print(mapView.constraints.count)
//        mapView.removeConstraints(mapView.constraints)
    }
}
