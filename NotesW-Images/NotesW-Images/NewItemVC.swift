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
    
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGesture()
        
    }
    
    func addData() {
        let newObject = Items(context: self.context)
        newObject.name = newName.text
        newObject.price = newPrice.text!
        newObject.size = newSize.text
        newObject.image = newImage.image!.jpegData(compressionQuality: 0.7)
        newObject.id = UUID()
        
        do {
            try context.save()
            print("succuss - save")
        } catch {
            print("error - addData")
        }
        
    }
    
    
    
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
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let vc = MainViewController()
        addData()
        navigationController?.popViewController(animated: true)
        
    }
}
