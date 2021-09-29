//
//  ButtonVIew.swift
//  ProjectDDIP
//
//  Created by 차영훈 on 2021/09/28.
//

import SwiftUI

struct ButtonView: View {
	var body: some View {
		HStack {
			NavigationLink(destination: NewMeetingView()) {
				Image(systemName: "plus.circle")
					.font(.system(size: 50))
					.foregroundColor(.white)
					.background(Color.blue)
					.cornerRadius(100)
					.shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
			}
			NavigationLink(destination: ScheduleView()) {
				Image(systemName: "calendar.circle")
					.font(.system(size: 50))
					.foregroundColor(.white)
					.background(Color.pink)
					.cornerRadius(100)
					.shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
			}
//			.buttonStyle(.plain)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
		.padding(.vertical, 100)
		.padding(.horizontal, 40)
	}
}
