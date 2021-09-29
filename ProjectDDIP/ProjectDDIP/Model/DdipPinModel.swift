//
//  Annotation.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/08/24.
//
import CoreData
import MapKit

class DdipPinModel: NSObject, MKAnnotation, ObservableObject {
    
    @Published var selected: Bool = false
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    init (meetingName: String?, location: CLLocationCoordinate2D) {
        self.title = meetingName
        self.coordinate = location
    }

    init (item: NSManagedObject) {
        guard let converted = item as? Ddip else { assert(false) }
        
        self.coordinate = CLLocationCoordinate2D(latitude: converted.latitude, longitude: converted.longitude)
        self.title = converted.title
    }
    
    func set(title: String, location: CLLocationCoordinate2D) {
        self.title = title
        coordinate = location
    }
}
