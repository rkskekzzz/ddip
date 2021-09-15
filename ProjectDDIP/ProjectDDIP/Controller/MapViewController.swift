//
//  MapViewController.swift
//  ProjectDDIP
//
//  Created by su on 2021/08/23.
//

import UIKit
import MapKit
import CoreData

extension CLLocation {
    convenience init(latitude: Double, longtigude: Double) {
        assert(false)
    }
}

protocol MapViewControllerDelegate {
//    func didUpdateMapVCAnnotation(_ mapViewController: MapViewController, annotationObject: AnnotationObject)
    func didUpdateMapVCAnnotation(annotationObject: AnnotationObject)
//    func didUpdateMapVCAnnotationFail(error: Error)
}

class MapViewController: UIViewController {
    var delegate: MapViewControllerDelegate?
    
    @IBOutlet weak var mapView: MKMapView!
    private var gesturePin = AnnotationObject(title: nil, locationName: nil, discipline: nil, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    private var selectedView: MKAnnotationView? = nil
    private var selectedPin: AnnotationObject? = nil
    private var annotations: [AnnotationObject] = []
    
    var annotationDeselectBehaviourDefines: () -> Void = {
        assert(false)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.pointOfInterestFilter = .excludingAll
        UIGestureInit()
        displayAnnotations()
    }
    
    func centerToLocation(_ location: CLLocation, _ radius: Double) {
        centerToLocation(location)
        let span = MKCoordinateSpan(latitudeDelta: radius / 111320, longitudeDelta: radius / 111320)
        let mapCoordinate = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(mapCoordinate, animated: true)
    }
    func centerToLocation(_ location: CLLocation) { mapView.centerToLocation(location) }
    func centerToLocation(_ location: CLLocationCoordinate2D) { mapView.centerToLocation(location) }
    func centerToLocation(_ location: CLLocation, _ zoomLevel: String) { mapView.centerToLocation(location.coordinate, zoomLevel) }
    func centerToLocation(_ location: CLLocationCoordinate2D, _ zoomLevel: String) { mapView.centerToLocation(location, zoomLevel) }
    func setCameraZoomMaxDistance(_ maxDistance: Double) { mapView.setCameraZoomRange(MKMapView.CameraZoomRange(maxCenterCoordinateDistance: maxDistance), animated: true) }
    func setCameraBoundary(_ region: MKCoordinateRegion) { mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true) }
    func convertToLocation2D(_ latitude: Double, _ longitude: Double) -> CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: latitude, longitude: longitude) }
    
    func convertToLocation(_ latitude: Double, _ longitude: Double) -> CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude) }
    func convertToRegion(_ center: CLLocation, latitudinalMeters: Double, longitudinalMeters: Double) -> MKCoordinateRegion { return MKCoordinateRegion(center: center.coordinate, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters) }
    func convertToRegion(_ center: CLLocationCoordinate2D, latitudinalMeters: Double, longitudinalMeters: Double) -> MKCoordinateRegion { return MKCoordinateRegion(center: center, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters) }
    func removeAnnotation(_ object: AnnotationObject) { mapView.removeAnnotation(object) }
    func addAnnotation(_ object: AnnotationObject) { mapView.addAnnotation(object) }
    func removeAnnotations(_ objects: [AnnotationObject]) { mapView.removeAnnotations(objects) }
    func addAnnotations(_ objects: [AnnotationObject]) { mapView.addAnnotations(objects) }
    func replocateAnnotation(_ object: AnnotationObject) { removeAnnotation(object); addAnnotation(object) }
    func getSelectedAnnotationObject() -> AnnotationObject? { return self.selectedPin }
	func deselectAnnotation() { selectedView?.image = selectedPin?.image }
}

extension MapViewController: UIGestureRecognizerDelegate {
    
    func UIGestureInit() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MapViewController.handleTapGesture(gestureRecognizer:)))
        mapView.addGestureRecognizer(tapGesture)
    }

    @objc func handleTapGesture(gestureRecognizer: UITapGestureRecognizer) {
        
        let hitObject = mapView.hitTest(gestureRecognizer.location(in: mapView), with: nil) as? AnnotationView
        
        if !mapView.selectedAnnotations.isEmpty {
            if hitObject == nil {
                deselectAnnotation()
                selectedView = nil
                selectedPin = nil
                self.annotationDeselectBehaviourDefines()
            }
            return
        }
        if hitObject != nil { return }

        if  gestureRecognizer.state == .ended {
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
        deSelectAnnotation()
        selectedView = view
        selectedPin = annotationObject
        view.image = annotationObject.focusImage
        center(toLocation: annotationObject.coordinate, zoomLevel: "current")
        delegate?.didUpdateMapVCAnnotation(annotationObject: annotationObject)
    }
}

