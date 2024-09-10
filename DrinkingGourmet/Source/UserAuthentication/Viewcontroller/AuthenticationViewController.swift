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
    private var isKakaoUserInfoLoaded = false
    private var isKakaoLoggedIn = false
    
    private let kakaoAuthVM: KakaoAuthViewModel = { KakaoAuthViewModel() } ()
    private let appleAuthVM: AppleAuthViewModel = { AppleAuthViewModel() }()
    
    private let backgroundImageview = UIImageView(
        image: UIImage(named: "img_splash_background")
    ).then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let titleLabel = UILabel().then {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 12

        let attrString = NSMutableAttributedString(string: "술과 음식의\n미식 여행\n음주미식회")
        attrString.addAttribute(.kern, value: 0.45, range: NSMakeRange(0, attrString.length))
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))

        $0.attributedText = attrString
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        $0.textAlignment = .left
        $0.numberOfLines = 3
    }

    private let kakaoBtn = UIButton().then {
        $0.setImage(UIImage(named: "ic_login_kakao"), for: .normal)
    }
    
    private let naverBtn = UIButton().then {
        $0.setImage(UIImage(named: "ic_login_naver"), for: .normal)
        $0.isHidden = true
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
            navigateToMainMenu()
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
            navigateToMainMenu()
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
            $0.trailing.equalTo(naverBtn.snp.leading)
        }
        
        appleBtn.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.top.equalTo(naverBtn.snp.top)
            $0.leading.equalTo(naverBtn.snp.trailing)
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
                    self?.handleLogin()
                }
            }
            .store(in: &subscriptions)
        //            .sink { [weak self] isLoggedIn in
        //                if isLoggedIn {
        //                    DispatchQueue.main.async {
        //                        // 이미 TermsViewController가 푸시되었는지 확인
        //                        if self?.navigationController?.topViewController is TermsViewController {
        //                            return
        //                        }
        //
        //                        self?.navigationController?.pushViewController(TermsViewController(), animated: true)
        //                    }
        //                }
        //            }
        //            .store(in: &subscriptions)
        
        
        
        kakaoAuthVM.$userInfo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                guard let self = self, let validUser = user, validUser.id != -1 else { return }
                
                // 필요한 사용자 정보 설정
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
                UserDefaultManager.shared.email = user?.kakaoAccount?.email ?? "-1"
                UserDefaultManager.shared.providerId = String(validUser.id ?? -1)
                
                print("유저 정보1: \(String(validUser.id ?? -1))")
                print("유저 정보2: \(UserDefaultManager.shared.providerId)")
                
                // 사용자 정보가 성공적으로 로드된 경우 플래그 설정
                self.isKakaoUserInfoLoaded = true
                self.checkKakaoLoginStatus()
            }
            .store(in: &subscriptions)
        
        // 로그인 성공 시
        kakaoAuthVM.$isLoggedIn
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoggedIn in
                guard let self = self else { return }
                self.isKakaoLoggedIn = isLoggedIn
                self.checkKakaoLoginStatus()
            }
            .store(in: &subscriptions)
    }
    
    // 두 상태가 모두 충족될 때 handleLogin 호출
    private func checkKakaoLoginStatus() {
        if isKakaoUserInfoLoaded && isKakaoLoggedIn {
            handleLogin()
        }
    }
    
    private func handleLogin() {
        let signInfo = SignInfoDTO(
            provider: UserDefaultManager.shared.provider,
            providerId: UserDefaultManager.shared.providerId
        )
        
        SignService.shared.checkUserDivision(signInfo: signInfo) { [weak self] userDivision in
            guard let self = self else { return }
            guard let userDivision = userDivision else {
                print("로그인/회원가입 확인 실패")
                return
            }
            
            if userDivision.isSignedUp {
                let userInfo = UserInfo(
                    name: UserDefaultManager.shared.userName,
                    profileImage: UserDefaultManager.shared.userProfileImg,
                    email: UserDefaultManager.shared.email,
                    nickName: UserDefaultManager.shared.userNickname,
                    birthDate: UserDefaultManager.shared.userBirth,
                    phoneNumber: UserDefaultManager.shared.userPhoneNumber,
                    gender: UserDefaultManager.shared.userGender,
                    provider: UserDefaultManager.shared.provider,
                    providerId: UserDefaultManager.shared.providerId
                )
                
                SignService.shared.sendUserInfo(userInfo) { [weak self] userStatus in
                    guard let self = self else { return }
                    guard let userStatus = userStatus else {
                        print("로그인 실패")
                        return
                    }

                    UserDefaultManager.shared.userId = String(userStatus.memberId)
                    UserDefaultManager.shared.userNickname = userStatus.nickName
                    self.navigateToMainMenu()
                }
            } else {
                let termsVC = TermsViewController()
                self.navigationController?.pushViewController(termsVC, animated: true)
            }
        }
    }

    private func navigateToMainMenu() {
        let tabBarVC = TabBarViewController()
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            print("UIWindow를 찾을 수 없습니다.")
            return
        }
//        window.rootViewController = UINavigationController(rootViewController: tabBarVC)
//        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        
//        let VC = tabBarVC
//        navigationController?.pushViewController(VC, animated: true)
        
        tabBarVC.modalPresentationStyle = .fullScreen
        self.present(tabBarVC, animated: true, completion: nil)
    }
}
