//
//  UIMap.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/18.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    func makeUIView(context: Context) -> UIViewType {
        let mapView = MKMapView()
        
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
    
    class Coordinator: NSObject, MKMapViewDelegate, UIGestureRecognizerDelegate {
        var mapView: MapView
        
        private var gesturePin = AnnotationObject(title: nil, locationName: nil, discipline: nil, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        private var selectedView: MKAnnotationView?
        private var selectedPin: AnnotationObject?
        private var annotations: [AnnotationObject] = []
        
        init(_ mapView: MapView) {
            self.mapView = mapView
        }

        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
        }
        
        func mapView(_: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped _: UIControl) {
            guard let annotationObject = view.annotation as? AnnotationObject else { return }

            let driving = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            annotationObject.mapItem?.openInMaps(launchOptions: driving)
        }

//        func mapView(_: MKMapView, didSelect view: MKAnnotationView) {
//            guard let annotationObject = view.annotation as? AnnotationObject else { return }
//            deSelectAnnotation()
//            selectedView = view
//            selectedPin = annotationObject
//            view.image = annotationObject.focusImage
//            centerToLocation(annotationObject.coordinate, "current")
//            delegate?.didUpdateMapVCAnnotation(annotationObject: annotationObject)
//        }
//
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

private extension MKMapView {
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

    func visibleAnnotations() -> [MKAnnotation] { return annotations(in: visibleMapRect).map { obj -> MKAnnotation in obj as! MKAnnotation } }
}



struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

