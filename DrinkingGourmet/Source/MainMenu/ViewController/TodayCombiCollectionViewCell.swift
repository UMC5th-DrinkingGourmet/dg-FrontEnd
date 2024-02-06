//
//  TodayCombiCollectionViewCell.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 2/6/24.
//

import UIKit
import SnapKit
import Then

class TodayCombiCollectionViewCell: UICollectionViewCell {
    lazy var combiImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
    }
    
    let gradientView = GradientView().then {
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
    }
    
    let titleLabel = UILabel().then {
        $0.text = "메론 하몽과\n버번 위스키 언더락"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        $0.numberOfLines = 2
        $0.setLineSpacing(lineSpacing: 8)
    }
    
    let hashTagLabel = UILabel().then {
        $0.text = "#홈파티 #언더락 #버번위스키\n#커플"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 2
        $0.setLineSpacing(lineSpacing: 4)
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
            combiImageView,
            gradientView,
            titleLabel,
            hashTagLabel
        ])
    }
    
    func configureLayout() {
        combiImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(22)
            $0.top.equalToSuperview().offset(62)
        }
        
        gradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        hashTagLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
    
}
