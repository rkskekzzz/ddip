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
//        print("--> call updateUIView <--")
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
            
            //            TEST_CORE_DATA.shared.AddDdip_TEST(id: UUID().uuidString, title: "one", placeName: "one", la: 37.52628887090283, lo: 127.0293461382089)
            self.UIGestureInit()
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

        
        
        
        
        
        
        
        func disposeDdipZone(with model: DdipPinModel) {
            if parent.mapViewModel.selectedPin?.id == model.id { return }
            
            deselectPin(with: model)
            model.view?.setSelected(true, animated: true)
        }
        
        func deselectPin(with model:DdipPinModel?) {
            parent.mapViewModel.selectedPin?.view?.setSelected(false, animated: true)
            parent.mapViewModel.selectedPin = model

            if parent.mapViewModel.gesturePin.id != "" && (model == nil || model?.id == parent.mapViewModel.gesturePin.id) { gesturePinState = .onGesturePin }
            else { gesturePinState = .offGesturePin }
        }
        
        func putGesturePin(location coordinate: CLLocationCoordinate2D) {
            parent.mapViewModel.gesturePin.set(id: UUID().uuidString, title: "gesturePin", location: coordinate)
            appendAnnotation(with: parent.mapViewModel.gesturePin)
            gesturePinState = .onGesturePin
        }
        
        func disposeEmptyZone(with model: DdipPinModel, location coordinate: CLLocationCoordinate2D) {
            if parent.mapViewModel.selectedPin != nil {
                deselectPin(with: nil)
                return
            }
            putGesturePin(location: coordinate)
        }

        
        @objc func handleTapGesture(gestureRecognizer: UITapGestureRecognizer) {
            let coordinate = parent.mapView.convert(gestureRecognizer.location(in: parent.mapView), toCoordinateFrom: parent.mapView)
            for item in parent.mapView.visibleAnnotations() {
                if let model = item as? DdipPinModel {
                    if (model.view?.hitTest(gestureRecognizer.location(in: model.view), with: nil)) != nil {
                        disposeDdipZone(with: model)
#if DEBUG
                        printDebug(with: coordinate)
#endif
                        return
                    }
                }
            }
            disposeEmptyZone(with: parent.mapViewModel.gesturePin, location: coordinate)
#if DEBUG
            printDebug(with: coordinate)
#endif
        }
        
        func printDebug(with coordinate: CLLocationCoordinate2D) {
            print("is Enable (+) = \((gesturePinState == .onGesturePin) ? true : false)")
            if (gesturePinState == .onGesturePin && parent.mapViewModel.selectedPin == nil) { print("GesturePin is on the map. So you can access GesturePin even if selectedPin is NULL") }
            if parent.mapViewModel.selectedPin != nil { print("Activate target = \(parent.mapViewModel.selectedPin!.title!)") }
            else { print("Activate target (selectedPin) = NULL") }
            print("Tapped at Latitiude: \(coordinate.latitude), Longitude: \(coordinate.longitude)")
            print("------------------------------------------------")
        }
        
        
        
        
        
        
        
        

        func appendAnnotation(with annotation: MKAnnotation) {
            parent.mapView.removeAnnotation(annotation)
            parent.mapView.addAnnotation(annotation)
        }
        
        func getId(from annotation: MKAnnotation) -> String {
            guard let convert = annotation as? DdipPinModel else { assert(false) }
            return convert.id
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

