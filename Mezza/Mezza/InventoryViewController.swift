//
//  UserFeedViewController.swift
//  Mezza
//
//  Created by Aman Singh on 1/18/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit

class InventoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    var inventoryProduct: Product?
    
        override func viewDidLoad() {
        super.viewDidLoad()
        DataModel.shared.listenForUserInventory(callingViewController: self)

    }
    
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemVC = UIStoryboard.init(name: "UserFeedStoryboard", bundle: nil).instantiateInitialViewController() as! InventoryViewController
        
        let inventoryArray = DataModel.shared.inventoryArray
        inventoryProduct = inventoryArray[indexPath.row]
        
        self.present(itemVC, animated: true, completion: nil)
    }
  
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataModel.shared.inventoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "UserFeedCell", for: indexPath) as! InventoryCollectionViewCell
        
        let inventoryArray = DataModel.shared.inventoryArray
        let images = inventoryArray[indexPath.row].images
        
        let imageString = images[0]
        
        DataModel.shared.fetchImage(stringURL: imageString, completionHandler: { image in
            
            cell.itemImageView.image = image
        })

        
        cell.titleLabel.text = inventoryArray[indexPath.row].title
        
        return cell
    }
    
    
    func reload() {
        myCollectionView.reloadData()
    }

}
