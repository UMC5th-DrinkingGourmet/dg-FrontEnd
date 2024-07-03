//
//  RecommendResultView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/4/24.
//

import UIKit

final class RecommendResultView: UIView {
    // MARK: - View
    private let scrollView = UIScrollView().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.935, green: 0.935, blue: 0.935, alpha: 1).cgColor
        $0.clipsToBounds = true
    }
    
    private let contentView = UIView()
    
    let image = UIImageView().then {
        $0.image = UIImage(systemName: "heart.fill")
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.textAlignment = .center
        $0.attributedText = NSMutableAttributedString(string: "피자 & 맥주", attributes: [NSAttributedString.Key.kern: -0.72, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let descriptionLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "오늘 날씨가 화창하니 기분이 좋은 여자친구와 함께 고기를 먹는 데이트라면, 상큼하고 청량감 넘치는 칵테일이 최적의 선택입니다.", attributes: [NSAttributedString.Key.kern: -0.48, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 39
        $0.alignment = .center
    }
    
    private let anotherButtonView = UIView().then {
        $0.backgroundColor = .base0900
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    private let anotherButtonLabel = UILabel().then {
        $0.textColor = .base0200
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1
        $0.attributedText = NSMutableAttributedString(string: "다른 추천 받기", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let anotherButton = UIButton().then {
        $0.backgroundColor = .clear
    }
    
    private let myRecommendButtonView = UIView().then {
        $0.backgroundColor = .base0100
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    private let myRecommendButtonLabel = UILabel().then {
        $0.textColor = .base1000
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1
        $0.attributedText = NSMutableAttributedString(string: "나의 추천 목록", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let myRecommendButton = UIButton().then {
        $0.backgroundColor = .clear
    }
    
    private let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fillEqually
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
        self.addSubviews([scrollView,
                          buttonStackView])
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubviews([image,
                                              titleLabel,
                                              descriptionLabel])
        
        buttonStackView.addArrangedSubviews([anotherButtonView,
                                             myRecommendButtonView])
        
        anotherButtonView.addSubviews([anotherButtonLabel,
                                       anotherButton])
        
        myRecommendButtonView.addSubviews([myRecommendButtonLabel,
                                           myRecommendButton])
    }
    
    private func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(buttonStackView.snp.top).offset(-50)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView)
            make.edges.equalTo(scrollView)
        }
        
        image.snp.makeConstraints { make in
            make.size.equalTo(200)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(37)
            make.leading.trailing.equalTo(contentView).inset(32)
            make.bottom.equalTo(contentView).inset(37)
        }
        
        contentStackView.setCustomSpacing(22, after: titleLabel)
        
        [anotherButtonView, myRecommendButtonView].forEach { $0.snp.makeConstraints { make in
            make.height.equalTo(59)
        } }
        
        anotherButtonLabel.snp.makeConstraints { make in
            make.center.equalTo(anotherButtonView)
        }
        
        anotherButton.snp.makeConstraints { make in
            make.edges.equalTo(anotherButtonView)
        }
        
        myRecommendButtonLabel.snp.makeConstraints { make in
            make.center.equalTo(myRecommendButtonView)
        }
        
        myRecommendButton.snp.makeConstraints { make in
            make.edges.equalTo(myRecommendButtonView)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(30)
        }
    }
}
