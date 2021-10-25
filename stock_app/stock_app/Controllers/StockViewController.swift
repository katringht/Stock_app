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
    static var stocksCart: [Cart] = []
    let fetch = FetchDataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        updateMyView()
    }
    
    func updateMyView() {
        fetch.updateView(self)
        fetch.fetchedResultController.delegate = self
        tableView.reloadData()
    }
    
    // MARK: Button actions

    @IBAction func accountButton(_ sender: Any) {
        let ac = UIAlertController(title: "Do you want to exit?", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "No", style: .cancel))
        ac.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            // delete our default login
            UserDefaults.standard.set(false, forKey: "USERDEFAULTLOGIN")
            
            self.navigationController?.popViewController(animated: true)
        }))
        present(ac, animated: true)
    }

    @objc func addToCart(sender: UIButton){
        let i = sender.tag
        let stock = fetch.fetchedResultController.fetchedObjects?[i] as? Stocks
        // checking existing stocks
        let request: NSFetchRequest<Cart> = Cart.fetchRequest()
        let str: String = (stock?.symbol)!
        request.predicate = NSPredicate(format: "symbol = %@", str)
        do{
            let context = PersistenceService.shared.persistentContainer.viewContext
            let count = try context.count(for: request)
            if(count == 0){
                let s = PersistenceService.shared.cart(s: (stock?.symbol)!, ln: (stock?.longName)!, count: 1, myPice: stock!.regularMarketPrice, rMP: stock!.regularMarketPrice, rMPL: stock!.regularMarketDayLow, rMPH: stock!.regularMarketDayHigh, wL: stock!.fiftyTwoWeekLow, wH: stock!.fiftyTwoWeekHigh)
                StockViewController.stocksCart.append(s)
                PersistenceService.shared.saveContext()
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
}

// MARK: Table View Controller
extension StockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetch.fetchedResultController.sections?[0].numberOfObjects {
            return count
        }
        return 0
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
        
        if let s = fetch.fetchedResultController.object(at: indexPath) as? Stocks {
            DispatchQueue.main.async {
                cell.stockLabel.text = s.symbol
                cell.stockSublabel.text = s.longName
                cell.stockCost.text = "\(s.regularMarketPrice)"
            }
        }
        
        return cell
    }
}

extension StockViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "DetailStockViewController") as! DetailStockViewController
        if let stock = fetch.fetchedResultController.object(at: indexPath) as? Stocks {
            secondVC.regularPriceLow = stock.regularMarketDayLow
            secondVC.regularPriceHigh = stock.regularMarketDayHigh
            secondVC.weekRangePriceLow = stock.fiftyTwoWeekLow
            secondVC.weekRangePriceHigh = stock.fiftyTwoWeekHigh
            secondVC.symbol = stock.symbol!
            secondVC.longname = stock.longName!
        }
        show(secondVC, sender: self)
    }
}
