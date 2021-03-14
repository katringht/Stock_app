//
//  ViewController.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 05.03.2021.
//

import UIKit
class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
//    @IBOutlet var segmentedController: UISegmentedControl!
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var stackSegmView: UIStackView!
    @IBOutlet var stocksBtn: UIButton!
    @IBOutlet var field: UITextField!
    @IBOutlet var table: UITableView!
    
    var stocks = [Stock]()
    var favorite = ["sss", "ppp"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        field.delegate = self
        

//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
//        let image = UIImage(systemName: "magnifyingglass")
//        imageView.image = image
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        field.layer.cornerRadius = 25
        field.layer.borderWidth = 0.8
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.masksToBounds = true
        field.textColor = UIColor.black
        field.attributedPlaceholder = NSAttributedString(string: "Find company or ticket", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
//        field.leftView = imageView
//        field.leftViewMode = .always
//        field.leftView?.tintColor = UIColor.black

        
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        
        stocksBtn.titleLabel?.font = UIFont(name: "Hiragino Sans W6", size: 30)
//        updateNavButtonsDesign()
        
//        segmentedController.addUnderlineForSelectedSegment()
        
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
//        let selectedIndex = self.segmentedController.selectedSegmentIndex
//        switch selectedIndex {
//        case 0:
//            return stocks.count
//        case 1:
//
//            return favorite.count
//        default:
//            return 0
//        }
        
        if stocksBtn.isSelected{
            return stocks.count
        } else {
            return favorite.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "stocksCell") as! StocksCell
        let stock: Stock
        stock = stocks[indexPath.row]
        
        cell.shortLabel?.text? = stock.symbol
        cell.fullLabel?.text? = stock.longName
        cell.changePrice?.text? = stock.regularMarketDayRange
        cell.regularPrice?.text? = "$\(String(stock.regularMarketPrice))"

        cell.stoksView.layer.cornerRadius = cell.frame.height * 0.3
        cell.stoksView.backgroundColor = ((indexPath.row % 2) != 0) ? UIColor.white : UIColor.systemGray6
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Stocks.self, from: json) {
            stocks = jsonPetitions.quotes
//            tableView.reloadData()
        }
    }
    
    func fillNavButton(button: UIButton, choosed: Bool) {
        if choosed {
            button.titleLabel?.font = UIFont(name: "Hiragino Sans W6", size: 30)
            button.setTitleColor(UIColor.black, for: .normal)
        } else {
            button.titleLabel?.font = UIFont(name: "Hiragino Sans W6", size: 25)
            button.setTitleColor(UIColor.lightGray, for: .normal)
        }
    }

//    func updateNavButtonsDesign() {
//        if stocksBtn.isSelected {
//            fillNavButton(button: stocksBtn, choosed: true)
//            fillNavButton(button: favoriteButton, choosed: false)
//        }
//        else {
//            fillNavButton(button: stocksBtn, choosed: false)
//            fillNavButton(button: favoriteButton, choosed: true)
//        }
//    }
    
//    @IBAction func segmented(_ sender: UISegmentedControl) {
//        self.table.reloadData()
//    }
    
    @IBAction func segmentationViews(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
//        self.table.reloadData()
        if stocksBtn.isSelected{
            stocksBtn.titleLabel?.font = UIFont(name: "Hiragino Sans W6", size: 30)
            stocksBtn.setTitleColor(UIColor.black, for: .normal)
            favoriteButton.titleLabel?.font = UIFont(name: "Hiragino Sans W6", size: 25)
            favoriteButton.setTitleColor(UIColor.lightGray, for: .normal)
            favoriteButton.isSelected = false
//            fillNavButton(button: stocksBtn, choosed: true)
//            fillNavButton(button: favoriteButton, choosed: false)
            
            self.table.reloadData()
        } else if favoriteButton.isSelected {
//            fillNavButton(button: stocksBtn, choosed: false)
//            fillNavButton(button: favoriteButton, choosed: true)
            favoriteButton.titleLabel?.font = UIFont(name: "Hiragino Sans W6", size: 30)
            favoriteButton.setTitleColor(UIColor.black, for: .normal)
            stocksBtn.titleLabel?.font = UIFont(name: "Hiragino Sans W6", size: 25)
            stocksBtn.setTitleColor(UIColor.lightGray, for: .normal)
            stocksBtn.isSelected = false
            self.table.reloadData()
        }
        
    }
    
}
