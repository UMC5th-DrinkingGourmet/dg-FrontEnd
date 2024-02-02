//
//  uploadedImgCollectionViewCell.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 2/2/24.
//

import UIKit

class UploadedImgCollectionViewCell: UICollectionViewCell {
    let baseView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let uploadedImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    let deleteBtn = UIButton().then {
        $0.setImage(UIImage(named: "ic_delete"), for: .normal)
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
        contentView.addSubview(baseView)
        contentView.addSubview(uploadedImageView)
        contentView.addSubview(deleteBtn)
    }
    
    func configureLayout() {
        baseView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
        
        deleteBtn.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.height.equalTo(30)
        }
        
        uploadedImageView.snp.makeConstraints {
            $0.leading.bottom.equalTo(contentView)
            $0.top.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().inset(15)
        }

    }
    
}
