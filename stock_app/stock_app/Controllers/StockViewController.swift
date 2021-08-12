//
//  ViewController.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 05.03.2021.
//

import UIKit
import CoreData
class StockViewController: UIViewController{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var accountButton: UIButton!
    var stocks: [Stock] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchURL()
    }
    
    // MARK: Button actions

    @IBAction func accountButton(_ sender: Any) {
        // delete our default login
        UserDefaults.standard.set(false, forKey: "USERDEFAULTLOGIN")
        
        navigationController?.popViewController(animated: true)
        
    }

    @objc func addToCart(sender: UIButton){
        let i = sender.tag
        let stock = stocks[i]
        let stc = PersistenceService.shared.stock(symbol: stock.symbol, longName: stock.longName, price: stock.regularMarketPrice)
        PersistenceService.shared.saveContext()
        print(stc)
    }
    
    
    //MARK: JSON Parsing
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(StockQuotes.self, from: json) {
            stocks = jsonPetitions.quotes
//            tableView.reloadData()
        }
    }
    func fetchURL(){
        let endPoint: String = {
            return "https://mboum.com/api/v1/co/collections/?list=day_gainers&start=1&apikey=demo"
        }()
        
        if let url = URL(string: endPoint) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

// MARK: Table View Controller
extension StockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath) as! StocksCell
        cell.stockView.layer.cornerRadius = cell.frame.height * 0.2
        cell.stockView.backgroundColor = ((indexPath.row % 2) != 0) ?
            UIColor.white : UIColor.systemGray6
        let backgroundView = UIView()
        backgroundView.backgroundColor = .none
        cell.selectedBackgroundView = backgroundView

        cell.addToCartButton.tag = indexPath.row
        cell.addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        
        let s = stocks[indexPath.row]
        cell.stockLabel.text = s.symbol
        cell.stockSublabel.text = s.longName
        cell.stockCost.text = "\(s.regularMarketPrice)"
        return cell
    }
}

extension StockViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "DetailStockViewController") as! DetailStockViewController
        show(secondVC, sender: self)
    }
}
