//
//  InputFoodView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/4/24.
//

import UIKit

final class InputFoodView: UIView {
    // MARK: - View
    let progressBar = UIProgressView().then {
        $0.progress = 0.4
        $0.progressTintColor = .black
    }
    
    let titleLabel = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "드실 음식을 입력해주세요.", attributes: [NSAttributedString.Key.kern: -0.72, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let descriptionLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.562, green: 0.562, blue: 0.562, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "오늘은 어떤 음식과 함께 하시나요?", attributes: [NSAttributedString.Key.kern: -0.42, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let textField = UITextField().then {
        $0.placeholder = "치킨"
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 20)
        $0.tintColor = .customOrange
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.clearButtonMode = .always
    }
    
    let lineView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1)
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 25
    }
    
    let passButton = UIButton().then {
        $0.isHidden = true
        $0.setTitle("건너뛰기", for: .normal)
        $0.setTitleColor(UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1), for: .normal)
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
                          passButton,
                          nextButton])
        
        stackView.addArrangedSubviews([progressBar,
                                       titleLabel,
                                       descriptionLabel,
                                       textField,
                                       lineView])
    }
    
    private func configureConstraints() {
        progressBar.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        stackView.setCustomSpacing(4, after: titleLabel)
        stackView.setCustomSpacing(50, after: descriptionLabel)
        stackView.setCustomSpacing(10, after: textField)
        
        passButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top).offset(-35)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
