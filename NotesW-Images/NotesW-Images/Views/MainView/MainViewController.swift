//
//  MainViewController.swift
//  NotesW-Images
//
//  Created by Burak Erden on 28.02.2023.
//

import UIKit
import CoreData



class MainViewController: UIViewController {
    
    @IBOutlet weak var midLabel: UILabel!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    var model = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        tipLabel()
    }
    //MARK: - Config
    
    func setupUI() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        navigationItem.title = "Take Note"
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemButton))
    }
    
    func tipLabel() {
        if model.items?.count == 0 {
            midLabel.isHidden = false
        } else {
            midLabel.isHidden = true
        }
    }
    
    //MARK: - Fetch Data
    
    func fetchData() {
        model.fetchData(mainCollectionView: mainCollectionView)
    }
    
    //MARK: - Right Bar Button

    @objc func addItemButton() {
        let vc = NewItemVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

    //MARK: - Collection View

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MainCollectionViewCell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell else {return UICollectionViewCell()}
        if let items = model.items?[indexPath.row] {
            cell.itemName.text = items.name
            cell.itemSize.text = items.size
            cell.itemPrice.text = String(format: "%.2f", items.price) + " $"
            cell.myImage.image = UIImage(data: items.image!)
            cell.index = indexPath
            cell.delegate = self
        }
        return cell
    }
}

    //MARK: - Delete Button

extension MainViewController: DataCollectionProtocol {

    func deleteData(index: Int) {

            let alert = UIAlertController(title: "Warning", message: "Are you sure you want to delete the item?", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "No", style: .cancel)
            let action2 = UIAlertAction(title: "Delete", style: .default) { _ in
                let gameToRemove = self.model.items![index]
                self.model.context.delete(gameToRemove)
                do {
                    try self.model.context.save()
                    print("deleting-success")
                } catch {
                    print("error-deleting data")
                }
                self.model.fetchData(mainCollectionView: self.mainCollectionView)
                self.tipLabel()
            }
            alert.addAction(action1)
            alert.addAction(action2)
            present(alert, animated: true)
    }
}
