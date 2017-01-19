//
//  UserFeedViewController.swift
//  Mezza
//
//  Created by Aman Singh on 1/18/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit

class UserFeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
        override func viewDidLoad() {
        super.viewDidLoad()

        DataModel.shared.listenForChangesUF(callingViewController: self)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataModel.shared.productsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "UserFeedCell", for: indexPath) as! UserFeedCollectionViewCell
        
        let productsArray = DataModel.shared.productsArray
        let images = productsArray[indexPath.row].images
        
        let imageString = images[0]
        
        DataModel.shared.fetchImage(stringURL: imageString, completionHandler: { image in
            
            cell.itemImageView.image = image
        })
        
//        let UID = productsArray[indexPath.row].sellerUID
//        DataModel.shared.fetchUser(UID: UID) { user in
//            cell.artistLabel.text = user.name
//        }
        
        cell.titleLabel.text = productsArray[indexPath.row].title
        
        
        return cell
    }
    
    func reload() {
        myCollectionView.reloadData()
    }

}
