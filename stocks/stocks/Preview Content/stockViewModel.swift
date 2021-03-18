//
//  stockViewModel.swift
//  stocks
//
//  Created by Ekaterina Tarasova on 18.03.2021.
//

import Foundation

class apiCall {
    var stocks = [Stock]()

    func getUsers(completion:@escaping ([StocksApi]) -> ()) {
        guard let url = URL(string: "https://mboum.com/api/v1/co/collections/?list=day_gainers&start=1&apikey=demo") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let stock = try? JSONDecoder().decode(StocksApi.self, from: data!)
            self.stocks = stock!.quotes

//            DispatchQueue.main.async {
//                completion(stock)
//            }
        }
        .resume()
    }

}
