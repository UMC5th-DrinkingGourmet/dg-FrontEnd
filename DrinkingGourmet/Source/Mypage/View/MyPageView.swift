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
    
    let nameLabel = UILabel().then {
        $0.text = "이름 님"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
    }
    
    let providerIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_login_kakao")
    }
    
    let informationButton = UIButton().then {
        $0.setTitle("기본 정보 보기", for: .normal)
        $0.setTitleColor(UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
    }
    
    private let arrowIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_more")
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
                          nameLabel,
                          providerIcon,
                          informationButton,
                          arrowIcon,
                          tapmanView])
    }
    
    private func configureConstraints() {
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(33)
            make.leading.equalToSuperview().offset(20)
            make.size.equalTo(64)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.top).inset(10)
            make.leading.equalTo(profileImage.snp.trailing).offset(20)
        }
        
        providerIcon.snp.makeConstraints { make in
            make.top.equalTo(nameLabel)
            make.leading.equalTo(nameLabel.snp.trailing).offset(8)
            make.size.equalTo(20)
        }
        
        informationButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nameLabel)
        }
        
        arrowIcon.snp.makeConstraints { make in
            make.centerY.equalTo(profileImage)
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(12)
        }
        
        tapmanView.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
