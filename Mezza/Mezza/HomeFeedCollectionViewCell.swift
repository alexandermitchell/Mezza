//
//  HomeFeedCollectionViewCell.swift
//  Mezza
//
//  Created by Alex Mitchell on 2017-01-17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit

class HomeFeedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var infoWrapper: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareForReuse()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = ""
        self.artistLabel.text = ""
        self.itemImageView.image = nil
    }
    
}
