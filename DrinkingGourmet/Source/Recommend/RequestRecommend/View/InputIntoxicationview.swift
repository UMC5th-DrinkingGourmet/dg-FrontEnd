//
//  InputIntoxicationview.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/4/24.
//

import UIKit

final class InputIntoxicationView: UIView {
    // MARK: - View
    private let progressBar = UIProgressView().then {
        $0.progress = 0.2
        $0.progressTintColor = .base0100
        $0.trackTintColor = .base0800
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .base0100
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "어느 정도로 취하고 싶나요?", attributes: [NSAttributedString.Key.kern: -0.72, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let descriptionLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.562, green: 0.562, blue: 0.562, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "1에서 5까지의 수치로 표현해주세요.", attributes: [NSAttributedString.Key.kern: -0.42, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 25
    }
    
    let slider = UISlider().then {
        $0.minimumValue = 1
        $0.maximumValue = 5
        $0.thumbTintColor = .customOrange
        $0.tintColor = .customOrange
    }
    
    private let numbersStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }
    
    private let numberLabels: [UILabel] = (1...5).map { number in
        let label = UILabel()
        label.text = "\(number)"
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        label.textColor = .base0600
        return label
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
                          numbersStackView,
                          nextButton])
        
        stackView.addArrangedSubviews([progressBar,
                                       titleLabel,
                                       descriptionLabel,
                                       slider])
        
        numberLabels.forEach { numbersStackView.addArrangedSubview($0) }
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
        stackView.setCustomSpacing(70, after: descriptionLabel)
        
        numbersStackView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(11)
            make.leading.trailing.equalToSuperview().inset(31)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
