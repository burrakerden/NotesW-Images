//
//  MainCollectionViewCell.swift
//  NotesW-Images
//
//  Created by Burak Erden on 28.02.2023.
//

import UIKit

protocol DataCollectionProtocol {
    func deleteData(index: Int)
}

class MainCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemSize: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
        
    var delegate: DataCollectionProtocol?
    var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupGesture()
    }
    
    func setupGesture() {
        myImage.isUserInteractionEnabled = true
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(selectImage))
        longPressRecognizer.minimumPressDuration = 1.2
        myImage.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func selectImage() {
        delegate?.deleteData(index: index!.row)
    }
    
}
