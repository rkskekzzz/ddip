//
//  SearchPanelLayout.swift
//  ProjectDDIP
//
//  Created by 차영훈 on 2021/08/29.
//

import FloatingPanel
import UIKit

class SearchPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip

    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 44.0, edge: .bottom, referenceGuide: .safeArea),
        ]
    }

    func backdropAlpha(for _: FloatingPanelState) -> CGFloat {
        //		return state == .full ? 0.3 : 0.0
        return 0.0
    }
}
