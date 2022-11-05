//
//  CategoryCollectionViewCell.swift
//  MachineTest-MVVM
//
//  Created by Mac on 05/11/22.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    static let identifier = "CategoryCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    static func nib()-> UINib{
        return UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
    }
    public func configure(with viewModel: CategoryCellViewModel){
        
        if let data = try? Data(contentsOf: URL(string: viewModel.image_url)!){
            categoryImage.image = UIImage(data: data)
        }
        categoryName.text = viewModel.name
    }
}
