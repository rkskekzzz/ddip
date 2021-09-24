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
    
    let mapView = MKMapView()
    
    @ObservedObject var viewModel: MapViewModel
    
    @EnvironmentObject var centerModel: MapCenterModel
    
    func makeUIView(context: Context) -> UIViewType {
        mapView.delegate = context.coordinator
        let coordinate = CLLocationCoordinate2D(
            latitude: 37.529510664039876,
            longitude: 127.02840863820876
        )
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
//        mapView.removeAnnotation(<#T##annotation: MKAnnotation##MKAnnotation#>)
//        mapView.addAnnotations(viewModel.annotations)
        mapView.center(to: centerModel.mapCenter.coordinate, zoomLevel: centerModel.mapCenter.zoomLevel)
//        mapView.center(to: self.viewModel.selectedPin.coordinate, zoomLevel: "current")
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

extension MapView {
    class Coordinator: NSObject, MKMapViewDelegate, UIGestureRecognizerDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        // 여기서부터 MKMapViewDelegate 함수 정의
        func mapView(_: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped _: UIControl) {
            guard let annotationPin = view.annotation as? AnnotationPin else { return }
            
            let driving = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            annotationPin.mapItem?.openInMaps(launchOptions: driving)
        }
        func mapView(_ : MKMapView, didSelect view: MKAnnotationView) {
            guard let annotationPin = view.annotation as? AnnotationPin else { return }
//            releaseFocusedView()
//            focusedView = view
//            selectedPin = annotationPin
            view.image = annotationPin.selectImage
            parent.mapView.center(to: annotationPin.coordinate, zoomLevel: "current")
        }
    }
}

// MARK: - MKMapView

extension MKMapView {
    func center(to location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: camera.centerCoordinateDistance, longitudinalMeters: camera.centerCoordinateDistance)
        setRegion(coordinateRegion, animated: true)
    }
    
    func center(to location: CLLocationCoordinate2D, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: camera.centerCoordinateDistance, longitudinalMeters: camera.centerCoordinateDistance)
        setRegion(coordinateRegion, animated: true)
    }
    
    func center(to location: CLLocation, zoomLevel: String) {
        switch zoomLevel {
        case "current":
            setCenter(location.coordinate, animated: true)
            return
        default:
            center(to: location)
        }
    }
    
    func center(to location: CLLocationCoordinate2D, zoomLevel: String) {
        switch zoomLevel {
        case "current":
            setCenter(location, animated: true)
            return
        default:
            center(to: location)
        }
    }
    
    func visibleAnnotations() -> [MKAnnotation] { return annotations(in: visibleMapRect).map { obj -> MKAnnotation in obj as! MKAnnotation } }
}


// struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
// }

