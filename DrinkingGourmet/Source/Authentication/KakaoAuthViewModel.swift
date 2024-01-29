//
//  KakaoAuthViewModel.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 1/28/24.
//

import Foundation
import Combine
import KakaoSDKAuth
import KakaoSDKUser

class KakaoAuthViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    // 로그인 여부를 저장
    @Published var isLoggedIn: Bool = false
    
    lazy var loginStatusInfo: AnyPublisher<String?, Never> = $isLoggedIn.compactMap { $0 ? "로그인 상태" : "로그아웃 상태" }.eraseToAnyPublisher()
    
    init() {
        print("kakaoauthVM - init")
    }
    
    @MainActor  // 내부적으로 UI를 건드나 싶어서 추가
    func kakaoLoginWithApp() async -> Bool {    // 카카오 앱으로 로그인
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {  // 로그인 실패
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    //do something
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    @MainActor
    func kakaoLoginWithAccount() async -> Bool {    // 카카오 계정으로 로그인
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    
                    //do something
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    @MainActor  // isLoggedIn 때문에 메인 스레드에서 실행하게끔
    func kakaoLogin() {
        print("kakaoauthVM - handleKaKaoLogin")
        
        Task {
            // 카카오톡 앱 실행 가능 여부 확인.
            if (UserApi.isKakaoTalkLoginAvailable()) {
                isLoggedIn = await kakaoLoginWithApp()
            } else { // 앱 실행 불가능일 경우, 카카오 계정으로 로그인
                isLoggedIn = await kakaoLoginWithAccount()
            }
        }
    }
    
    @MainActor
    func kakaoLogut() {
        Task {
            if await handleKakaoLogout() {
                self.isLoggedIn = false
            }
        }
    }
    
    func handleKakaoLogout() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("logout() success.")
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
}
