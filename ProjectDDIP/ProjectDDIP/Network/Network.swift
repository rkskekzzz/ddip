//
//  Network.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/10/02.
//

import Foundation
import Alamofire

struct Network {
    
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
}
