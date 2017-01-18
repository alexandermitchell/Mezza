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
        
        fetchImage(stringURL: imageString, completionHandler: { image in
            
            cell.itemImageView.image = image
        })

        
        cell.titleLabel.text = productsArray[indexPath.row].title
        
        return cell
        
        
    }
    
    func reload() {
        homeFeedCV.reloadData()
    }
    
    func fetchImage(stringURL: String, completionHandler: @escaping (UIImage?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            let url = URL(string: stringURL)!
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                guard let responseData = data else {
                    completionHandler(nil)
                    return
                }
                let image = UIImage(data: responseData)
                DispatchQueue.main.async {
                    completionHandler(image)
                }
                }.resume()
        }
    }
    
    


}
