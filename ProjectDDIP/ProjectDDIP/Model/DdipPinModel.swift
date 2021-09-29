//
//  Annotation.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/08/24.
//
import CoreData
import MapKit
import UIKit

extension MKMarkerAnnotationView {
    
    open override var annotation: MKAnnotation? {
        
        didSet {
            guard let convert = annotation as? DdipPinModel else { return }
            self.isEnabled = false
            convert.view = self;
        }
    }

    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let touchRect = bounds.insetBy(dx: -ANNOTATION_TOUCH_EXPAND, dy: -ANNOTATION_TOUCH_EXPAND)
        if touchRect.contains(point) {
            for subview in subviews.reversed() {
                let convertedPoint = subview.convert(point, from: self)
                if let hitTestView = subview.hitTest(convertedPoint, with: event) {
                    return hitTestView
                }
            }
            return self
        }
        return nil
    }
}

class DdipPinModel: NSObject, MKAnnotation, ObservableObject {
    
    @Published var selected: Bool = false
    
    var view: MKMarkerAnnotationView?
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
