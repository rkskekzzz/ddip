//
//  Annotation.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/08/24.
//

import CoreData
import Contacts
import MapKit
import UIKit

class AnnotationPin: NSObject, MKAnnotation {
    var title: String?
    var locationName: String?
    var coordinate: CLLocationCoordinate2D

    init(title: String?, locationName: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        super.init()
    }

    init(item: NSManagedObject) {
        guard let convert = item as? Ddip else { assert(false) }
        
        self.title = convert.title
        self.locationName = convert.placeName
        self.coordinate = CLLocationCoordinate2D(latitude: convert.latitude, longitude: convert.longitude)
    }
    
    var subtitle: String? { return locationName }

    var mapItem: MKMapItem? {
        guard let location = locationName else { return nil }

        let addressDict = [CNPostalAddressStreetKey: location]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)

        mapItem.name = title
        return mapItem
    }
}

// MARK: - SetData

extension AnnotationPin {
    func setAttributes(_ title: String?, _ locationName: String?, _ coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
    }

    func setTitle(_ title: String) { self.title = title }
    func setCoordinate(_ coordinate: CLLocationCoordinate2D) { self.coordinate = coordinate }
    func setLocationName(_ locationName: String) { self.locationName = locationName }
}

// MARK: - GetImage

extension AnnotationPin {
    var deselectImage: UIImage { return #imageLiteral(resourceName: "plus") }
    var selectImage: UIImage { return #imageLiteral(resourceName: "Map") }
}

