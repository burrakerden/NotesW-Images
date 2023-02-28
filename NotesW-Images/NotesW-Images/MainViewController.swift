//
//  MainViewController.swift
//  NotesW-Images
//
//  Created by Burak Erden on 28.02.2023.
//

import UIKit
import CoreData



class MainViewController: UIViewController {
    

    @IBOutlet weak var mainCollectionView: UICollectionView!
    var model = Model()
    

    
//    var items : [Items]?
//    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        rightButton()
        setupGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    
    func setupUI() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        navigationItem.title = "Notes"
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
    }
    
    func setupGesture() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(selectImage))
        longPressRecognizer.minimumPressDuration = 2
        mainCollectionView.addGestureRecognizer(longPressRecognizer)
    }

    
    @objc func selectImage() {
        
    }
    
    private func rightButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemButton))
    }
    
    @objc func addItemButton() {
        let vc = NewItemVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchData() {
//        do {
//            items = try context.fetch(Items.fetchRequest())
//        } catch {
//            print("error - fetchData")
//        }
//        mainCollectionView.reloadData()
        model.fetchData(mainCollectionView: mainCollectionView)
    }


}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MainCollectionViewCell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell else {return UICollectionViewCell()}
        if let items = model.items?[indexPath.row] {
            cell.itemName.text = items.name
            cell.itemSize.text = items.size
            cell.itemPrice.text = items.price
            cell.myImage.image = UIImage(data: items.image!)
            cell.index = indexPath
            cell.delegate = self
        }
        return cell
    }
}

extension MainViewController: DataCollectionProtocol {

    func deleteData(index: Int) {

            let alert = UIAlertController(title: "burak", message: "erden", preferredStyle: .alert)
            let action2 = UIAlertAction(title: "no", style: .cancel)
            let action = UIAlertAction(title: "delete", style: .default) { _ in
                let gameToRemove = self.model.items![index]
                self.model.context.delete(gameToRemove)
                do {
                    try self.model.context.save()
                    print("deleting-success")
                } catch {
                    print("error-Deleting data")
                }
                self.model.fetchData(mainCollectionView: self.mainCollectionView)
            }
            alert.addAction(action)
            alert.addAction(action2)
            present(alert, animated: true)
        
        

    }
}
