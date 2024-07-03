//
//  RecommendGuideView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/3/24.
//

import UIKit

final class RecommendGuideView: UIView {
    // MARK: - View
    private let guideLabel = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "오늘은 어떤 주류와\n어울리는 음식으로\n기분전환을 해보시겠어요?", attributes: [NSAttributedString.Key.kern: -0.72, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let recommendButtonView = UIView().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.935, green: 0.935, blue: 0.935, alpha: 1).cgColor
        $0.clipsToBounds = true
    }
    
    let recommendButton = UIButton().then {
        $0.backgroundColor = .clear
    }
    
    private let recommendLabel = UILabel().then {
        $0.text = "주류추천"
        $0.textColor = UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
    }
    
    private let myRecommendButtonView = UIView().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.935, green: 0.935, blue: 0.935, alpha: 1).cgColor
        $0.clipsToBounds = true
    }
    
    let myRecommendButton = UIButton().then {
        $0.backgroundColor = .clear
    }
    
    private let myRecommendLabel = UILabel().then {
        $0.text = "내가 받은 추천"
        $0.textColor = UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func addViews() {
        self.addSubviews([guideLabel,
                          stackView])
        
        stackView.addArrangedSubviews([recommendButtonView,
                                       myRecommendButtonView])
        
        recommendButtonView.addSubviews([recommendLabel,
                                         recommendButton])
        
        myRecommendButtonView.addSubviews([myRecommendLabel,
                                           myRecommendButton])
    }
    
    private func configureConstraints() {
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(45)
            make.leading.equalToSuperview().inset(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(48)
        }
        
        [recommendButtonView, myRecommendButtonView].forEach { $0.snp.makeConstraints { make in
            make.height.equalTo(50)
        } }
        
        recommendLabel.snp.makeConstraints { make in
            make.center.equalTo(recommendButtonView)
        }
        
        recommendButton.snp.makeConstraints { make in
            make.edges.equalTo(recommendButtonView)
        }
        
        myRecommendLabel.snp.makeConstraints { make in
            make.center.equalTo(myRecommendButtonView)
        }
        
        myRecommendButton.snp.makeConstraints { make in
            make.edges.equalTo(myRecommendButtonView)
        }
    }
}

