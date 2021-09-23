//
//  MeetingPanelLayout.swift
//  ProjectDDIP
//
//  Created by 차영훈 on 2021/08/29.
//

import FloatingPanel
import UIKit

class MeetingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half

    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.31, edge: .bottom, referenceGuide: .safeArea),
        ]
    }

    func backdropAlpha(for _: FloatingPanelState) -> CGFloat {
        return 0.0
    }
}
