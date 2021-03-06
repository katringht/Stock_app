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
    @IBOutlet var imageStock: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
