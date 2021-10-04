//
//  Network.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/10/04.
//

import Foundation
import Alamofire
import SystemConfiguration
import UIKit

struct Connection {
    static let connection = NetworkReachabilityManager()!
    static var isOn: Bool { return connection.isReachable }
    static var isCellularOn: Bool { return connection.isReachableOnCellular }
    static var isWIFIOn: Bool { return connection.isReachableOnEthernetOrWiFi }
}

struct Network {
    
    static var share: Network = Network()
    
    var coordinator: MapView.Coordinator? = nil

    mutating func set(coordinator coord: MapView.Coordinator) {
        self.coordinator = coord;
    }
    
    func getButtonTest() {
        print("I will get")
        print("=============================================")
    }
    
    
    func postButtonTest() {
        print("I will post")
        
        if coordinator == nil {
            print("coordinator is NULL")
        }
        else {
            if coordinator?.parent.gesturePinState == .on {
                print("gesture Pin On!")
                print("loc = \(coordinator?.parent.mapViewModel.gesturePin.coordinate.latitude ?? 0), \(coordinator?.parent.mapViewModel.gesturePin.coordinate.longitude ?? 0)")
            }
            else {
                print("gesutre pin off!")
            }
        }

        if Connection.isOn {
//        if Reachability.isConnectedToNetwork(netType: .Cellular) {
            print("Network Available")
        }
        else {
            print("Network Unavailable")
//            let alert = UIAlertController(title: "Network Unavailable", message: "Please connect to the internet in order to proceed.", preferredStyle: .alert)
//            alert.show()
        }
        print("=============================================")
    }
  
    
/*
    let getUrl: String = "https://jsonplaceholder.typicode.com/todos/1"
    let postUrl = "https://ptsv2.com/t/48ku6-1633170491/post"
    
    func getTest() {
        AF.request(getUrl,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers:["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { json in
                print(json)
                print("--------------------------")
            }
    }
    
    
    
    func postTest() {
        var request = URLRequest(url: URL(string: postUrl)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
            
        // POST 로 보낼 정보
        let params = ["id":"hello", "pw":"world"] as Dictionary

        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
            
        AF.request(request).responseString { (response) in
            switch response.result {
                case .success:
                    print("POST 성공")
                case .failure(let error):
                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
 */
}

//
//// MARK: - Network Connection Test
//
//
//public class Reachability {
//
//    class func isConnectedToNetwork(netType: NetType) -> Bool {
//
//        var isReachable: Bool
//        var needsConnection: Bool
//
//        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
//        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//
//        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
//            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
//                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
//            }
//        }
//
//        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
//        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) { return false }
//
//        if netType == .WIFI {
//            isReachable = flags == .reachable
//            needsConnection = flags == .connectionRequired
//        }
//        else {
//            isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
//            needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
//        }
//
//        return isReachable && !needsConnection
//    }
//}
