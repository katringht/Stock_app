//
//  ViewController.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 05.03.2021.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var field: UITextField!
    @IBOutlet var table: UITableView!
    var stocks = [Stock]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        field.delegate = self
        
        let imageView = UIImageView()
        let image = UIImage(systemName: "magnifyingglass")
        imageView.image = image
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        field.layer.cornerRadius = 25
        field.layer.borderWidth = 0.8
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0.0)
        field.layer.masksToBounds = true
        field.textColor = UIColor.black
        field.attributedPlaceholder = NSAttributedString(string: "Find company or ticker", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        field.leftView = imageView
        field.leftViewMode = .always
        field.leftView?.tintColor = UIColor.black
//        field.frame = CGRect(x: 10, y: 0, width: 20, height: 20)

        
//        table.register(StocksCell.nib(), forCellReuseIdentifier: StocksCell.identifier)
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        
        
        let urlString: String
        urlString = "https://mboum.com/api/v1/co/collections/?list=day_gainers&start=1&apikey=demo"
        
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                parse(json: data)
                return
            }
        }

    }
    //field
    func textFieldShouldReturn(_ textField: UITextField)-> Bool {
        search()
        
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func search() {
        
    }
    
    //table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "stocksCell") as! StocksCell
//        cell.configure(with: stocks[indexPath.row])
        let stock: Stock
        stock = stocks[indexPath.row]

        cell.shortLabel?.text? = stock.symbol
        cell.fullLabel?.text? = stock.longName
        cell.regularPrice?.text? = stock.regularMarketPrice
        cell.priceChange?.text? = stock.regularMarketDayRange
        
        cell.stoksView.layer.cornerRadius = cell.frame.height / 2.5

        //        cell.imageStock.layer.cornerRadius = cell.frame.height / 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Stocks.self, from: json) {
            stocks = jsonPetitions.quotes
            //                tableView.reloadData()
        }
    }
    
}


