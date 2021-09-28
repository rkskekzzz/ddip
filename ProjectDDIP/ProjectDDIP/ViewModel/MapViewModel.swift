//
//  MapViewModel.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/24.
//

import SwiftUI
import MapKit
import Combine

class MapItemModel: ObservableObject {
    @Published var mapItem: MKMapItem?
}

final class MapViewModel: ObservableObject {
    
    @Published var focusedView: MKAnnotationView? = nil // selectedPinView
    @Published var selectedPin: AnnotationPin? = nil // selectedPin
    @Published var annotations: [AnnotationPin] = [] // Meeting
    
    private let gesturePin = AnnotationPin(title: nil, locationName: nil, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0)) // PinTemplate
    
    init() {
//        setAnnotation()
//        UIGestureInit()
    }
    
    func center(to location: CLLocation, zoomLevel: String) {
        
    }
//
//    func setAnnotation() {
//        let coreData: [Ddip] = CoreDataManager.shared.fromCoreData()
//        guard !coreData.isEmpty else { return }
//
//        annotations.removeAll()
//        for item in coreData {
//            annotations.append(AnnotationPin(item: item))
//        }
//    }
//
//    func releaseFocusedView() {
//        focusedView?.image = selectedPin?.deselectImage
//    }
//
//    func removeAnnotation(pin: AnnotationPin) {
//        parent.mapView.removeAnnotation(pin)
//    }
//    func addAnnotation(pin: AnnotationPin) {
//        parent.mapView.addAnnotation(pin)
//    }
//    func removeAnnotations(pinArray: [AnnotationPin]) {
//        parent.mapView.removeAnnotations(pinArray)
//    }
//    func addAnnotations(pinArray: [AnnotationPin]) {
//        parent.mapView.addAnnotations(pinArray)
//    }
//    func resetAnnotation(pin: AnnotationPin) {
//        removeAnnotation(pin: pin)
//        addAnnotation(pin: pin)
//    }
//
//    func setCamera(zoom maxDistance: Double) { parent.mapView.setCameraZoomRange(MKMapView.CameraZoomRange(maxCenterCoordinateDistance: maxDistance), animated: true)
//    }
//    func setCamera(boundary region: MKCoordinateRegion) { parent.mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
//    }
//
//    func convert(toRegion center: CLLocation, latitudinalMeters: Double, longitudinalMeters: Double) -> MKCoordinateRegion {
//        return MKCoordinateRegion(center: center.coordinate, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters)
//    }
//    func convert(toRegion center: CLLocationCoordinate2D, latitudinalMeters: Double, longitudinalMeters: Double) -> MKCoordinateRegion {
//        return MKCoordinateRegion(center: center, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters)
//    }
//
//
//
//    func UIGestureInit() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(gestureRecognizer:)))
//        parent.mapView.addGestureRecognizer(tapGesture)
//    }
//
//    @objc func handleTapGesture(gestureRecognizer: UITapGestureRecognizer) {
//        let hitTarget = parent.mapView.hitTest(gestureRecognizer.location(in: parent.mapView), with: nil) as? AnnotationView
//
//        if !parent.mapView.selectedAnnotations.isEmpty {
//            if hitTarget == nil {
//                releaseFocusedView()
//                focusedView = nil
//                selectedPin = nil
//
//                //아래는, 비활성 되었을때 외부에서 할 일이 있으면, 그걸 처리하는 내용을 override할수 있게 정의한 공간이므로
//                //스테이트머신을 이용하게 되면, 스테이트머신을 업데이트 하는 내용이 들어가고, 아래 내용은 삭제하는편이 좋습니다.
//                //annotationDeselectBehaviourDefines()
//            }
//            return
//        }
//
//        if hitTarget != nil { return }
//
//        if gestureRecognizer.state == UIGestureRecognizer.State.ended {
//
//            let locationCoordinate = parent.mapView.convert(gestureRecognizer.location(in: parent.mapView), toCoordinateFrom: parent.mapView)
//            gesturePin.setAttributes("title", "location name", locationCoordinate)
//            resetAnnotation(pin: gesturePin)
//            print("Tapped at Latitiude: \(locationCoordinate.latitude), Longitude: \(locationCoordinate.longitude)")
//        }
//    }
}
