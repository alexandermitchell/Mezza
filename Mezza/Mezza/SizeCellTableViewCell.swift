//
//  SizeCellTableViewCell.swift
//  Mezza
//
//  Created by Edward Han on 1/19/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit

class SizeCellTableViewCell: UITableViewCell {

    
    
    
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

