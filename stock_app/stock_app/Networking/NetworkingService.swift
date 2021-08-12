//
//  NetworkingService.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 09.08.2021.
//

import Foundation

class NetworkingService {
    private init(){}
    static let shared = NetworkingService()
    
    lazy var endPoint: String = {
        return "https://mboum.com/api/v1/co/collections/?list=day_gainers&start=1&apikey=demo"
    }()
    
    func getData(completion: @escaping (Result<[[String: AnyObject]]>) -> Void) {
        let URLString = endPoint
        
        guard let isURL = URL(string: URLString) else {
            return completion(.Error("Invalid URL, we can't update your feed"))
        }
        
        URLSession.shared.dataTask(with: isURL) {(data, response, error) in
            guard error == nil else {
                return completion(.Error(error!.localizedDescription))
            }
            guard let data = data else {
                return completion(.Error(error?.localizedDescription ?? "There are no new Items to show"))
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject] {
                    guard let itemsJsonArray = json["quotes"] as? [[String: AnyObject]] else {
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