//
//  ProductCollectionViewCell.swift
//  MachineTest-MVVM
//
//  Created by Mac on 05/11/22.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var favIcon: UIButton!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var expressIcon: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var actualPrice: UILabel!
    @IBOutlet weak var offerPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    
    static let identifier = "ProductCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static func nib()->UINib{
        return UINib(nibName: "ProductCollectionViewCell", bundle: nil)
    }

    public func configure(with viewModel: ProductCellViewModel){
        if viewModel.offer > 0{
            offerLabel.isHidden = false
            offerLabel.text = String(viewModel.offer)+"% OFF"
        }else{
            offerLabel.isHidden = true
        }
        if let data = try? Data(contentsOf: URL(string: viewModel.image)!){
            productImage?.image = UIImage(data: data)
        }
        if viewModel.is_express{
            expressIcon.isHidden = false
        }else{
            expressIcon.isHidden = true
        }
        
        if viewModel.actual_price == viewModel.offer_price{
            actualPrice.isHidden = true
            offerPrice.text = viewModel.offer_price
        }else{
            actualPrice.isHidden = false
            actualPrice.attributedText = NSAttributedString(string: viewModel.actual_price, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
                
            offerPrice.text = viewModel.offer_price
        }
        
        productName.text = viewModel.name
        
    }

}

