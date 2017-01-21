//
//  CheckoutSuccessViewController.swift
//  Mezza
//
//  Created by Alex Mitchell on 2017-01-21.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit

class CheckoutSuccessViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: IBOutlets ---------------------
    
    @IBOutlet weak var successWrapper: UIView!
    
    
    @IBOutlet weak var successLabel: UILabel!
    
    
    @IBOutlet weak var similarCV: UICollectionView!
    
    var seller: String?
    
    // MARK: Collection View Functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataModel.shared.similarProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let similarProducts = DataModel.shared.similarProducts
        let cell = similarCV.dequeueReusableCell(withReuseIdentifier: "similarCell", for: indexPath) as! CheckoutSuccessCollectionViewCell
        
        let images = similarProducts[indexPath.row].images
        
        let imageString = images[0]
        
        DataModel.shared.fetchImage(stringURL: imageString, completionHandler: { image in
            
            cell.productImage.image = image
        })
        
        cell.titleLabel.text = similarProducts[indexPath.row].title
        
        
        return cell

    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        
        DataModel.shared.listenForSimilarProducts(sellerUID: seller!, callingViewController: self)
        
    }
    
    func reload() {
        similarCV.reloadData()
    }

}
