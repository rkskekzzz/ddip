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
    
    var id: String
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    init (id: String, meetingName: String?, location: CLLocationCoordinate2D) {
        self.id = id
        self.title = meetingName
        self.coordinate = location
    }

    init (item: NSManagedObject) {
        guard let converted = item as? Ddip else { assert(false) }
        
        self.id = converted.id
        self.title = converted.title
        self.coordinate = CLLocationCoordinate2D(latitude: converted.latitude, longitude: converted.longitude)
    }
    
    func set(id: String, title: String, location: CLLocationCoordinate2D) {
        self.id = id
        self.title = title
        coordinate = location
    }
}
