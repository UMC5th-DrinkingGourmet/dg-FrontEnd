//
//  AuthenticationViewController.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 1/22/24.
//

import UIKit
import SnapKit
import Then

class AuthenticationViewController: UIViewController {
    
    private let backgroundImageview = UIImageView(
        image: UIImage(named: "img_splash_background")
    ).then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "술과 음식의\n미식 여행\n음주미식회"
        $0.numberOfLines = 3
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 40, weight: .heavy)
    }

    private let kakaoBtn =  UIButton().then {
        $0.setImage(UIImage(named: "ic_login_kakao"), for: .normal)
    }
    
    private let naverBtn =  UIButton().then {
        $0.setImage(UIImage(named: "ic_login_naver"), for: .normal)
    }
    
    private let appleBtn =  UIButton().then {
        $0.setImage(UIImage(named: "ic_login_apple"), for: .normal)
    }
    
    private let loginLabel = UILabel().then {
        $0.text = "SNS 계정으로 간편 로그인하기"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 12)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        configBtn()
        layout()
    }
    
    func configBtn() {
        kakaoBtn.layer.cornerRadius = kakaoBtn.frame.width / 2
        naverBtn.layer.cornerRadius = naverBtn.frame.width / 2
        appleBtn.layer.cornerRadius = appleBtn.frame.width / 2
    }
    
    private func layout() {
        view.addSubviews([
            backgroundImageview,
            titleLabel,
            kakaoBtn,
            naverBtn,
            appleBtn,
            loginLabel
        ])
        
        backgroundImageview.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(40)
        }
        
        naverBtn.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(100)
        }
        
        kakaoBtn.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.top.equalTo(naverBtn.snp.top)
            $0.trailing.equalTo(naverBtn.snp.leading).offset(-30)
        }
        
        appleBtn.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.top.equalTo(naverBtn.snp.top)
            $0.leading.equalTo(naverBtn.snp.trailing).offset(30)
        }
        
        loginLabel.snp.makeConstraints {
            $0.bottom.equalTo(naverBtn.snp.top).offset(-12)
            $0.centerX.equalToSuperview()
        }
    }
}
