//
//  ViewController.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 05.03.2021.
//

import UIKit
//extension UISegmentedControl {
//
//    func removeBorder(){
//
//        self.tintColor = UIColor.clear
//        self.backgroundColor = UIColor.clear
//        self.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor : UIColor.blue], for: .selected)
//        self.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor : UIColor.gray], for: .normal)
//        if #available(iOS 13.0, *) {
//            self.selectedSegmentTintColor = UIColor.clear
//        }
//
//    }
//
//    func setupSegment() {
//        self.removeBorder()
//        let segmentUnderlineWidth: CGFloat = self.bounds.width
//        let segmentUnderlineHeight: CGFloat = 2.0
//        let segmentUnderlineXPosition = self.bounds.minX
//        let segmentUnderLineYPosition = self.bounds.size.height - 1.0
//        let segmentUnderlineFrame = CGRect(x: segmentUnderlineXPosition, y: segmentUnderLineYPosition, width: segmentUnderlineWidth, height: segmentUnderlineHeight)
//        let segmentUnderline = UIView(frame: segmentUnderlineFrame)
//        segmentUnderline.backgroundColor = UIColor.clear
//
//        self.addSubview(segmentUnderline)
//        self.addUnderlineForSelectedSegment()
//    }
//
//    func addUnderlineForSelectedSegment(){
//
//        let underlineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
//        let underlineHeight: CGFloat = 2.0
//        let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth))
//        let underLineYPosition = self.bounds.size.height - 1.0
//        let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
//        let underline = UIView(frame: underlineFrame)
//        underline.backgroundColor = UIColor.blue
//        underline.tag = 1
//        self.addSubview(underline)
//
//
//    }
//
//    func changeUnderlinePosition(){
//        guard let underline = self.viewWithTag(1) else {return}
//        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
//        underline.frame.origin.x = underlineFinalXPosition
//
//    }
//}
class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var segmentedController: UISegmentedControl!
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
        let selectedIndex = self.segmentedController.selectedSegmentIndex
        switch selectedIndex {
        case 0:
            return stocks.count
        case 1:
            
            return favorite.count
        default:
            return 0
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
    
    @IBAction func segmented(_ sender: UISegmentedControl) {
        self.table.reloadData()
//        segmentedController.changeUnderlinePosition()
    }
    
}

//struct Stock {
//
//}

