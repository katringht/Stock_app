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
    @IBOutlet var favBtn: UIButton!
    @IBOutlet var changePrice: UILabel!
    
    var isFavorite: Bool = false
//    var favList: [Stock] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favBtn.tintColor = .systemGray2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func colorChangingBtn(_ sender: UIButton){
          sender.isSelected = !sender.isSelected
          if sender.isSelected{
            sender.tintColor = .systemYellow
            isFavorite = true
             }
          else{
            sender.tintColor = .systemGray2
            isFavorite = false
           }
       }
}
