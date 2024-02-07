//
//  RecommendView.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 2/6/24.
//

import UIKit

class RecommendView: UIView {
    
    var titleLabel = UILabel().then {
        $0.text = "나와 어울리는 메뉴는?"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        $0.textAlignment = .left
    }
    
    var detailLabel = UILabel().then {
        $0.text = "오늘의 기분, 날씨에 맞게\n어울리는 메뉴를 추천해드립니다."
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 2
        $0.textAlignment = .left
        $0.setLineSpacing(lineSpacing: 4)
    }
    
    var goBtn = UIButton().then {
        $0.goBtnConfig(title: "바로가기", font: .systemFont(ofSize: 14), backgroundColor: .customOrange)
    }
    
    let borderView = UIView().then {
        $0.backgroundColor = .checkmarkGray
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        self.addSubviews([
            titleLabel,
            detailLabel,
            goBtn,
            borderView
        ])
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        detailLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        goBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(detailLabel.snp.bottom)
            $0.width.equalTo(108)
            $0.height.equalTo(40)
        }
        
        borderView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
    }
    
}
