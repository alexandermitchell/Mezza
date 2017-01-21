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
    var similarProducts = [Product]()
    var cartItem: Product?
    
    var homeFeedVC: HomeFeedViewController!
    var inventoryFeedVC: InventoryViewController!
    var checkoutSuccessVC: CheckoutSuccessViewController!
    
    var loggedInUser: User?
    

    
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
    
    func createOrder(buyerUID: String, price: String, productUID: String, seller: String, size: String, status: String, timestamp: String) {
        
        let orderDict = [
            "buyer": buyerUID,
            "price": price,
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
    
    
    func createProduct(title: String, description: String, images: [String], sellerUID: String, sizes: [Product.Size]) {
        

        
        var imageDict = [String: String]()
        for (key, value)  in images.enumerated() {
            imageDict[String(key)] = value
        }
        
        
        var sizeDictManual = [String: Any]()
        
        
        for size in sizes {
            let key = size.name
            let miniDict = [
                "price" : size.price,
                "quantity": size.quantity
                ] as [String: Any]
            sizeDictManual[key] = miniDict
        }
        
        
        let dict = [
            "description" : description,
            "sellerUID" : sellerUID,
            "title" : title,
            "images": imageDict,
            "sizes": 0
            ] as [String : Any]
    
        
        let productsRef = FIRDatabase.database().reference(withPath: "products")
        
        let productRef = productsRef.childByAutoId()
        productRef.setValue(dict)
        
        print(productRef.key)
        
     
        let sizesRef = productRef.child("sizes")
        
        for size in sizes {
            let sizeRef = sizesRef.child(size.name)
            let sizeDict = [
                "price" : size.price,
                "quantity": size.quantity
            ] as [String : Any]
            
            sizeRef.setValue(sizeDict)
        }
        
        
        

        
        
        
        
        
        
        
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
        
        let userUID = DataModel.shared.loggedInUser?.uid
        inventoryFeedVC = callingViewController
        let ref = FIRDatabase.database().reference(withPath: "products")
        let query = ref.queryOrdered(byChild: "sellerUID").queryEqual(toValue: userUID)
        query.observeSingleEvent(of: .value, with: didUpdateInventory)
        
    }
    
    func listenForSimilarProducts(sellerUID: String, callingViewController: CheckoutSuccessViewController) {
        checkoutSuccessVC = callingViewController
        
        let ref = FIRDatabase.database().reference(withPath: "products")
        let query = ref.queryOrdered(byChild: "sellerUID").queryEqual(toValue: sellerUID)
        query.observeSingleEvent(of: .value, with: didUpdateSimilarProducts)
        
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
    
    func didUpdateSimilarProducts(snapshot: FIRDataSnapshot) {
        inventoryArray.removeAll()
        
        let productDict = snapshot
        
        for product in productDict.children {
            let newProduct = Product(snapshot: product as! FIRDataSnapshot)
            
            if !(newProduct.uid == cartItem?.uid) {
            similarProducts.append(newProduct)
            }
        }
        checkoutSuccessVC.reload()
    }
    
}
