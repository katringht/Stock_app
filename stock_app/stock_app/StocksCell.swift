//
//  StocksCell.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 06.03.2021.
//

import UIKit

class StocksCell: UITableViewCell {

    @IBOutlet var stoksView: UIView!
    @IBOutlet var shortLabel: UILabel!
    @IBOutlet var fullLabel: UILabel!
    @IBOutlet var regularPrice: UILabel!
    @IBOutlet var priceChange: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

//    static let identifier = "stocksCell"
//    
//    static func nib() -> UINib{
//        return UINib(nibName: "stocksCell", bundle: nil)
//    }
//    
//    func configure(with model: Stock) {
//        self.shortLabel.text = model.symbol
//        self.fullLabel.text = model.longName
//        self.imageStock.image = UIImage(named: "NIKE")
//        
//    }
}
