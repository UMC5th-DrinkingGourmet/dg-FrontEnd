//
//  RecipeBookCollectionViewCell.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 2/6/24.
//

import UIKit

class RecipeBookCollectionViewCell: UICollectionViewCell {
    var recipeBookView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.customColor.checkMarkGray.cgColor
        $0.layer.cornerRadius = 8
    }
    
    var recipeBookImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
    }
    
    var recipeBookTitleLabel = UILabel().then {
        $0.text = "| 골뱅이무침"
        $0.textColor = .customOrange
        $0.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
    }
    
    var timeLabel = UILabel().then {
        $0.text = "소요시간 15분"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    }
    
    var ingredientLabel = UILabel().then {
        $0.text = "골뱅이 1캔 양파 1/2개\n당근1개 오이1개 깻잎 1묶음\n대파 1/2대 청양고추 2개\n양배추 1줌 소면"
        $0.textColor = .darkGray
        $0.numberOfLines = 4
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
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
            recipeBookView,
            recipeBookTitleLabel,
            recipeBookImageView,
            timeLabel,
            ingredientLabel
        ])
       
    }
    
    func configureLayout() {
        recipeBookView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        recipeBookImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(recipeBookImageView.snp.height)
        }
        
        recipeBookTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(recipeBookImageView.snp.trailing).offset(20)
            $0.top.equalToSuperview().offset(20)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(recipeBookTitleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(recipeBookTitleLabel.snp.leading).offset(4)
        }
        
        ingredientLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(12)
            $0.leading.equalTo(timeLabel.snp.leading)
            $0.trailing.equalToSuperview().offset(8)
        }
    }
}
