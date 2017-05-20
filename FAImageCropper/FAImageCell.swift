//
//  FAImageCell.swift
//  FAImageCropper
//
//  Created by Fahid Attique on 12/02/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit


public let FAImagePlaceHolderSize: CGSize = CGSize(width: 100.0, height: 100.0)


class FAImageCell: UICollectionViewCell {

    //  MARK: IBOutlets
    
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var imageView: UIImageView!

    // MARK: Class Properties
    
    override var isSelected:Bool{
        
        didSet{
            if isSelected {
                selectionView.backgroundColor = .white
            }
            else{
                selectionView.backgroundColor = .clear
            }
        }
    }

    //  MARK: Functions

    override func prepareForReuse() {
        super.prepareForReuse()
        if self.imageView != nil{
            imageView.image = nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewConfigurations()
    }
    
    private func viewConfigurations(){
        selectionView.layer.borderWidth = 2
        selectionView.layer.borderColor = UIColor.clear.cgColor
    }

    func populateDataWith(asset:PHAsset) {
        
        FAImageLoader.imageFrom(asset: asset, size: FAImagePlaceHolderSize) { (image) in
            DispatchQueue.main.async {
                if self.imageView != nil{
                    self.imageView.image = image
                }
            }
        }
    }
}
