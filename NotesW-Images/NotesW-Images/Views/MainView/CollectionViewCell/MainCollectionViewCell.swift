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
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        delegate?.deleteData(index: index!.row)
    }
}
