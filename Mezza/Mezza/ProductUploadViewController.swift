//
//  ProductUploadViewController.swift
//  Mezza
//
//  Created by Edward Han on 1/19/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//
import UIKit

import Firebase

protocol EnterSizePopUpDelegate: class {
    func showPopUp()
    func addSize(addedSize: Product.Size)
    func replaceSize(editedSize: Product.Size, index: Int)
    
}


class ProductUploadViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate, EnterSizePopUpDelegate, UITextViewDelegate {
    
    
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    var editingMode: Bool {
        if let _ = selectedProduct {
            return true
        }
        
        else {
            return false
        }
    }
    
    
    var imageTapped = false
    var selectedProduct: Product?
    
    
    var openImageViewIndex: Int = 0
    //    {
    //        if let product = selectedProduct {
    //            return product.images.count
    //        }
    //        else {
    //            return 0
    //        }
    //    }
    
    
    var selectedImageIndex: Int = 0
    
    @IBOutlet weak var addSizeButton: UIButton!
    
    @IBOutlet weak var titleField: UITextField!
    
    
    @IBOutlet weak var artistField: UITextField!
    
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    var imageViewArray: [UIImageView]?
    
    var sizeArray: [Product.Size] = []
    
    
    @IBOutlet weak var descriptonField: UITextView!
  
    
    @IBOutlet weak var sizePriceQuantTableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        guard let _ = selectedProduct else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "sizeCell") as! SizeCellTableViewCell
