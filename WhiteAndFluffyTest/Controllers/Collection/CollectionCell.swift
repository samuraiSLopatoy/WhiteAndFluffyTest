//
//  CollectionCell.swift
//  WhiteAndFluffyTest
//
//  Created by Михаил Кулагин on 01.02.2022.
//

import UIKit
import SDWebImage

class CollectionCell: UICollectionViewCell {
    
    static let reuseId = "CollectionCell"
    
    var photo: Photo! {
        didSet {
            photoImageView.sd_setImage(with: URL(string: (photo.urls.small)), completed: nil)
        }
    }
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPhotoImageView()
    }
    
    private func setupPhotoImageView() {
        addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.frame = contentView.bounds
        self.clipsToBounds = true
        self.layer.cornerRadius = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
