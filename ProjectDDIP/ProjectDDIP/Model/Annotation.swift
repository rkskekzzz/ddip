//
//  Annotation.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/08/24.
//

import MapKit
import Contacts

class AnnotationObject: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String?
    let discipline: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, locationName: String?, discipline: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }

    init?(feature: MKGeoJSONFeature) {
        guard
            let point = feature.geometry.first as? MKPointAnnotation,
            let propertiesData = feature.properties,
            let json = try? JSONSerialization.jsonObject(with: propertiesData),
            let properties = json as? [String: Any]
        else { return nil }

        title = properties["title"] as? String
        locationName = properties["location"] as? String
        discipline = properties["discipline"] as? String
        coordinate = point.coordinate

        super.init()
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

    func exchangeColor(_ hex: Int) -> UIColor {
        return UIColor(
            red: CGFloat((hex & 0xff0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00ff00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000ff) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    var markerTintColor: UIColor  {
        
        switch discipline {
        case "Monument":
            return exchangeColor(0xFFB900)
        case "Mural":
            return exchangeColor(0xFF3D2E)
        case "Plaque":
            return exchangeColor(0xFF96A0)
        case "Sculpture":
            return exchangeColor(0xFF118B)
        default:
            return exchangeColor(0x52006A)
        }
    }
}

