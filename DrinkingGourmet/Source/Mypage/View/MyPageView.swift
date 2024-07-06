//
//  MyPageView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/20/24.
//

import UIKit

class MyPageView: UIView {
    // MARK: - View
    let profileImage = UIImageView().then {
        $0.image = UIImage(named: "ic_profile_mypage")
        $0.layer.cornerRadius = 32
        $0.clipsToBounds = true
    }
    
    let nickNameLabel = UILabel().then {
        $0.text = "이름 님"
        $0.textColor = .base0100
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
    }
    
    let providerIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_login_kakao")
    }
    
    private let myInfoLabel = UILabel().then {
        $0.text = "기본 정보 보기"
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        $0.textColor = .base0300
    }
    
    private let arrowIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_more")
    }
    
    let myInfoButton = UIButton().then {
        $0.backgroundColor = .clear
    }
    
    let tapmanView = UIView()
    
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
        self.addSubviews([profileImage,
                          nickNameLabel,
                          providerIcon,
                          myInfoLabel,
                          arrowIcon,
                          myInfoButton,
                          tapmanView])
    }
    
    private func configureConstraints() {
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(33)
            make.leading.equalToSuperview().offset(20)
            make.size.equalTo(64)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.top).inset(10)
            make.leading.equalTo(profileImage.snp.trailing).offset(20)
        }
        
        providerIcon.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel)
            make.leading.equalTo(nickNameLabel.snp.trailing).offset(8)
            make.size.equalTo(20)
        }
        
        myInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nickNameLabel)
        }
        
        arrowIcon.snp.makeConstraints { make in
            make.centerY.equalTo(profileImage)
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(12)
        }
        
        myInfoButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(profileImage)
            make.leading.equalTo(nickNameLabel)
            make.trailing.equalToSuperview()
        }
        
        tapmanView.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
