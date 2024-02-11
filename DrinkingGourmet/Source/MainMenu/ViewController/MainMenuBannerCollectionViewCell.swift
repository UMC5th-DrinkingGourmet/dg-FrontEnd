//
//  MainMenuBannerCollectionViewCell.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 2/5/24.
//

import UIKit

class MainMenuBannerCollectionViewCell: UICollectionViewCell {
    let bannerImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    let gradientView = GradientView()
    
    let bannerTitleLabel = UILabel().then {
        $0.text = "bannerTitleLabel"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        $0.numberOfLines = 2
        $0.setLineSpacing(lineSpacing: 8)
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
        contentView.addSubviews([
            bannerImageView,
            gradientView,
            bannerTitleLabel
        ])
    }
    
    func configureLayout() {
        bannerImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bannerTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-40)
        }
        
        gradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
