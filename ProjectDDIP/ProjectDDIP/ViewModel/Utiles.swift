//
//  Utiles.swift
//  ProjectDDIP
//
//  Created by su on 2021/10/04.
//

import SwiftUI
import SlideOverCard

func getSlideCardPositionValue(_ position: CardPosition) -> CGFloat {
    switch position {
    case .bottom:
        return 80
    case .middle:
        return UIScreen.main.bounds.height * (1 - 1/1.8)
    case .top:
        return UIScreen.main.bounds.height - 80
    }
}