//            return cell
//            
//        }
//        
//        if sizeArray != nil {
//            
//            let cell = tableView.dequeueReusableCell(withIdentifier: "sizeCell") as! SizeCellTableViewCell
//            cell.priceLabel.text = String(describing: sizeArray?[indexPath.row].price)
//            cell.quantityLabel.text = String(describing: sizeArray?[indexPath.row].quantity)
//            cell.sizeLabel.text = sizeArray?[indexPath.row].name
//            
//            return cell
//            
//            
//        }
        
        if sizeArray.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sizeCell") as! SizeCellTableViewCell
            return cell
        }
        
        else {
//            if selectedProduct != nil {
//                sizeArray = (selectedProduct?.sizes)!
//            }
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "sizeCell") as! SizeCellTableViewCell
            cell.priceLabel.text = String(describing: sizeArray[indexPath.row].price)
            cell.quantityLabel.text = String(describing: sizeArray[indexPath.row].quantity)
            cell.sizeLabel.text = sizeArray[indexPath.row].name
            
            return cell
    
        }


        
        
        

        
        
    }
    
    func loadTextViewPlaceHolder(){
        descriptonField.text = "Enter Description"
        descriptonField.textColor = UIColor.lightGray
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            loadTextViewPlaceHolder()
        }
    }
    
    
    func showPopUp(){
        
        let popVC = UIStoryboard(name: "UploadInventory", bundle: nil).instantiateViewController(withIdentifier: "enterSizePopUp") as! EnterSizeViewController
        popVC.delegate = self
        self.addChildViewController(popVC)
        popVC.view.frame = self.view.frame
        self.view.addSubview(popVC.view)
        popVC.didMove(toParentViewController: self)
    }
    
    func showPopUpEdit(sizePriceQuant: Product.Size, index: Int) {
        
        let popVC = UIStoryboard(name: "UploadInventory", bundle: nil).instantiateViewController(withIdentifier: "enterSizePopUp") as! EnterSizeViewController
        popVC.delegate = self

        
        popVC.passedSize = sizePriceQuant
        popVC.selectedIndex = index
        print(index)
        
        
        self.addChildViewController(popVC)
        popVC.view.frame = self.view.frame
        self.view.addSubview(popVC.view)
        popVC.didMove(toParentViewController: self)
        
        
        
    }
    
    
    
    func addSize(addedSize: Product.Size) {
        sizeArray.append(addedSize)
        sizePriceQuantTableView.reloadData()
        print(sizeArray[0].name)
    }
    
    
    
    func replaceSize(editedSize: Product.Size, index: Int) {
        sizeArray[index] = editedSize
        sizePriceQuantTableView.reloadData()
        
    }
    
    @IBAction func enterSize(_ sender: Any) {
        
        showPopUp()
        
        
    
    }

    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if let product = selectedProduct {
//            return product.sizes.count
//        }
//        else {
//            return 1
//        }
        
//        if sizeArray.count > 0 {
//            return sizeArray.count
//        }
//        
//        else {
//            return 1
//        }
        
        
        
        return sizeArray.count
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedSize = sizeArray[indexPath.row]
        
        print(indexPath.row)
        print(selectedSize.name)
            
        showPopUpEdit(sizePriceQuant: selectedSize, index: indexPath.row)
        print(indexPath.row)
        
        
        
    }
    
    
    
    @IBAction func addPhoto(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            
//            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//            imageViewArray?[openImageViewIndex].isUserInteractionEnabled = true
//            imageViewArray?[openImageViewIndex].addGestureRecognizer(tap)
//            
            imageViewArray?[openImageViewIndex].image = selectedImage
            if openImageViewIndex < 4 {
                openImageViewIndex += 1
            }
            updateImageTouch()
            
            
            
        }
    
        
        dismiss(animated: true, completion: nil)
    }
   
    

    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        
        
        loadTextViewPlaceHolder()
        
        
        addSizeButton.layer.borderWidth = 5
        addSizeButton.layer.cornerRadius = addSizeButton.bounds.size.width / 2
        addSizeButton.layer.borderColor = UIColor.blue.cgColor
        addSizeButton.clipsToBounds = true
        
        imageViewArray = [mainImageView, imageView1, imageView2, imageView3, imageView4]
        
        
        for imageView in imageViewArray! {
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            imageView.addGestureRecognizer(tap)

        }
        

        if let product = selectedProduct {
            
            titleField.text = product.title
            descriptonField.text = product.description
            sizeArray = product.sizes
            sizePriceQuantTableView.reloadData()
            
            
        
            sizeArray = product.sizes
            
            sizePriceQuantTableView.reloadData()
            
            
            for i in 0...(product.images.count - 1) {
                if product.images[i] != "" {
                    openImageViewIndex = i
                }
            }
            
            
            var lastImageIndex = 0
            
            if openImageViewIndex != 0 {
                lastImageIndex = openImageViewIndex - 1
            }
            
            for i in 0...lastImageIndex {
//                imageViewArray[i-1] = product.images
                let photoURL = product.images[i]
                DataModel.shared.fetchImage(stringURL: photoURL) { image in
                    self.imageViewArray?[i].image = image
                }
            }
            
            updateImageTouch()
        }
        
    
        
     
        
        
        
        
        
        //        tappedMessage.isUserInteractionEnabled = true
        
        
        //        tappedMessage.addGestureRecognizer(tap)

    }
    
    
    func updateImages(index: Int) {
        let lastImageViewIndex = openImageViewIndex - 1
        
        for i in selectedImageIndex...lastImageViewIndex {
            imageViewArray?[i].image = imageViewArray?[i+1].image
        }

        openImageViewIndex = lastImageViewIndex
        
        updateImageTouch()
        
        
    }
    
    
    func updateImageTouch(){
        for i in openImageViewIndex...4 {
            
            imageViewArray?[i].isUserInteractionEnabled = false

        }
        
        if openImageViewIndex == 0 {
            return
        }
        
        else {
            
            for i in 0...(openImageViewIndex - 1) {
                imageViewArray?[i].isUserInteractionEnabled = true
            }
            
        }
        
        
    }
    
    
    
    
    @IBAction func save(_ sender: Any) {
        
        print(editingMode)
        
        
        let title = titleField.text
        let artist = artistField.text
        let description = descriptonField.text
        
        var imagesArray = [UIImage?]()
        for imageView in imageViewArray! {
            if let image = imageView.image {
            imagesArray.append(image)
            }
        }
        
        var imagesURL = ["","","","",""]
        let imagesArrayLastIndex = imagesArray.count - 1
        
        
        if title == "" || artist == "" || description == "" {
            alert(message: "please fill out all the fields")
            return
        }
        
        if imagesArray.count == 0 {
            alert(message: "please add images")
            return
        }
        
        if sizeArray.count == 0 {
            alert(message: "please add sizes, prices, quantity")
            return
        }
        
        
        
        
        let dispatchGroup = DispatchGroup()
        
        for i in 0...imagesArrayLastIndex {
            var data = Data()
            data = UIImageJPEGRepresentation(imagesArray[i]!, 0.1)!
            let storageRef = FIRStorage.storage().reference()
            let imageUID = NSUUID().uuidString
            let imageRef = storageRef.child(imageUID)
            dispatchGroup.enter()
        imageRef.put(data, metadata: nil).observe(.success) { (snapshot) in
                let imageURL = snapshot.metadata?.downloadURL()?.absoluteString
                imagesURL[i] = imageURL!
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main){
            
            print("done")

            
            
            if let product = self.selectedProduct {
                
                DataModel.shared.editProduct(uid: product.uid, title: title!, description: description!, images: imagesURL, sellerUID: product.sellerUID, sizes: self.sizeArray)
                
                
                self.selectedProduct?.images = imagesURL
                self.selectedProduct?.title = title!
                self.selectedProduct?.sizes = self.sizeArray
                self.selectedProduct?.description = description!
                
                self.performSegue(withIdentifier: "toDetail", sender: nil)
                
            }
            
            
            if self.editingMode == false {
                
                
                DataModel.shared.createProduct(title: title!, description: description!, images: imagesURL, sellerUID: (DataModel.shared.loggedInUser?.uid)!, sizes: self.sizeArray)
                
                
                self.performSegue(withIdentifier: "toInventory", sender: nil)
                
                
            }

            
            
        }
        

        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetail" {
            
            let newVC = segue.destination as! FeedItemDetailsViewController
            newVC.selectedItem = selectedProduct
        }
    }
    
    
    
    
    
    
    
    
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        
        let view = sender.view as! UIImageView
        
        if imageTapped {
            let secondImageView = view
            
            if secondImageView.tag == selectedImageIndex {
                secondImageView.image = nil
                secondImageView.layer.borderColor = nil
                updateImages(index: selectedImageIndex)
                UIView.animate(withDuration: 1.0){
                    view.layer.borderColor = nil
                }
            
            }
            
            else {
                let firstImage = imageViewArray?[selectedImageIndex].image
                let secondImage = secondImageView.image
                secondImageView.image = firstImage
                imageViewArray?[selectedImageIndex].image = secondImage
                view.layer.borderColor = UIColor.green.cgColor
                
                UIView.animate(withDuration: 1.0){
                    view.layer.borderColor = nil
                    self.imageViewArray?[self.selectedImageIndex].layer.borderColor = nil
                }
            
            }
            
        }
        
        else {
            selectedImageIndex = view.tag
            print(selectedImageIndex)
            
            view.layer.borderColor = UIColor.red.cgColor
            view.layer.borderWidth = 5
            
        }

        imageTapped = !imageTapped
        
        
    }
}
