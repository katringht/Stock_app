//
//  StocksCell.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 06.03.2021.
//

import UIKit

class StocksCell: UITableViewCell {

    @IBOutlet var stockView: UIView!
    @IBOutlet var stockCost: UILabel!
    @IBOutlet var stockLabel: UILabel!
    @IBOutlet var stockSublabel: UILabel!
    @IBOutlet var startFavoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
