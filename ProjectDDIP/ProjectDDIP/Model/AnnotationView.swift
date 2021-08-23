//
//  AnnotationView.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/08/24.
//

import MapKit

class AnnotationMarkerView: MKMarkerAnnotationView {

    override var annotation: MKAnnotation? {
        willSet {
            guard let annotationObject = newValue as? AnnotationObject else { return }

            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)

            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 48, height: 48)))
            mapsButton.setBackgroundImage(#imageLiteral(resourceName: "Map"), for: .normal)
            rightCalloutAccessoryView = mapsButton
            
            markerTintColor = annotationObject.markerTintColor
            if let letter = annotationObject.discipline?.first { glyphText = String(letter) }
        }
    }
}
