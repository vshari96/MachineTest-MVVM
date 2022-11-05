//
//  ViewController.swift
//  MachineTest-MVVM
//
//  Created by Mac on 04/11/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var categoryScrollbar: UICollectionView?
    @IBOutlet var bannerCarousel: UICollectionView?
    @IBOutlet var productView: UICollectionView?
    var data: Response?
    var categoryList: [Category] = []
    var bannersList: [Banners] = []
    var productsList: [Products] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryScrollbar?.register(CategoryCollectionViewCell.nib(), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        bannerCarousel?.register(BannersCollectionViewCell.nib(), forCellWithReuseIdentifier: BannersCollectionViewCell.identifier)
        productView?.register(ProductCollectionViewCell.nib(), forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        DataFetcher.shared.getData(){response in
            self.setupData(data: response)
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryScrollbar{
            print(categoryList.count)
            return categoryList.count
        }else if collectionView == bannerCarousel{
            return bannersList.count
        }else if collectionView == productView{
            return productsList.count
        }else{
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryScrollbar{
            return createCategoryCell(index: indexPath)
        }else if collectionView == bannerCarousel{
            return createBannerCell(index: indexPath)
        }else if collectionView == productView{
            return createProductCell(index: indexPath)
        }else{
            return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        }
    }
    
    func setupData(data: Response) {
        
        for item in data.homeData{
            switch item {
            case .category(let categoryArray):
                categoryList += categoryArray
            case .banners(let bannersArray):
                bannersList += bannersArray
            case .products(let productsArray):
                productsList += productsArray
            }
        }
        DispatchQueue.main.sync {
            categoryScrollbar?.reloadData()
            bannerCarousel?.reloadData()
            productView?.reloadData()
        } 
    }
    
    
    func createCategoryCell(index: IndexPath)->CategoryCollectionViewCell{
        let cell =  categoryScrollbar?.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: index) as! CategoryCollectionViewCell
        let cellData = categoryList[index.row]
        let cellModel = CategoryCellViewModel(name: cellData.name, image_url: cellData.image_url)
        cell.configure(with: cellModel)
        return cell
    }
    
    func createBannerCell(index: IndexPath)->BannersCollectionViewCell{
        let cell =  bannerCarousel?.dequeueReusableCell(withReuseIdentifier: BannersCollectionViewCell.identifier, for: index) as! BannersCollectionViewCell
        let cellData = bannersList[index.row]
        let cellModel = BannerCellViewModel(banner_url: cellData.banner_url)
        cell.configure(with: cellModel)
        return cell
    }
    func createProductCell(index: IndexPath)->ProductCollectionViewCell{
        let cell =  productView?.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: index) as! ProductCollectionViewCell
        let cellData = productsList[index.row]
        let cellModel = ProductCellViewModel(name: cellData.name, image: cellData.image, actual_price: cellData.actual_price, offer_price: cellData.offer_price, offer: cellData.offer, is_express: cellData.is_express)
        cell.configure(with: cellModel)
        return cell
    }
}

