//
//  BannersCollectionViewCell.swift
//  MachineTest-MVVM
//
//  Created by Mac on 05/11/22.
//

import UIKit

class BannersCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bannerImage:UIImageView?
    
    static let identifier = "BannersCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib()-> UINib{
        return UINib(nibName: "BannersCollectionViewCell", bundle: nil)
    }
    
    public func configure(with viewModel: BannerCellViewModel){
        if let data = try? Data(contentsOf: URL(string: viewModel.banner_url)!){
            bannerImage?.image = UIImage(data: data)
        }
    }
}
