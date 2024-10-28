//
//  RecommendLodingView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/4/24.
//

import UIKit
import Lottie

final class RecommendLodingView: UIView {
    // MARK: - View
    let animationView: LottieAnimationView = .init(name: "Loader")
    
    let timeRequiredLabel = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.text = "완벽한 조합을 찾고 있어요"
        $0.textColor = UIColor(red: 0.56, green: 0.56, blue: 0.56, alpha: 1)
    }
    
    let nickNameLabel = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24)
        $0.numberOfLines = 0
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        paragraphStyle.alignment = .center
        $0.attributedText = NSMutableAttributedString(string: "\(UserDefaultManager.shared.userNickname)님을 위한 주류를\n선정하고 있어요...", attributes: [NSAttributedString.Key.kern: -0.72, NSAttributedString.Key.paragraphStyle: paragraphStyle])
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
        self.addSubviews([
            animationView,
            nickNameLabel,
            timeRequiredLabel
        ])
    }
    
    private func configureConstraints() {
        animationView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide).offset(160)
        }
        
        timeRequiredLabel.snp.makeConstraints { make in
            make.centerX.equalTo(animationView)
            make.top.equalTo(animationView.snp.bottom).offset(93)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(animationView)
            make.top.equalTo(timeRequiredLabel.snp.bottom).offset(8)
        }
    }
}
