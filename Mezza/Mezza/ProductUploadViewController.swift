//
//  ProductUploadViewController.swift
//  Mezza
//
//  Created by Edward Han on 1/19/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//
import UIKit


protocol EnterSizePopUpDelegate: class {
    func showPopUp()
    func addSize(addedSize: Product.Size)
    
}


class ProductUploadViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate, EnterSizePopUpDelegate {
    
    var editingMode = false
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
            if selectedProduct != nil {
                sizeArray = (selectedProduct?.sizes)!
            }
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "sizeCell") as! SizeCellTableViewCell
            cell.priceLabel.text = String(describing: sizeArray[indexPath.row].price)
            cell.quantityLabel.text = String(describing: sizeArray[indexPath.row].quantity)
            cell.sizeLabel.text = sizeArray[indexPath.row].name
            
            return cell
    
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
    
    
    
    func addSize(addedSize: Product.Size) {
        sizeArray.append(addedSize)
        sizePriceQuantTableView.reloadData()
        print(sizeArray[0].name)
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
        
        return sizeArray.count
        
        
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
        
        imageViewArray = [mainImageView, imageView1, imageView2, imageView3, imageView4]
        
        
        for imageView in imageViewArray! {
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            imageView.addGestureRecognizer(tap)

        }
        

        if let product = selectedProduct {
            openImageViewIndex = product.images.count
            for i in 1...openImageViewIndex {
//                imageViewArray[i-1] = product.images
                let photoURL = product.images[i]
                DataModel.shared.fetchImage(stringURL: photoURL) { image in
                    self.imageViewArray?[i].image = image
                }
              
                            //            imageViewArray?[openImageViewIndex].addGestureRecognizer(tap)
                
                
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

            


            
            
            //            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
                        //         imageViewArray?[openImageViewIndex].addGestureRecognizer(tap)
            //            imageViewArray?[openImageViewIndex].isUserInteractionEnabled = true

            
        }
        
        for i in 0...(openImageViewIndex - 1) {
            
            
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
