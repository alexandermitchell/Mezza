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
    
    // MARK: Firebase Create Functions
    
    func createOrder(buyerUID: String, productUID: String, seller: String, size: String, status: String, timestamp: Date) {
        
        let orderDict = [
            "buyer": buyerUID,
            "productUID" : productUID,
            "seller" : seller,
            "size" : size,
            "status" : status,
            "timestamp" : timestamp
        ] as [String : Any]
        
        
        let ordersRef = FIRDatabase.database().reference(withPath: "orders")
        let orderRef = ordersRef.childByAutoId()
        orderRef.setValue(orderDict)
        
    }
    
    
    
    // MARK: FireBase Listening Functions
    //PAUL
    func listenForChangesHF(callingViewController: HomeFeedViewController) {
        homeFeedVC = callingViewController
        let products = FIRDatabase.database().reference(withPath: "products")
        
        
        products.observe(.value, with: didUpdateProducts)
    }
    
    
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
    
    
    
    //PAUL
    func fetchUser(UID: String, completionHandler: @escaping (User) -> ()){
        let ref = FIRDatabase.database().reference()
        ref.child("users").child(UID).observeSingleEvent(of: .value, with: { (snapshot) in
            let newUser = User(snapshot: snapshot)
            completionHandler(newUser)
        })
        
    }

    
    //MARK: Observing Function for Inventory View Controller
    func listenForUserInventory(callingViewController: InventoryViewController) {
        
        inventoryFeedVC = callingViewController
        let ref = FIRDatabase.database().reference(withPath: "products")
        let query = ref.queryOrdered(byChild: "sellerUID").queryEqual(toValue: loggedInUser)
        query.observeSingleEvent(of: .value, with: didUpdateInventory)
        
    }
    
    //MARK: Updating Function for Inventory View Controller
    func didUpdateInventory(snapshot: FIRDataSnapshot) {
        inventoryArray.removeAll()
        
        let productDict = snapshot
        
        for product in productDict.children {
            let newProduct = Product(snapshot: product as! FIRDataSnapshot)
            inventoryArray.append(newProduct)
        }
        inventoryFeedVC.reload()
    }
    
    
    
    
}

