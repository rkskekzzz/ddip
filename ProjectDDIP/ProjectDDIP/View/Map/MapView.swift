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

    @ObservedObject var mapViewModel: MapViewModel

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
//        mapView.center(to: centerModel.mapCenter.coordinate, zoomLevel: centerModel.mapCenter.zoomLevel)
//        mapView.center(to: self.viewModel.selectedPin.coordinate, zoomLevel: "current")
//        mapView.center(to: )
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
            super.init()
            self.UIGestureInit()

//            TEST_CORE_DATA.shared.AddDdip_TEST(id: UUID().uuidString, title: "one", placeName: "one", la: 37.52628887090283, lo: 127.0293461382089)

            self.setAnnotation()
        }

        func setAnnotation() {
            let coreData: [Ddip] = CoreDataManager.shared.fromCoreData()
            guard !coreData.isEmpty else { return }

            parent.mapView.removeAnnotations(parent.mapView.annotations)
            for item in coreData {
                parent.mapView.addAnnotation(DdipPinModel(item: item))
            }
        }
        
        func UIGestureInit() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(gestureRecognizer:)))
            parent.mapView.addGestureRecognizer(tapGesture)
        }
        
        @objc func handleTapGesture(gestureRecognizer: UITapGestureRecognizer) {
            guard parent.mapView.selectedAnnotations.isEmpty else { return }
            let coordinate = parent.mapView.convert(gestureRecognizer.location(in: parent.mapView), toCoordinateFrom: parent.mapView)
            for item in parent.mapView.visibleAnnotations() {
                let view = parent.mapView.view(for: item)
                let hit = view?.hitTest(gestureRecognizer.location(in: view), with: nil)
                if hit != nil { return }
            }
            
            parent.mapViewModel.gesturePin.set(title: "custom", location: coordinate)
            parent.mapView.removeAnnotation(parent.mapViewModel.gesturePin)
            parent.mapView.addAnnotation(parent.mapViewModel.gesturePin)
//            print("Tapped at Latitiude: \(coordinate.latitude), Longitude: \(coordinate.longitude)")
        }
        
        // 여기서부터 MKMapViewDelegate 함수 정의
//        func mapView(_: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped _: UIControl) {
//            guard let annotationPin = view.annotation as? DdipPinModel else { return }
//
//            let driving = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
//            DdipPinModel.mapItem?.openInMaps(launchOptions: driving)
//        }
        func mapView(_ : MKMapView, didSelect view: MKAnnotationView) {
            guard let annotationPin = view.annotation as? DdipPinModel else { return }
//            releaseFocusedView()
//            focusedView = view
//            selectedPin = annotationPin
//            view.image = annotationPin.selectImage
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

