//
//  DataModel.swift
//  Mezza
//
//  Created by Alex Mitchell on 2017-01-17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import Foundation
import Firebase

class DataModel {
    
    static var shared = DataModel()
    var productsArray = [Product]()
    var inventoryArray = [Product]()
    
    var homeFeedVC: HomeFeedViewController!
    var inventoryFeedVC: InventoryViewController!
    
    var loggedInUser = String()
    
    
    // MARK: Functions
    
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
    
    
    
    // MARK: FireBase Functions
    //PAUL
    func listenForChangesHF(callingViewController: HomeFeedViewController) {
        homeFeedVC = callingViewController
        let products = FIRDatabase.database().reference(withPath: "products")
        
        
        products.observe(.value, with: didUpdateProducts)
    }
    
    //New
    func listenForUserInventory(callingViewController: InventoryViewController) {
        
        inventoryFeedVC = callingViewController
        let ref = FIRDatabase.database().reference(withPath: "products")
        let query = ref.queryOrdered(byChild: "sellerUID").queryEqual(toValue: loggedInUser)
        query.observeSingleEvent(of: .value, with: didUpdateInventory)
        
    }
    
    //NEW - ED AMAN
    func didUpdateInventory(snapshot: FIRDataSnapshot) {
        inventoryArray.removeAll()
        
        let productDict = snapshot
        
        for product in productDict.children {
            let newProduct = Product(snapshot: product as! FIRDataSnapshot)
            inventoryArray.append(newProduct)
        }
        
        inventoryFeedVC.reload()
    }
    
    
    // TESTING ----- AMAN
//    func listenForChangesUF(callingViewController: InventoryViewController) {
//        inventoryFeedVC = callingViewController
//        
//        let products = FIRDatabase.database().reference(withPath: "products")
//        
//        products.observe(.value, with: didUpdateProducts2)
//    }
//    
    
    //PAUL
    func didUpdateProducts(snapshot: FIRDataSnapshot) {
        
        productsArray.removeAll()
        
        let dict = snapshot
        
        for product in dict.children {
            let newProduct = Product(snapshot: product as! FIRDataSnapshot)
            productsArray.append(newProduct)
            
        }
        homeFeedVC.reload()
    }
    
    
    // TESTING------AMAN
//    func didUpdateProducts2(snapshot: FIRDataSnapshot) {
//        productsArray.removeAll()
//        
//        let productDict = snapshot
//        
//        for product in productDict.children {
//            let newProduct = Product(snapshot: product as! FIRDataSnapshot)
//            productsArray.append(newProduct)
//        }
//        
//        inventoryFeedVC.reload()
//    }
    
    
    //PAUL
    func fetchUser(UID: String, completionHandler: @escaping (User) -> ()){
        var user: User?
        let ref = FIRDatabase.database().reference()
        ref.child("users").child(UID).observeSingleEvent(of: .value, with: { (snapshot) in
            let newUser = User(snapshot: snapshot)
            user = newUser
            completionHandler(user!)
        })
        
    }

}

