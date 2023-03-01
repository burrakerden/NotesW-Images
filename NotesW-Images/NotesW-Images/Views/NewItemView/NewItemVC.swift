//
//  NewItemVC.swift
//  NotesW-Images
//
//  Created by Burak Erden on 28.02.2023.
//

import UIKit

class NewItemVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var newName: UITextField!
    @IBOutlet weak var newSize: UITextField!
    @IBOutlet weak var newPrice: UITextField!
    
    var newItemVCModel = NewItemVCViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGesture()
        newImage.image = UIImage(named: "demoImage")
        setupKeyboardHiding()
        }
    
    
    func addData() {
        if let price = Double(newPrice.text!) {
            newItemVCModel.addData(name: newName.text!, price: price, size: newSize.text!, image: (newImage.image?.jpegData(compressionQuality: 0.5))!)
        } else {
            alert(message: "Please enter valid number in the price area")
        }
    }
    
    //MARK: - Keyboard And ImagePicking Gestures
    
    func setupGesture() {
        newImage.isUserInteractionEnabled = true
        let gestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        let gestureRecogniserKeyboard = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        newImage.addGestureRecognizer(gestureRecogniser)
        view.addGestureRecognizer(gestureRecogniserKeyboard)
    }
    
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        newImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - Save Button
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if newImage.image == UIImage(named: "demoImage") {
            alert(message: "Image cannot be empty!")
        } else if newName.text == "" {
            alert(message: "Name cannot be empty!")
        } else if newSize.text == "" {
            alert(message: "Size cannot be empty!")
        } else if newPrice.text == "" {
            alert(message: "Price cannot be empty!")
        } else {
            addData()
            navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: - Alert Func
    
    func alert(message: String) {
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}


