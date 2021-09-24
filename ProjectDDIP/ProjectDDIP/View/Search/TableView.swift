//
//  UISearchView.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/18.

import MapKit
import UIKit
import SwiftUI

struct TableView: UIViewRepresentable {
    typealias UIViewType = UITableView
    @Binding var searchText: String
    
    func makeUIView(context: Context) -> UIViewType {
        let view = UITableView()

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.register(Cell.self, forCellReuseIdentifier: "cell2")
        uiView.delegate = context.coordinator
        uiView.dataSource = context.coordinator
    }
    

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, UITableViewDelegate, UITableViewDataSource {
        var tableview: TableView
        
        init(_ tableView: TableView) {
            self.tableview = tableView
        }
        
        func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
            return 3
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? Cell else { return UITableViewCell() }

            cell.textLabel?.text = "asdf"
            cell.titleLabel.text = "\(type(of:cell))"
            cell.subtitleLabel.text = "hell;o"
            return cell
        }
    }
}
//
//struct TableView_Previews: PreviewProvider {
//    static var previews: some View {
//        TableView(searchText: .constant(""))
//    }
//}
