//
//  UIMap.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/18.
//

import SwiftUI
import MapKit

protocol MapViewControllerDelegate {
//    func didUpdateMapVCAnnotation(_ mapViewController: MapViewController, annotationObject: AnnotationObject)
    func didUpdateMapVCAnnotation(annotationPin: AnnotationPin)
//    func didUpdateMapVCAnnotationFail(error: Error)
}

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    let mapView = MKMapView()
    
    func makeUIView(context: Context) -> UIViewType {
        mapView.delegate = context.coordinator
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let coordinate = CLLocationCoordinate2D(latitude: -33.523065, longitude: 151.394551)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    
}

extension MapView {
    class Coordinator: NSObject, MKMapViewDelegate, UIGestureRecognizerDelegate, MapViewControllerDelegate {
        
        var parent: MapView
        
        private var gesturePin = AnnotationPin(title: nil, locationName: nil, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        private var selectedView: MKAnnotationView?
        private var selectedPin: AnnotationPin?
        private var annotations: [AnnotationPin] = []
        
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        

        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
        }
        
        // MapViewControllerDelegate 함수 정의
        func didUpdateMapVCAnnotation(annotationPin: AnnotationPin) {
        }
        
        // 여기서부터 MKMapViewDelegate 함수 정의
        func mapView(_: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped _: UIControl) {
            guard let annotationPin = view.annotation as? AnnotationPin else { return }

            let driving = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            annotationPin.mapItem?.openInMaps(launchOptions: driving)
        }
        
        func centerToLocation(_ location: CLLocation, _ radius: Double) {
            centerToLocation(location)
            let span = MKCoordinateSpan(latitudeDelta: radius / 111320, longitudeDelta: radius / 111320)
            let mapCoordinate = MKCoordinateRegion(center: location.coordinate, span: span)
            parent.mapView.setRegion(mapCoordinate, animated: true)
        }
        func centerToLocation(_ location: CLLocation) { parent.mapView.centerToLocation(location) }
        func centerToLocation(_ location: CLLocationCoordinate2D) { parent.mapView.centerToLocation(location) }
        func centerToLocation(_ location: CLLocation, _ zoomLevel: String) { parent.mapView.centerToLocation(location.coordinate, zoomLevel) }
        func centerToLocation(_ location: CLLocationCoordinate2D, _ zoomLevel: String) { parent.mapView.centerToLocation(location, zoomLevel) }
        func setCameraZoomMaxDistance(_ maxDistance: Double) { parent.mapView.setCameraZoomRange(MKMapView.CameraZoomRange(maxCenterCoordinateDistance: maxDistance), animated: true) }
        func setCameraBoundary(_ region: MKCoordinateRegion) { parent.mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true) }
        func convertToLocation2D(_ latitude: Double, _ longitude: Double) -> CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: latitude, longitude: longitude) }
        func convertToLocation(_ latitude: Double, _ longitude: Double) -> CLLocation { return CLLocation(latitude: latitude, longitude: longitude) }
        func convertToRegion(_ center: CLLocation, latitudinalMeters: Double, longitudinalMeters: Double) -> MKCoordinateRegion { return MKCoordinateRegion(center: center.coordinate, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters) }
        func convertToRegion(_ center: CLLocationCoordinate2D, latitudinalMeters: Double, longitudinalMeters: Double) -> MKCoordinateRegion { return MKCoordinateRegion(center: center, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters) }
        func removeAnnotation(_ object: AnnotationPin) { parent.mapView.removeAnnotation(object) }
        func addAnnotation(_ object: AnnotationPin) { parent.mapView.addAnnotation(object) }
        func removeAnnotations(_ objects: [AnnotationPin]) { parent.mapView.removeAnnotations(objects) }
        func addAnnotations(_ objects: [AnnotationPin]) { parent.mapView.addAnnotations(objects) }
        func replocateAnnotation(_ object: AnnotationPin) { removeAnnotation(object); addAnnotation(object) }
        func getSelectedAnnotationObject() -> AnnotationPin? { return self.selectedPin }
        func deselectAnnotation() { selectedView?.image = selectedPin?.deselectImage }

        func mapView(_ : MKMapView, didSelect view: MKAnnotationView) {
            guard let annotationObject = view.annotation as? AnnotationPin else { return }
            deselectAnnotation()
            selectedView = view
            selectedPin = annotationObject
            view.image = annotationObject.selectImage
            parent.mapView.centerToLocation(annotationObject.coordinate, "current")
//            parent.mapView.delegate?.didUpdateMapVCAnnotation(annotationObject: annotationObject)
            
        }
        

//        func UIGestureInit() {
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MapViewController.handleTapGesture(gestureRecognizer:)))
//            mapView.addGestureRecognizer(tapGesture)
//        }
//
//        @objc func handleTapGesture(gestureRecognizer: UITapGestureRecognizer) {
//            let hitObject = mapView.hitTest(gestureRecognizer.location(in: mapView), with: nil) as? AnnotationView
//
//            if mapView.selectedAnnotations.count > 0 {
//                if hitObject == nil {
//                    deSelectAnnotation()
//                    selectedView = nil
//                    selectedPin = nil
//                    annotationDeselectBehaviourDefines()
//                }
//                return
//            }
//            if hitObject != nil { return }
//
//            if gestureRecognizer.state == UIGestureRecognizer.State.ended {
//                let locationCoordinate = mapView.convert(gestureRecognizer.location(in: mapView), toCoordinateFrom: mapView)
//                gesturePin.resetAttributes("title", "location name", "discipline", locationCoordinate)
//                replocateAnnotation(gesturePin)
//                print("Tapped at Latitiude: \(locationCoordinate.latitude), Longitude: \(locationCoordinate.longitude)")
//            }
//        }
    }
}



extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius _: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: camera.centerCoordinateDistance, longitudinalMeters: camera.centerCoordinateDistance)
        setRegion(coordinateRegion, animated: true)
    }

    func centerToLocation(_ location: CLLocationCoordinate2D, regionRadius _: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: camera.centerCoordinateDistance, longitudinalMeters: camera.centerCoordinateDistance)
        setRegion(coordinateRegion, animated: true)
    }

    func centerToLocation(_ location: CLLocation, _ zoomLevel: String) {
        switch zoomLevel {
        case "current":
            setCenter(location.coordinate, animated: true)
            return
        default:
            centerToLocation(location)
        }
    }

    func centerToLocation(_ location: CLLocationCoordinate2D, _ zoomLevel: String) {
        switch zoomLevel {
        case "current":
            setCenter(location, animated: true)
            return
        default:
            centerToLocation(location)
        }
    }

//    func visibleAnnotations() -> [MKAnnotation] { return annotations(in: visibleMapRect).map { obj -> MKAnnotation in obj as! MKAnnotation } }
}



//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}

