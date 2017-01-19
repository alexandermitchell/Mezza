//
//  HomeFeedViewController.swift
//  Mezza
//
//  Created by Paul Jurczyk on 1/17/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit

class HomeFeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var homeFeedCV: UICollectionView!
    
    
    // unwind segue -> back button on item detail page
    @IBAction func unwindToFeed(segue: UIStoryboardSegue) {
    
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        DataModel.shared.listenForChangesHF(callingViewController: self)

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataModel.shared.productsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productsArray = DataModel.shared.productsArray
        let cell = homeFeedCV.dequeueReusableCell(withReuseIdentifier: "HomeFeedCell", for: indexPath) as! HomeFeedCollectionViewCell
        
        let images = productsArray[indexPath.row].images
        
        let imageString = images[0]
        
        DataModel.shared.fetchImage(stringURL: imageString, completionHandler: { image in
            
            cell.itemImageView.image = image
        })
        let UID = productsArray[indexPath.row].sellerUID
        DataModel.shared.fetchUser(UID: UID) { user in
            cell.artistLabel.text = user.name
        }
        
        cell.titleLabel.text = productsArray[indexPath.row].title
        
        return cell
        
        
    }
    
    func reload() {
        homeFeedCV.reloadData()
    }
    
    
    
    
    
    


}
