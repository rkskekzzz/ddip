//
//  MapViewController.swift
//  ProjectDDIP
//
//  Created by su on 2021/08/23.
//

import CoreData
import MapKit
import UIKit

protocol MapViewControllerDelegate {
//    func didUpdateMapVCAnnotation(_ mapViewController: MapViewController, annotationPin: AnnotationPin)
    func didUpdateMapVCAnnotation(annotationPin: AnnotationPin)
//    func didUpdateMapVCAnnotationFail(error: Error)
}

class MapViewController: UIViewController {
    var delegate: MapViewControllerDelegate?
    let entity: ENTITY = ENTITY()
    
    @IBOutlet var mapView: MKMapView!
    private var gesturePin = AnnotationPin(title: nil, locationName: nil, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    private var selectedView: MKAnnotationView?
    private var selectedPin: AnnotationPin?
    private var annotations: [AnnotationPin] = []

    var annotationDeselectBehaviourDefines: () -> Void = {}

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.pointOfInterestFilter = .excludingAll
        UIGestureInit()
        displayAnnotations()
    }

    func center(toLocation location: CLLocation, _ radius: Double) {
        center(toLocation: location)
        let span = MKCoordinateSpan(latitudeDelta: radius / 111_320, longitudeDelta: radius / 111_320)
        let mapCoordinate = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(mapCoordinate, animated: true)
    }
}

extension MapViewController: UIGestureRecognizerDelegate {
    func UIGestureInit() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MapViewController.handleTapGesture(gestureRecognizer:)))
        mapView.addGestureRecognizer(tapGesture)
    }

    @objc func handleTapGesture(gestureRecognizer: UITapGestureRecognizer) {
        let hitObject = mapView.hitTest(gestureRecognizer.location(in: mapView), with: nil) as? AnnotationView

        if mapView.selectedAnnotations.count > 0 {
            if hitObject == nil {
                deSelectAnnotation()
                selectedView = nil
                selectedPin = nil
                annotationDeselectBehaviourDefines()
            }
            return
        }
        if hitObject != nil { return }

        if gestureRecognizer.state == UIGestureRecognizer.State.ended {
            let locationCoordinate = mapView.convert(gestureRecognizer.location(in: mapView), toCoordinateFrom: mapView)
            gesturePin.setAttributes("title", "location name", locationCoordinate)
            replocateAnnotation(gesturePin)
            print("Tapped at Latitiude: \(locationCoordinate.latitude), Longitude: \(locationCoordinate.longitude)")
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped _: UIControl) {
        guard let annotationPin = view.annotation as? AnnotationPin else { return }

        let driving = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        annotationPin.mapItem?.openInMaps(launchOptions: driving)
    }

    func mapView(_: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotationPin = view.annotation as? AnnotationPin else { return }
        deSelectAnnotation()
        selectedView = view
        selectedPin = annotationPin
        view.image = annotationPin.selectImage
        center(toLocation: annotationPin.coordinate, zoomLevel: "current")
        delegate?.didUpdateMapVCAnnotation(annotationPin: annotationPin)
    }
}

// MARK: - ConvertFuncs

extension MapViewController {
    func center(toLocation location: CLLocation) { mapView.center(toLocation: location) }
    func center(toLocation location: CLLocationCoordinate2D) { mapView.center(toLocation: location) }
    func center(toLocation location: CLLocation, zoomLevel: String) { mapView.center(toLocation: location.coordinate, zoomLevel: zoomLevel) }
    func center(toLocation location: CLLocationCoordinate2D, zoomLevel: String) { mapView.center(toLocation: location, zoomLevel: zoomLevel) }
    func setCameraZoomMaxDistance(_ maxDistance: Double) { mapView.setCameraZoomRange(MKMapView.CameraZoomRange(maxCenterCoordinateDistance: maxDistance), animated: true) }
    func setCameraBoundary(_ region: MKCoordinateRegion) { mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true) }
    func convertToLocation2D(_ latitude: Double, _ longitude: Double) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude) }
    func convertToLocation(_ latitude: Double, _ longitude: Double) -> CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude) }
    func convertToRegion(_ center: CLLocation, latitudinalMeters: Double, longitudinalMeters: Double) -> MKCoordinateRegion { return MKCoordinateRegion(center: center.coordinate, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters) }
    func convertToRegion(_ center: CLLocationCoordinate2D, latitudinalMeters: Double, longitudinalMeters: Double) -> MKCoordinateRegion { return MKCoordinateRegion(center: center, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters) }
    func removeAnnotation(_ object: AnnotationPin) { mapView.removeAnnotation(object) }
    func addAnnotation(_ object: AnnotationPin) { mapView.addAnnotation(object) }
    func removeAnnotations(_ objects: [AnnotationPin]) { mapView.removeAnnotations(objects) }
    func replocateAnnotation(_ object: AnnotationPin) { removeAnnotation(object); addAnnotation(object) }
    func getSelectedAnnotationPin() -> AnnotationPin? { return selectedPin }
    func deSelectAnnotation() { selectedView?.image = selectedPin?.deselectImage }
}

