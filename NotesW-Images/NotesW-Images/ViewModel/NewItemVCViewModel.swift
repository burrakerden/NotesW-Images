//
//  NewItemVCModel.swift
//  NotesW-Images
//
//  Created by Burak Erden on 28.02.2023.
//

import Foundation
import CoreData
import UIKit

class NewItemVCViewModel {
    
    var items : [Items]?
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")
    
    func fetchData() {
        do {
            items = try context.fetch(Items.fetchRequest())
        } catch {
            print("error - fetchData")
        }
    }
    
    func addData(name: String, price: Double, size: String, image: Data) {
        let newObject = Items(context: context)
        newObject.name = name
        newObject.price = price
        newObject.size = size
        newObject.image = image
        newObject.id = UUID()
        
        do {
            try context.save()
            print("succuss - save")
        } catch {
            print("error - addData")
        }
    }
    
    func editData(name: String, price: Double, size: String, image: Data, indexPath: Int) {
        let dataToEdit = items?[indexPath]
            dataToEdit?.name = name
            dataToEdit?.size = size
            dataToEdit?.price = price
            dataToEdit?.image = image
        do {
            try context.save()
            print("oki")
        } catch {
            print("error - edit")
        }
    }
}

class CustomUITextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
