//
//  ViewController.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 05.03.2021.
//

import UIKit
class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate {
    
    
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var tabBarView: UIView!
    @IBOutlet var stackSegmView: UIStackView!
    @IBOutlet var stocksBtn: UIButton!
    @IBOutlet var field: UITextField!
    @IBOutlet var table: UITableView!
    var defaultOffSet: CGPoint?

    
    var stocks = [Stock]()
    var filterPetitions = [Stock]()
    var favorite = ["sss", "ppp"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        field.delegate = self
        
//        table.contentInset = UIEdgeInsetsMake(collectionView.size.height, 0, 0, 0)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(systemName: "magnifyingglass")
        imageView.image = image
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)

        
        field.layer.cornerRadius = 15
        field.layer.borderWidth = 0.8
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.masksToBounds = true
        field.textColor = UIColor.black
        field.attributedPlaceholder = NSAttributedString(string: "Find company or ticket", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        field.leftView = imageView
        field.leftViewMode = .always
        field.leftView?.tintColor = UIColor.black
        
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        
        //        favoriteButton.isSelected = true
//                stocksBtn.isSelected = true
        
        stocksBtn.titleLabel?.font = UIFont(name: "Hiragino Sans W6", size: 30)
        stocksBtn.setTitleColor(UIColor.black, for: .normal)
        stocksBtn.tintColor = .clear
        favoriteButton.titleLabel?.font = UIFont(name: "Hiragino Sans W6", size: 25)
        favoriteButton.setTitleColor(UIColor.lightGray, for: .normal)
        favoriteButton.tintColor = .clear
        
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
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }

        return true
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func search(_ keyword: String) {
        for index in 0...stocks.count - 1{
            if stocks[index].longName.lowercased().contains(keyword.lowercased()){
                filterPetitions.append(stocks[index])
            }
        }
    }
    
    //table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if stocksBtn.isSelected{
            return stocks.count
        } else{
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
    
    @IBAction func segmentedView(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if favoriteButton.isSelected{
            favoriteButton.titleLabel?.font = UIFont(name: "Hiragino Sans W6", size: 30)
            favoriteButton.setTitleColor(UIColor.black, for: .normal)
            stocksBtn.titleLabel?.font = UIFont(name: "Hiragino Sans W6", size: 25)
            stocksBtn.setTitleColor(UIColor.lightGray, for: .normal)
            //            fillNavButton(button: stocksBtn, choosed: false)
            //            fillNavButton(button: favoriteButton, choosed: true)
            favoriteButton.tintColor = .clear
            
            favoriteButton.isSelected = false
            
            self.table.reloadData()
            
            UIView.animate(withDuration: 0.1){
                self.view.layoutIfNeeded()
            }
            
        }else if stocksBtn.isSelected {
            stocksBtn.tintColor = .clear
            //            fillNavButton(button: stocksBtn, choosed: true)
            //            fillNavButton(button: favoriteButton, choosed: false)
            stocksBtn.titleLabel?.font = UIFont(name: "Hiragino Sans W6", size: 30)
            stocksBtn.setTitleColor(UIColor.black, for: .normal)
            favoriteButton.titleLabel?.font = UIFont(name: "Hiragino Sans W6", size: 25)
            favoriteButton.setTitleColor(UIColor.lightGray, for: .normal)
            
            self.table.reloadData()
            
            stocksBtn.isSelected = false
            
            UIView.animate(withDuration: 0.1){
                self.view.layoutIfNeeded()
            }
        }
    }
    
    //scroll view
    
//    func changeTabBar(hidden:Bool, animated: Bool) {
//        guard let tabBar = field else {return}
//        if tabBar.isHidden == hidden{ return }
//        let frame = tabBar.frame
//
//        let offset = hidden ? frame.size.height : -frame.size.height
//        let duration:TimeInterval = (animated ? 0.5 : 0.0)
//        tabBar.isHidden = false
//
//        UIView.animate(withDuration: duration, animations: {
//            tabBar.frame = frame.offsetBy(dx: 0, dy: offset)
//        }, completion: { (true) in
//            tabBar.isHidden = hidden
//        })
//
//    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0{
//            changeTabBar(hidden: true, animated: true)
            tabBarView.isHidden = true
        }
        else{
//            changeTabBar(hidden: false, animated: true)
            tabBarView.isHidden = false
        }
    }
    
}

