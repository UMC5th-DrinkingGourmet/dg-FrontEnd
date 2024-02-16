//
//  LikeCell.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/17/24.
//

import UIKit

class LikeCell: UICollectionViewCell {
    
    let mainImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
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
        contentView.addSubview(mainImage)
    }
    
    private func configureConstraints() {
        mainImage.snp.makeConstraints { make in
//            make.height.equalTo(125)
            make.edges.equalTo(contentView)
        }
    }
}
