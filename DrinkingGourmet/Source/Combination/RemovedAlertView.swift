//
//  RemovedAlertView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/3/24.
//

import UIKit

final class RemovedAlertView: UIView {
    // MARK: - View
    let backView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.6)
        $0.alpha = 0
    }
    
    let contentView = UIView().then {
        $0.alpha = 0
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    private let aleartIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_aleart")
    }
    
    private let aleartLabel_1 = UILabel().then {
        $0.textColor = .customOrange
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(
            string: "삭제된 게시물입니다.",
            attributes: [
                NSAttributedString.Key.kern: -0.6,
                NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )
    }
    
    private let dividerLine = UIView().then {
        $0.backgroundColor = UIColor(red: 0.935, green: 0.935, blue: 0.935, alpha: 1)
    }
    
    private let aleartLabel_2 = UILabel().then {
        $0.textColor = UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        paragraphStyle.alignment = .center // 여기에 텍스트 정렬 설정
        $0.attributedText = NSMutableAttributedString(
            string: "사용자가 직접 삭제했거나\n정책 위반으로 삭제된 게시물 입니다.",
            attributes: [
                NSAttributedString.Key.kern: -0.42,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
        )
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 8
    }
    
    private let closeButtonView = UIView().then {
        $0.backgroundColor = .customOrange
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    private let closeButtonLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1
        $0.attributedText = NSMutableAttributedString(string: "닫기", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let closeButton = UIButton().then {
        $0.backgroundColor = .clear
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        addViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func addViews() {
        self.addSubview(backView)
        
        backView.addSubview(contentView)
        
        contentView.addSubviews([stackView, 
                                 closeButtonView])
        
        stackView.addArrangedSubviews([aleartIcon,
                                       aleartLabel_1,
                                       dividerLine,
                                       aleartLabel_2])
        
        closeButtonView.addSubviews([closeButton,
                                    closeButtonLabel])
    }
    
    private func configureConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.center.equalTo(backView)
            make.leading.trailing.equalTo(backView).inset(20)
            make.height.equalTo(350)
        }
        
        dividerLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(stackView    )
        }
        
        aleartLabel_2.snp.makeConstraints { make in
            make.height.equalTo(42)
            make.width.equalTo(200)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(61)
            make.leading.trailing.equalTo(contentView).inset(20)
        }
        
        closeButtonView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(40)
            make.bottom.equalTo(contentView).inset(20)
        }
        
        closeButton.snp.makeConstraints { make in
            make.edges.equalTo(closeButtonView)
        }
        
        closeButtonLabel.snp.makeConstraints { make in
            make.center.equalTo(closeButtonView)
        }
    }
}
