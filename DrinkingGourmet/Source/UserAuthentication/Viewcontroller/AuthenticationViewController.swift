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
import KakaoSDKUser
import AuthenticationServices

class AuthenticationViewController: UIViewController {
    
    var subscriptions = Set<AnyCancellable>()
    
    private let kakaoAuthVM: KakaoAuthViewModel = { KakaoAuthViewModel() } ()
    private let appleAuthVM: AppleAuthViewModel = { AppleAuthViewModel() }()
    
    private let backgroundImageview = UIImageView(
        image: UIImage(named: "img_splash_background")
    ).then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let titleLabel = UILabel().then {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 12 // 줄 사이 간격 설정

        let attrString = NSMutableAttributedString(string: "술과 음식의\n미식 여행\n음주미식회")
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))

        $0.attributedText = attrString
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        $0.textAlignment = .left
        $0.numberOfLines = 3
    }

    private let kakaoBtn = UIButton().then {
        $0.setImage(UIImage(named: "ic_login_kakao"), for: .normal)
    }
    
    private let naverBtn = UIButton().then {
        $0.setImage(UIImage(named: "ic_login_naver"), for: .normal)
    }
    
    private let appleBtn = UIButton().then {
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
        appleBtn.addTarget(self, action: #selector(appleBtnClicked), for: .touchUpInside)
    }
    
    @objc func kakaoBtnClicked() {
        do {
             // 리프레시 토큰의 유효성 검사
            let _ = try Keychain.shared.getToken(kind: .refreshToken)
            let mainMenuVC = MainMenuViewController()
            // MainMenuViewController로 이동
            self.navigationController?.pushViewController(mainMenuVC, animated: true)
            return
//            UserInfoDataManager.shared.loginWithProviderInfo { [weak self] in
//                        DispatchQueue.main.async {
//                            let mainMenuVC = MainMenuViewController()
//                            // MainMenuViewController로 이동
//                            self?.navigationController?.pushViewController(mainMenuVC, animated: true)
//                        }
//                    }
        } catch KeyChainError.noData {
            // 리프레시 토큰이 없는 경우
            let alert = UIAlertController(title: "카카오톡 로그인", message: "카카오톡으로 로그인하시겠습니까?", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
                self?.kakaoAuthVM.kakaoLogin()
                UserDefaultManager.shared.provider = "kakao"
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: nil)
        } catch {
            print("unexpected error")
        }
    }
    
    @objc func appleBtnClicked() {
        do {
            // 리프레시 토큰의 유효성 검사
            let _ = try Keychain.shared.getToken(kind: .refreshToken)
            let mainMenuVC = MainMenuViewController()
            // MainMenuViewController로 이동
            self.navigationController?.pushViewController(mainMenuVC, animated: true)
            return
        } catch KeyChainError.noData {
            // 리프레시 토큰이 없는 경우
            let alert = UIAlertController(title: "애플 로그인", message: "애플 계정으로 로그인하시겠습니까?", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
                self?.appleAuthVM.handleAppleLogin()
                UserDefaultManager.shared.provider = "apple"
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: nil)
        } catch {
            print("unexpected error")
        }
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
        
        // 애플 로그인 성공 시
        appleAuthVM.$isLoggedIn
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoggedIn in
                if isLoggedIn {
                    DispatchQueue.main.async {
                        // 이미 TermsViewController가 푸시되었는지 확인
                        if self?.navigationController?.topViewController is TermsViewController {
                            return
                        }

                        self?.navigationController?.pushViewController(TermsViewController(), animated: true)
                    }
                }
            }
            .store(in: &subscriptions)
            
        // 로그인 성공시
        kakaoAuthVM.$isLoggedIn
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoggedIn in
                if isLoggedIn {
                    DispatchQueue.main.async {
                        // 이미 TermsViewController가 푸시되었는지 확인
                        if self?.navigationController?.topViewController is TermsViewController {
                            return
                        }

                        self?.navigationController?.pushViewController(TermsViewController(), animated: true)
                    }
                }
            }
            .store(in: &subscriptions)

        
        kakaoAuthVM.$userInfo
            .receive(on: DispatchQueue.main)
            .sink { user in
                guard let validUser = user, validUser.id != -1 else { return }
                UserDefaultManager.shared.userName = validUser.kakaoAccount?.profile?.nickname ?? "-1"
                
                UserDefaultManager.shared.userBirth = (user?.kakaoAccount?.birthyear ?? "-1") + (user?.kakaoAccount?.birthday ?? "-1")
                
                // 전화번호 format
                var phoneNumber = user?.kakaoAccount?.phoneNumber ?? "-1"
                if phoneNumber.hasPrefix("+82 ") {
                    let index = phoneNumber.index(phoneNumber.startIndex, offsetBy: 4)
                    phoneNumber = "0" + phoneNumber[index...].replacingOccurrences(of: "-", with: "")
                }
                
                UserDefaultManager.shared.userPhoneNumber = phoneNumber
                
                if let url = user?.kakaoAccount?.profile?.profileImageUrl {
                    let urlString = url.absoluteString
                    
                    UserDefaultManager.shared.userProfileImg = urlString
                }
                
                UserDefaultManager.shared.userGender = user?.kakaoAccount?.gender?.rawValue ?? "-1"
                
                UserDefaultManager.shared.email = user?.kakaoAccount?.email ?? "-l"
                
                UserDefaultManager.shared.providerId = String(validUser.id ?? -1)
            }
            .store(in: &subscriptions)
    }
}
