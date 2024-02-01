//
//  uploadedImgCollectionViewCell.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 2/2/24.
//

import UIKit

class UploadedImgCollectionViewCell: UICollectionViewCell {
    let uploadedImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(uploadedImageView)
    }
    
    func configureLayout() {
        uploadedImageView .snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
}
