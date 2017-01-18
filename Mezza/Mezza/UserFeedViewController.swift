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

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "UserFeedCell", for: indexPath) as! UserFeedCollectionViewCell
        
        return cell
    }

}
