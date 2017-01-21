//
//  OrdersTableViewCell.swift
//  Mezza
//
//  Created by Paul Jurczyk on 1/20/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {
    
    
    // MARK: IBOutlets --------------------
    
    @IBOutlet weak var orderImageView: UIImageView!
    
   
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var orderStatusLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
