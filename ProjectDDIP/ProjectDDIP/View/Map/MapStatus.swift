//
//  MapStatus.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/09/29.
//

import Foundation
import SwiftUI

enum MapState {
    case offGesturePin
    case onGesturePin
}

var gesturePinState: MapState = .offGesturePin
