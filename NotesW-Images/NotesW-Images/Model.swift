//
//  Model.swift
//  NotesW-Images
//
//  Created by Burak Erden on 28.02.2023.
//

import Foundation
import UIKit
import CoreData

class Model {
    var items : [Items]?
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")
    
    func fetchData(mainCollectionView: UICollectionView?) {
        do {
            items = try context.fetch(Items.fetchRequest())
        } catch {
            print("error - fetchData")
        }
        mainCollectionView?.reloadData()
    }
    
}
