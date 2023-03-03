//
//  MainViewController.swift
//  NotesW-Images
//
//  Created by Burak Erden on 28.02.2023.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var midLabel: UILabel!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    var model = MainViewModel()
    
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
    }
    
    func tipLabel() {
        if model.items?.count == 0 {
            midLabel.isHidden = false
            addButton.isHidden = false
        } else {
            addButton.isHidden = true
            midLabel.isHidden = true
        }
    }
    
    //MARK: - Fetch Data
    
    func fetchData() {
        model.fetchData(mainCollectionView: mainCollectionView)
    }
    //MARK: - Add Button
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
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
        if let data = model.items?[indexPath.row] {
            cell.setupCellUI(data: data)
        }
        cell.index = indexPath
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = NewItemVC()
        vc.indexPath = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
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
