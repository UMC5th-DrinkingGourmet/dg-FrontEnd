//
//  RecipeBookDetailCell.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

final class RecipeBookDetailCell: UICollectionViewCell {
    
    // MARK: - View
    let mainImage = UIImageView().then {
        $0.image = UIImage(named: "img_community_today_detail")
        $0.contentMode = .scaleAspectFill
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
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
