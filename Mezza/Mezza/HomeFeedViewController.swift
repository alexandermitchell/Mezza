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
    
    
    // MARK: Local Variables ----------------------------------------------------
    
    var selectedProduct: Product?
    

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
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        DataModel.shared.fetchImage(stringURL: imageString, completionHandler: { image in
            
            cell.itemImageView.image = image
            cell.itemImageView.layer.borderColor = UIColor.lightGray.cgColor
            cell.itemImageView.layer.borderWidth = 1
            //cell.itemImageView.layer.masksToBounds = true
            cell.titleLabel.text = productsArray[indexPath.row].title
            
            
            
            cell.infoWrapper.layer.borderWidth = 1
            cell.infoWrapper.layer.borderColor = UIColor.lightGray.cgColor
            cell.infoWrapper.layer.backgroundColor = UIColor(r: 232, g: 235, b: 240).cgColor
            let UID = productsArray[indexPath.row].sellerUID
            DataModel.shared.fetchUser(UID: UID) { user in
                cell.artistLabel.text = user.name
                dispatchGroup.leave()
            }
        })
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productsArray = DataModel.shared.productsArray
        selectedProduct = productsArray[indexPath.row]
        performSegue(withIdentifier: "HomeDetailsSegue", sender: self)
    }
    

    func reload() {
        homeFeedCV.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "HomeDetailsSegue") {
            let detailsViewController = segue.destination as! FeedItemDetailsViewController
            detailsViewController.selectedItem = selectedProduct
        }
    }
    
    
    
    


}
