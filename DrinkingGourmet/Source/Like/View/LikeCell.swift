//
//  LikeCell.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/17/24.
//

import UIKit

class LikeCell: UICollectionViewCell {
    
    let mainImage = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    let mainLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13.36)
        $0.numberOfLines = 6
//        $0.lineBreakMode = .byWordWrapping
    }
    
    let heartIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_like_selected")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        contentView.addSubviews([mainImage, mainLabel, heartIcon])
    }
    
    private func configureConstraints() {
        mainImage.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(16)
            make.trailing.equalTo(contentView).inset(32)
            make.bottom.equalTo(contentView).inset(16)
        }
        
        heartIcon.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(10)
            make.trailing.equalTo(contentView).inset(10)
        }
    }
}
