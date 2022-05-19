//
//  network.swift
//  passporter
//
//  Created by dgonzbal on 10/5/22.
//

import Foundation
class Network {
    let mainUrl = "https://myjson.dit.upm.es/api/bins/e8zj"
    
    func getJson(completion: (@escaping (_ result: DataResults?) -> Void)) {
        guard let url = URL(string: mainUrl) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                if let data = data {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(DataResults.self, from: data)
                    completion(result)
                }
            } catch {
                completion(nil)
            }
        })
        task.resume()
    }
    
    func getImage(url: String, completion: (@escaping (_ result: Data?) -> Void)) {
        guard let url = URL(string: url) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            completion(data)
        })
        task.resume()
    }
}
