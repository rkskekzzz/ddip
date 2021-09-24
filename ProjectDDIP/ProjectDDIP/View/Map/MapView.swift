//
//  UIMap.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/18.
//

import SwiftUI
import MapKit

//protocol MapViewControllerDelegate {
////    func didUpdateMapVCAnnotation(_ mapViewController: MapViewController, annotationObject: AnnotationObject)
//    func didUpdateMapVCAnnotation(annotationPin: AnnotationPin)
////    func didUpdateMapVCAnnotationFail(error: Error)
//}

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    let data = TEST_CORE_DATA()
    let mapView = MKMapView()
    
    func makeUIView(context: Context) -> UIViewType {
        mapView.delegate = context.coordinator
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let coordinate = CLLocationCoordinate2D(latitude: 37.529510664039876, longitude: 127.02840863820876)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    
}

extension MapView {
//    class Coordinator: NSObject, MKMapViewDelegate, UIGestureRecognizerDelegate, MapViewControllerDelegate {
    class Coordinator: NSObject, MKMapViewDelegate, UIGestureRecognizerDelegate {
        
        var parent: MapView
        
        private var gesturePin = AnnotationPin(title: nil, locationName: nil, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        private var focusedView: MKAnnotationView?
        private var selectedPin: AnnotationPin?
        private var annotations: [AnnotationPin] = []
        
        
        init(_ parent: MapView) {
            self.parent = parent
            super.init()
            self.UIGestureInit()
            parent.data.AddDdip_TEST(id: 13, title: "hello", placeName: "hi", la: 37.519139425842084, lo: 126.99917786897805)
            self.setAnnotation()
        }

        func setAnnotation() {
            let coreData: [Ddip] = CoreDataManager.shared.fromCoreData()
            guard !coreData.isEmpty else { return }
            
            annotations.removeAll()
            for item in coreData {
                annotations.append(AnnotationPin(item: item))
            }
            parent.mapView.addAnnotations(annotations)
        }

//        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
//            print(mapView.centerCoordinate)
//        }
//
//        // MapViewControllerDelegate 함수 정의
//        func didUpdateMapVCAnnotation(annotationPin: AnnotationPin) {
//        }
        
        // 여기서부터 MKMapViewDelegate 함수 정의
        func mapView(_: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped _: UIControl) {
            guard let annotationPin = view.annotation as? AnnotationPin else { return }

            let driving = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            annotationPin.mapItem?.openInMaps(launchOptions: driving)
        }
        func mapView(_ : MKMapView, didSelect view: MKAnnotationView) {
            guard let annotationPin = view.annotation as? AnnotationPin else { return }
            releaseFocusedView()
            focusedView = view
            selectedPin = annotationPin
            view.image = annotationPin.selectImage
            parent.mapView.center(to: annotationPin.coordinate, zoomLevel: "current")
//            parent.mapView.delegate?.didUpdateMapVCAnnotation(annotationObject: annotationObject)
        }
        
//        func getSelectedAnnotationPin() -> AnnotationPin? {
//            return self.selectedPin
//        }
        func releaseFocusedView() {
            focusedView?.image = selectedPin?.deselectImage
        }
        
        func center(to location: CLLocation, radius: Double) {
            center(to: location)
            let span = MKCoordinateSpan(latitudeDelta: radius / 111320, longitudeDelta: radius / 111320)
            let mapCoordinate = MKCoordinateRegion(center: location.coordinate, span: span)
            parent.mapView.setRegion(mapCoordinate, animated: true)
        }
        func center(to location: CLLocation) {
            parent.mapView.center(to: location)
        }
        func center(to location: CLLocationCoordinate2D) {
            parent.mapView.center(to: location)
        }
        func center(to location: CLLocation, zoomLevel: String) {
            parent.mapView.center(to: location, zoomLevel: zoomLevel)
        }
        func center(to location: CLLocationCoordinate2D, zoomLevel: String) {
            parent.mapView.center(to: location, zoomLevel: zoomLevel)
        }
        
        func removeAnnotation(pin: AnnotationPin) {
            parent.mapView.removeAnnotation(pin)
        }
        func addAnnotation(pin: AnnotationPin) {
            parent.mapView.addAnnotation(pin)
        }
        func removeAnnotations(pinArray: [AnnotationPin]) {
            parent.mapView.removeAnnotations(pinArray)
        }
        func addAnnotations(pinArray: [AnnotationPin]) {
            parent.mapView.addAnnotations(pinArray)
        }
        func resetAnnotation(pin: AnnotationPin) {
            removeAnnotation(pin: pin)
            addAnnotation(pin: pin)
        }
        
        func setCamera(zoom maxDistance: Double) { parent.mapView.setCameraZoomRange(MKMapView.CameraZoomRange(maxCenterCoordinateDistance: maxDistance), animated: true)
        }
        func setCamera(boundary region: MKCoordinateRegion) { parent.mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        }

        func convert(toRegion center: CLLocation, latitudinalMeters: Double, longitudinalMeters: Double) -> MKCoordinateRegion {
            return MKCoordinateRegion(center: center.coordinate, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters)
        }
        func convert(toRegion center: CLLocationCoordinate2D, latitudinalMeters: Double, longitudinalMeters: Double) -> MKCoordinateRegion {
            return MKCoordinateRegion(center: center, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters)
        }

        
        
        func UIGestureInit() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(gestureRecognizer:)))
            parent.mapView.addGestureRecognizer(tapGesture)
        }
        
        @objc func handleTapGesture(gestureRecognizer: UITapGestureRecognizer) {
            let hitTarget = parent.mapView.hitTest(gestureRecognizer.location(in: parent.mapView), with: nil) as? AnnotationView
            
            if !parent.mapView.selectedAnnotations.isEmpty {
                if hitTarget == nil {
                    releaseFocusedView()
                    focusedView = nil
                    selectedPin = nil
                    
                    //아래는, 비활성 되었을때 외부에서 할 일이 있으면, 그걸 처리하는 내용을 override할수 있게 정의한 공간이므로
                    //스테이트머신을 이용하게 되면, 스테이트머신을 업데이트 하는 내용이 들어가고, 아래 내용은 삭제하는편이 좋습니다.
                    //annotationDeselectBehaviourDefines()
                }
                return
            }
            
            if hitTarget != nil { return }

            if gestureRecognizer.state == UIGestureRecognizer.State.ended {
                
                let locationCoordinate = parent.mapView.convert(gestureRecognizer.location(in: parent.mapView), toCoordinateFrom: parent.mapView)
                gesturePin.setAttributes("title", "location name", locationCoordinate)
                resetAnnotation(pin: gesturePin)
                print("Tapped at Latitiude: \(locationCoordinate.latitude), Longitude: \(locationCoordinate.longitude)")
            }
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

