//
//  TodayCombinationDetailCell.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 1/20/24.
//

import UIKit
import SnapKit
import Then

class TodayCombinationDetailCell: UICollectionViewCell {
    
    let mainImage = UIImageView().then {
        $0.image = UIImage(named: "img_community_today_detail")
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
            make.height.equalTo(375)
            make.edges.equalTo(contentView)
        }
    }
}
