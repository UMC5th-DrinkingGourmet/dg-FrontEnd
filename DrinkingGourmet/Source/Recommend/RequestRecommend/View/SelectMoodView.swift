//
//  SelectMoodView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/4/24.
//

import UIKit
import TagListView

final class SelectMoodView: UIView {
    // MARK: - View
    private let progressBar = UIProgressView().then {
        $0.progress = 0.6
        $0.progressTintColor = .black
        $0.trackTintColor = .base0800
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .base0100
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "기분은 어떠신가요?", attributes: [NSAttributedString.Key.kern: -0.72, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let descriptionLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.562, green: 0.562, blue: 0.562, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "기분과 어올리는 주류를 추천해드릴게요.", attributes: [NSAttributedString.Key.kern: -0.42, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 25
    }
    
    let tagListView = TagListView().then {
        $0.addTags(["기뻐요", 
                    "즐거워요",
                    "행복해요",
                    "지쳤어요",
                    "우울해요", 
                    "힘들어요",
                    "화나요",
                    "스트레스 받아요",
                    "긴장돼요",
                    "걱정돼요",
                    "기대돼요"])
        
        // 기본 값 (선택 전)
        $0.textFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)!
        $0.alignment = .leading
        $0.textColor = .base0300
        $0.tagBackgroundColor = .base1000
        $0.borderColor = .base0800
        $0.borderWidth = 1
        $0.cornerRadius = 20
        $0.clipsToBounds = true
        
        $0.paddingX = 24
        $0.paddingY = 10.5
        
        $0.marginX = 8
        $0.marginY = 8
        
        // 선택 후
        $0.selectedTextColor = .customOrange
        $0.selectedBorderColor = .customOrange
        $0.tagSelectedBackgroundColor = UIColor(red: 0.996, green: 0.471, blue: 0.125, alpha: 0.05)
    }
    
    let passButton = UIButton().then {
        $0.setTitle("건너뛰기", for: .normal)
        $0.setTitleColor(.base0600, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
    }
    
    let nextButton = NextButtonView()
    
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
        self.addSubviews([stackView,
                          nextButton,
                          passButton])
        
        stackView.addArrangedSubviews([progressBar,
                                       titleLabel,
                                       descriptionLabel,
                                       tagListView])
    }
    
    private func configureConstraints() {
        progressBar.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        stackView.setCustomSpacing(4, after: titleLabel)
        stackView.setCustomSpacing(45, after: descriptionLabel)
        
        passButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top).offset(-35)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