// MARK: - CoreData

extension MapViewController {
    private func displayAnnotations() {
        let startLocation = convertToLocation(37.529510664039876, 127.02840863820876)
        let distance: Double = 60000
        let span = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        let mapCoordinate = MKCoordinateRegion(center: startLocation.coordinate, span: span)

        center(toLocation: startLocation)
        mapView.setRegion(mapCoordinate, animated: true)
        setCameraZoomMaxDistance(distance)

        mapView.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)

//        FROMJSON_TEST()
//        AddDdip_DUP_TEST()
        print("-------------------")
//        FROMJSONARRAY_TEST()
//        DELETE_TEST()
        TOJSON_TEST()
        AddDdip_TEST()
        setAnnotation()
    }

    func setAnnotation() {
        let coreData: [Ddip] = CoreDataManager.shared.fromCoreData()
        guard !coreData.isEmpty else { return }
        
        annotations.removeAll()
        for item in coreData {
            annotations.append(AnnotationPin(item: item))
        }
        mapView.addAnnotations(annotations)
    }
    
    
    
}

// MARK: - Debug
#if DEBUG

extension MapViewController {
    func allTest() {}
    
    func AddDdip_TEST() {
        let id:Int64 = 10
        let title:String = "test10"
        let placeName:String = "ten"
        let la:Double = 37.624415113540215
        let lo:Double = 127.12942313110083
        let testDdipString:String = "[{\"id\":\(id),\"title\":\"\(title)\",\"placeName\":\"\(placeName)\",\"startTime\":652897657.92252302,\"createTime\":652897557.92252302,\"remainSlot\":3,\"ddipToken\":\"ddipToken\",\"latitude\":\(la),\"longitude\":\(lo)}]"
        print(testDdipString)
        print("-------------------!!!0")
        let obj:[DdipForm] = CoreDataManager.shared.fromJson(json: testDdipString)
        for item in obj {
            print(item.id)
            print(item.placeName)
        }

        print("-------------------!!!1")
        let code:[Ddip] = CoreDataManager.shared.toCoreData(jsonString: testDdipString)
        for item in code {
            print(item.id)
            print(item.placeName)
        }
    }

    func AddDdip_DUP_TEST() {
        let id:Int64 = 11
        let title:String = "test11"
        let placeName:String = "eleven"
        let la:Double = 37.54184581847791
        let lo:Double = 127.03724921912465
        let testDdipString:String = "[{\"id\":\(id),\"title\":\"\(title)\",\"placeName\":\"\(placeName)\",\"startTime\":652897657.92252302,\"createTime\":652897557.92252302,\"remainSlot\":3,\"ddipToken\":\"ddipToken\",\"latitude\":\(la),\"longitude\":\(lo)}]"
        print(testDdipString)
        
        print("-------------------")
        let code:[Ddip] = CoreDataManager.shared.toCoreData(jsonString: testDdipString)
        for item in code {
            print(item.id)
            print(item.placeName)
        }
        print("- - - - - - - - - - - - - - - - - -")
        let dup:[Ddip] = CoreDataManager.shared.toCoreData(jsonString: testDdipString)
        for item in dup {
            print(item.id)
            print(item.placeName)
        }
    }

    func TOJSON_TEST() {
        let coreData: [Ddip] = CoreDataManager.shared.fromCoreData()
        let jsonArray:String = CoreDataManager.shared.toJson(code: coreData)
        print(jsonArray)
    }
    
    func FROMJSON_TEST() {
        let id:Int64 = 9
        let title:String = "test9"
        let placeName:String = "nine"
        let la:Double = 37.5307749196663
        let lo:Double = 127.02579994220088
        let testDdipString:String = "[{\"id\":\(id),\"title\":\"\(title)\",\"placeName\":\"\(placeName)\",\"startTime\":652897657.92252302,\"createTime\":652897557.92252302,\"remainSlot\":3,\"ddipToken\":\"ddipToken\",\"latitude\":\(la),\"longitude\":\(lo)}]"

        let data:[DdipForm] = CoreDataManager.shared.fromJson(json: testDdipString)
        for item in data {
            print(item.id)
            print(item.placeName)
        }
        let tt:[Ddip] = CoreDataManager.shared.fromCoreData(id:8)
        let st = CoreDataManager.shared.toJson(code: tt)
        print(st)
    }
    
    func FROMJSONARRAY_TEST() {
        let code:[Ddip] = CoreDataManager.shared.fromCoreData()
        let jsonArray = CoreDataManager.shared.toJson(code: code)
        let data:[DdipForm] = CoreDataManager.shared.fromJson(json: jsonArray)
        for item in data {
            print(item.id)
            print(item.placeName)
        }
        let st = CoreDataManager.shared.toJson(code: code)
        print(st)
    }
    
    func DELETE_TEST() {
        CoreDataManager.shared.deleteCoreData(entityName: ENTITY().ddip, id: 7)
    }
}

#endif
