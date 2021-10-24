//
//  NetworkingService.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 23.10.2021.
//

import Foundation

class NetworkingService {
    
    static let shared = NetworkingService()
    private init() {}
    typealias objects = [String: AnyObject]
    
    lazy var endPoint: String = {
        return "https://mboum.com/api/v1/co/collections/?list=day_gainers&start=1&apikey=demo"
    } ()
    
    func getDataWith(completion: @escaping (Result<[objects]>) -> Void) {
        let URLString = endPoint
        
        guard let isURL = URL(string: URLString) else {
            return completion(.Error("Invalid URL, we can't update your feed"))
        }
        //create a task that retrieves the contents in background
        URLSession.shared.dataTask(with: isURL) { (data, response, error) in
            
            guard error == nil else {
                return completion(.Error(error!.localizedDescription))
            }
            guard let data = data else {
                return completion(.Error("There are no new Items to show"))
            }
            
            do {
                // convert json to foundation objects
                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? objects {
                    
                    guard let itemsJsonArray = json["quotes"] as? [objects] else {
                        return completion(.Error(error?.localizedDescription ?? "There are no new Items to show"))
                    }
                    
                    let dispatchQueue = DispatchQueue(label: "QueueIdentification", qos: .background)
                    dispatchQueue.async {
                        completion(.Success(itemsJsonArray))
                    }
                }
            } catch let error {
                return completion(.Error(error.localizedDescription))
            }
        }.resume()
    }
}
