//
//  CartViewController.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 12.08.2021.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var cartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartTableView.delegate = self
        cartTableView.dataSource = self
        stocksCart = PersistenceService.shared.fetchRequestCart()
    }

    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // -1 stock and -price
    // +1 stock and +price
    // if count < 1 delete stock 
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocksCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockCartCell", for: indexPath) as! StocksCell
        cell.stockView.layer.cornerRadius = cell.frame.height * 0.2
        cell.stockView.backgroundColor = ((indexPath.row % 2) != 0) ?
        UIColor.white : UIColor.systemGray6
        let backgroundView = UIView()
        backgroundView.backgroundColor = .none
        cell.selectedBackgroundView = backgroundView
        
        let stock = stocksCart[indexPath.row]
        cell.stockLabel.text = stock.symbol
        cell.stockSublabel.text = stock.longName
        cell.stockCost.text = "$\(stock.regularMarketPrice)"
        cell.countstockCartBtn.text = "\(stock.count)"
        return cell
    }
}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
