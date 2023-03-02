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
    @IBOutlet weak var saveButton: UIButton!
    
    var newItemVCModel = NewItemVCViewModel()
    var model = MainViewModel()
    var indexPath: Int?
    
    //MARK: - Licecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGesture()
        setupKeyboardHiding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupEditUI()
    }
    
    //MARK: - Config
    
    func setupEditUI() {
        if indexPath == nil {
            newName.text = ""
            newSize.text = ""
            newPrice.text =  ""
            newImage.image = UIImage(named: "demoImage")
            saveButton.setTitle("Save", for: .normal)
        } else {
            saveButton.setTitle("Edit", for: .normal)
            newItemVCModel.fetchData()
            if let item = newItemVCModel.items?[indexPath!] {
                newName.text = item.name
                newSize.text = item.size
                newPrice.text =  String(format: "%.2f", item.price)
                newImage.image = UIImage(data: item.image!)
            }
        }
    }
    
    //MARK: - Add And Edit Data
    
    func addAndEditData() {
        if indexPath == nil {
            if let price = Double(newPrice.text!) {
                newItemVCModel.addData(name: newName.text!, price: price, size: newSize.text!, image: (newImage.image?.jpegData(compressionQuality: 0.5))!)
            } else {
                alert(message: "Please enter valid number in the price area")
            }
        } else {
            if let price = Double(newPrice.text!) {
                newItemVCModel.editData(name: newName.text!, price: price, size: newSize.text!, image: (newImage.image?.jpegData(compressionQuality: 0.5))!, indexPath: indexPath!)
            }
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
    
    //MARK: - Save and Edit Button
    
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
            addAndEditData()
            navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: - Alert Func
    
    func alert(message: String) {
        let alert = UIAlertController(title: "Warning!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}


