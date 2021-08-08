//
//  ViewController.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 05.03.2021.
//

import UIKit
class StockViewController: UIViewController{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var accountButton: UIButton!
    @IBOutlet var stocksButton: UIButton!
    @IBOutlet var favoriteButton: UIButton!
    
    var screenEnum: ScreenCategory = .stockScreen
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//        view.addGestureRecognizer(tapGesture)
        
        stocksButton.setSelectedColor()
        favoriteButton.setDeselectedColor()
        
// "https://mboum.com/api/v1/co/collections/?list=day_gainers&start=1&apikey=demo"
        
// MARK: Button actions
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func stockButton(_ sender: Any) {
        screenEnum = .stockScreen
        stocksButton.setSelectedColor()
        favoriteButton.setDeselectedColor()
        tableView.reloadData()
    }
    
    @IBAction func favoriteButton(_ sender: Any) {
        screenEnum = .favoriteScreen
        stocksButton.setDeselectedColor()
        favoriteButton.setSelectedColor()
        tableView.reloadData()
        
    }
    @IBAction func accountButton(_ sender: Any) {
        // delete our default login
        UserDefaults.standard.set(false, forKey: "USERDEFAULTLOGIN")

        navigationController?.popViewController(animated: true)
        
    }
}

// MARK: Table View Controller
extension StockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if screenEnum == .favoriteScreen {
            return 0
        } else {
            return 10
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath) as! StocksCell
        cell.stockView.layer.cornerRadius = cell.frame.height * 0.2
        cell.stockView.backgroundColor = ((indexPath.row % 2) != 0) ?
            UIColor.white : UIColor.systemGray6
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .none
        cell.selectedBackgroundView = backgroundView
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
