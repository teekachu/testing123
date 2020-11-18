//
//  Location.swift
//  FindingUserLocationWithMapkit
//
//  Created by Tee Becker on 11/17/20.
//

import Foundation
import MapKit

class location: NSObject, MKAnnotation{
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String?, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
