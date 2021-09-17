//
//  ListItem.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/18.
//

import SwiftUI

struct ListItem2: View {
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            Text(subtitle)
        }
    }
}

struct ListItem2_Previews: PreviewProvider {
    static var previews: some View {
        ListItem2(title: "hi", subtitle: "hello")
    }
}
