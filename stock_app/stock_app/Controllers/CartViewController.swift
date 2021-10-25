//
//  CartViewController.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 12.08.2021.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var cartTableView: UITableView!
    var cart = StockViewController.stocksCart
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartTableView.delegate = self
        cartTableView.dataSource = self
        cart = PersistenceService.shared.fetchRequestCart()
    }
    
//MARK: BUTTONS

    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
  
// MARK: UPDATE CART DATA
    
    func saveContextIn() {
        let context = PersistenceService.shared.persistentContainer.viewContext
        do {
            try context.save()
        }
        catch let error{
            print("error:\(error)")
        }
    }
    // if count < 1 delete stock
    // -1 stock and -price
    @objc func decreaseNumberOfStocks(sender: UIButton) {
        let i = sender.tag
        let stock = PersistenceService.shared.fetchRequestCart()[i]
        let context = PersistenceService.shared.persistentContainer.viewContext
        if stock.stockscount > 1 {
            stock.stockscount -= 1
            stock.myPrice -= stock.regularMarketPrice
            saveContextIn()
        } else {
            context.delete(stock)
            do {
                try context.save()
                cart.remove(at: i)
            }
            catch let error{
                print("DELETING ERROR: \(error)")
            }
        }
        cartTableView.reloadData()
    }
    
    // +1 stock and +price
    @objc func increaseNumberOfStock(sender: UIButton) {
        let i = sender.tag
        let stock = PersistenceService.shared.fetchRequestCart()[i]
        stock.stockscount += 1
        stock.myPrice += stock.regularMarketPrice
        saveContextIn()
        cartTableView.reloadData()
    }
}

// MARK: CART VIEW CONTROLLER EXTENSION

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockCartCell", for: indexPath) as! StocksCell
        cell.stockView.layer.cornerRadius = cell.frame.height * 0.2
        cell.stockView.backgroundColor = ((indexPath.row % 2) != 0) ?
        UIColor.white : UIColor.systemGray6
        let backgroundView = UIView()
        backgroundView.backgroundColor = .none
        cell.selectedBackgroundView = backgroundView
        
        cell.minusCartBtn.tag = indexPath.row
        cell.plusCartBtn.tag = indexPath.row
        cell.plusCartBtn.addTarget(self, action: #selector(increaseNumberOfStock), for: .touchUpInside)
        cell.minusCartBtn.addTarget(self, action: #selector(decreaseNumberOfStocks), for: .touchUpInside)
        
        let stock = cart[indexPath.row]
        cell.stockLabel.text = stock.symbol
        cell.stockSublabel.text = stock.longName
        cell.stockCost.text = "$\(roundDouble(stock.myPrice, toDecimalPlaces: 2))"
        cell.countstockCartBtn.text = "\(stock.stockscount)"
        return cell
    }
}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "DetailStockViewController") as! DetailStockViewController
        let stock = PersistenceService.shared.fetchRequestCart()[indexPath.row]
        secondVC.regularPriceLow = stock.regularMarketDayLow
        secondVC.regularPriceHigh = stock.regularMarketDayHigh
        secondVC.weekRangePriceLow = stock.fiftyTwoWeekLow
        secondVC.weekRangePriceHigh = stock.fiftyTwoWeekHigh
        secondVC.symbol = stock.symbol!
        secondVC.longname = stock.longName!
        
        show(secondVC, sender: self)
    }
}
