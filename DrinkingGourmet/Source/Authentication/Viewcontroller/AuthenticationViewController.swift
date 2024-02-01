//
//  AuthenticationViewController.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 1/22/24.
//

import UIKit
import SnapKit
import Then
import Combine
import Kingfisher

class AuthenticationViewController: UIViewController {
    
    var subscriptions = Set<AnyCancellable>()
    
    private let kakaoAuthVM: KakaoAuthViewModel = { KakaoAuthViewModel() } ()
    
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
        setBindings()
    }
    
    private func config() {
        configBtn()
        layout()
    }
    
    func configBtn() {
        kakaoBtn.layer.cornerRadius = kakaoBtn.frame.width / 2
        kakaoBtn.addTarget(self, action: #selector(kakaoBtnClicked), for: .touchUpInside)
        
        naverBtn.layer.cornerRadius = naverBtn.frame.width / 2
        appleBtn.layer.cornerRadius = appleBtn.frame.width / 2
    }
    
    @objc func kakaoBtnClicked() {
        kakaoAuthVM.kakaoLogin()
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

extension AuthenticationViewController {
    fileprivate func setBindings() {
//        //방법 1
//        self.kakaoAuthVM.$isLoggedIn.sink { [weak self] isLoggedIn in
//            guard let self = self else { return }
////            self.loginLabel.text = isLoggedIn ? "it is login" : "it is no login"
//        }
//        .store(in: &subscriptions)
        
    
//        // 방법 2
        self.kakaoAuthVM.loginStatusInfo
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: self.loginLabel)
            .store(in: &subscriptions)
        
        kakaoAuthVM.$userInfo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.titleLabel.text = user?.kakaoAccount?.profile?.nickname ?? "로그인 필요"
                
                if let url = user?.kakaoAccount?.profile?.profileImageUrl {
                    self?.backgroundImageview.kf.setImage(with: url)
                }
            }
            .store(in: &subscriptions)
        
        // 로그인 성공시
        kakaoAuthVM.$isLoggedIn
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoggedIn in
                if isLoggedIn {
                    let termsViewController = TermsViewController()
                    termsViewController.modalPresentationStyle = .fullScreen
                    self?.present(termsViewController, animated: true, completion: nil)
                }
            }
            .store(in: &subscriptions)
    }
}
