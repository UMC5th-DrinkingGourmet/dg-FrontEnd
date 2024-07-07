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
    let nickNameLabel = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "\(UserDefaultManager.shared.userNickname)님을 위한 주류를\n선정하고 있어요", attributes: [NSAttributedString.Key.kern: -0.72, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let animationView: LottieAnimationView = .init(name: "Animation - 1707200937141")
    
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
        self.addSubviews([nickNameLabel,
                          animationView])
    }
    
    private func configureConstraints() {
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(45)
            make.leading.equalToSuperview().inset(20)
        }
        
        animationView.snp.makeConstraints { make in
            make.size.equalTo(90)
            make.center.equalToSuperview()
        }
    }
}

