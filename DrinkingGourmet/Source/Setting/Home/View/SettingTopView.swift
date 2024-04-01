//
//  SettingTopView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 4/1/24.
//

import UIKit

final class SettingTopView: UITableViewHeaderFooterView {
    // MARK: - View
    let profileImage = UIImageView().then {
        $0.image = UIImage(named: "ic_profile_mypage")
        $0.layer.cornerRadius = 32
        $0.clipsToBounds = true
    }
    
    let nicknameLabel = UILabel().then {
        $0.text = "이름 님"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
    }
    
    let providerImage = UIImageView().then {
        $0.image = UIImage(named: "ic_login_kakao")
    }
    
    private let informationButton = UIButton().then {
        $0.setTitle("기본 정보 보기", for: .normal)
        $0.setTitleColor(UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
    }
    
    let moreButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_more"), for: .normal)
    }
    
    private let modifyView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        $0.layer.cornerRadius = 8
    }
    
    private let modifyLabel_1 = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "주류추천 기본 정보", attributes: [NSAttributedString.Key.kern: -0.3, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let modifyLabel_2 = UILabel().then {
        $0.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "정보 입력하고 주류 추천 받기", attributes: [NSAttributedString.Key.kern: -0.27, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let modifyButton = UIButton().then {
        $0.setTitle("수정하기", for: .normal)
        $0.backgroundColor = .customOrange
        $0.layer.cornerRadius = 4
        
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        let attributedString = NSMutableAttributedString(string: "수정하기", attributes: [
            NSAttributedString.Key.kern: -0.27,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        $0.setAttributedTitle(attributedString, for: .normal)
    }
    
    private let divideLine = UIView().then {
        $0.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func addViews() {
        self.addSubviews([
            profileImage,
            nicknameLabel,
            providerImage,
            informationButton,
            moreButton,
            modifyView,
            divideLine
        ])
        
        modifyView.addSubviews([
            modifyLabel_1,
            modifyLabel_2,
            modifyButton
        ])
    }
    
    private func configureConstraints() {
    
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(33)
            make.leading.equalToSuperview().offset(22)
            make.size.equalTo(64)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.top).inset(10)
            make.leading.equalTo(profileImage.snp.trailing).offset(18)
        }
        
        providerImage.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel)
            make.leading.equalTo(nicknameLabel.snp.trailing).offset(8)
            make.size.equalTo(20)
        }
        
        informationButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nicknameLabel)
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImage)
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(12)
        }
        
        modifyView.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(89)
        }
        
        modifyLabel_1.snp.makeConstraints { make in
            make.top.leading.equalTo(modifyView).inset(20)
        }
        
        modifyLabel_2.snp.makeConstraints { make in
            make.top.equalTo(modifyLabel_1.snp.bottom).offset(4)
            make.leading.equalTo(modifyLabel_1)
        }
        
        modifyButton.snp.makeConstraints { make in
            make.top.equalTo(modifyView).inset(26)
            make.trailing.equalTo(modifyView).inset(20)
            make.width.equalTo(74)
            make.height.equalTo(37)
        }
        
        divideLine.snp.makeConstraints { make in
            make.top.equalTo(modifyView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(8)
        }
    }
}