private extension MKMapView {
    func center(toLocation location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: self.camera.centerCoordinateDistance, longitudinalMeters: self.camera.centerCoordinateDistance)
        setRegion(coordinateRegion, animated: true)
    }

    func centerToLocation(_ location: CLLocationCoordinate2D, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: self.camera.centerCoordinateDistance, longitudinalMeters: self.camera.centerCoordinateDistance)
        setRegion(coordinateRegion, animated: true)
    }
    
    func center(toLocation location: CLLocation, zoomLevel: String) {
        switch zoomLevel {
            case "current":
                self.setCenter(location.coordinate, animated: true)
                return
            default:
                centerToLocation(location)
        }
    }
    
    func centerToLocation(_ location: CLLocationCoordinate2D, _ zoomLevel: String) {
        switch zoomLevel {
            case "current":
                self.setCenter(location, animated: true)
                return
            default:
                centerToLocation(location)
        }
    }
    
    func visibleAnnotations() -> [MKAnnotation] { return self.annotations(in: self.visibleMapRect).map { obj -> MKAnnotation in return obj as! MKAnnotation } }
}



// MARK: - CoreData

extension MapViewController {
    
    private func displayAnnotations() {
        let startLocation = CLLocation(latitude: 37.529510664039876, longitude: 127.02840863820876)
        let distance: Double = 60000
        let span = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        let mapCoordinate = MKCoordinateRegion(center: startLocation.coordinate, span: span)

        center(toLocation: startLocation)
        center(toLocation: annotationObject.coordinate, zoomLevel: "current")
        
        
        mapView.setRegion(mapCoordinate, animated: true)
        setCameraZoomMaxDistance(distance)

        mapView.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        getAllDdips()
        getAllContracts()
        addAnnotations(annotations)
    }
    
    private func displayDdipData(ddips:[Ddip]) -> [AnnotationObject] {
        
        guard !ddips.isEmpty else { return }
        
        return ddips.map({
                  AnnotationObject(title: ddip.title, locationName: ddip.placeName, discipline: "discipline", coordinate: CLLocationCoordinate2D(latitude: ddip.latitude, longitude: ddip.longitude))
                  } )
    }
    
    private func getAllDdips() {
        let ddips: [Ddip] = CoreDataManager.shared.getDatas("Ddip")
        annotations.append(
            displayDdipData(ddips: ddips))

        //test start
        let titles: [String] = ddips.map({$0.title})
        let ids: [Int64] = ddips.map({$0.id})
        print("ids   = \(ids)")
        print("title = \(titles)")
        //test end
    }

    func getAllContracts() {
        let contracts: [Contract] = CoreDataManager.shared.getDatas("Contract")
        
        //test start
        let ids: [Int64] = contracts.map({$0.id})
        let ddipTokens: [String] = contracts.map({$0.ddipToken!})
        let userTokens: [String] = contracts.map({$0.userToken!})
        print("ids   = \(ids)")
        print("ddip = \(ddipTokens)")
        print("user = \(userTokens)")
        //test end
    }
    
    func saveNewDdip(_ id: Int64, title: String, ddipToken:String, latitude: Double, longitude: Double, placeName:String, reaminSlot: Int16) {
        CoreDataManager.shared.saveDdip(id: 0, title: title, createTime: Date(timeIntervalSinceNow: 0), startTime: Date(timeIntervalSinceNow: 100), ddipToken: ddipToken, latitude: latitude, longitude: longitude, placeName: placeName, remainSlot: 3) {
            onSuccess in print("saved = \(onSuccess)") }
        getAllDdips()
    }
    
    func saveNewContract(_ id: Int64, ddipToken:String, userToken:String) { CoreDataManager.shared.saveContract(id: id, ddipToken:ddipToken, userToken: userToken) { onSuccess in print("saved = \(onSuccess)") } }
    func deleteDdip(_ id: Int64) { CoreDataManager.shared.deleteDdip(id: id) { onSuccess in print("deleted = \(onSuccess)") } }
    func deleteContract(_ id: Int64) { CoreDataManager.shared.deleteContract(id: id) { onSuccess in print("deleted = \(onSuccess)") } }
}


#if DEBUG
extension ... {
    
    func allTest() {
        
    }
}
#endif
