////
////  UISearchView.swift
////  ProjectDDIP
////
////  Created by su on 2021/09/18.
//
//import MapKit
//import UIKit
//import SwiftUI
//
//struct TableView: UIViewRepresentable {
//    typealias UIViewType = UITableView
//
//    let tableView = UITableView()
//    
//    @Binding var searchText: String
//    @Binding var completerResults: [MKLocalSearchCompletion]?
//    
//    func makeUIView(context: Context) -> UIViewType {
//
//        return tableView
//    }
//
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//        uiView.register(Cell.self, forCellReuseIdentifier: "cell2")
//        uiView.delegate = context.coordinator
//        uiView.dataSource = context.coordinator
//    }
//    
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(self)
//    }
//    
//    class Coordinator: NSObject, UITableViewDelegate, UITableViewDataSource, MKLocalSearchCompleterDelegate{
//        var parent: TableView
//        
//        
//        init(_ parent: TableView) {
//            self.parent = parent
//        }
//        
//        func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
//            return 3
//        }
//        
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? Cell else { return UITableViewCell() }
//
//            cell.textLabel?.text = "asdf"
//            cell.titleLabel.text = "\(type(of:cell))"
//            cell.subtitleLabel.text = "hello"
//            return cell
//        }
//        
//        func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
//            parent.completerResults = completer.results
//            
//            parent.tableView.reloadData()
//        }
//        
//        func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
//            if let error = error as NSError? {
//                print("MKLocalSearchCompleter encountered an error: \(error.localizedDescription). The query fragment is: \"\(completer.queryFragment)\"")
//                parent.tableView.reloadData()
//            }
//        }
//    }
//}
////
////struct TableView_Previews: PreviewProvider {
////    static var previews: some View {
////        TableView(searchText: .constant(""))
////    }
////}
