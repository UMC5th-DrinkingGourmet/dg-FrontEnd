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
import KakaoSDKCommon

class KakaoAuthViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    // 로그인 여부를 저장
        @Published var isLoggedIn: Bool = false
    // 사용자 정보를 저장
    @Published var userInfo: User? = nil
    
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
                    
                    Task {
                        await self.setUserInfo()
                    }
                    
                    self.isLoggedIn = true // 로그인 상태 업데이트
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
                    
                    Task {
                        await self.setUserInfo()
                    }
                    
                    self.isLoggedIn = true // 로그인 상태 업데이트
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    
    @MainActor
        func checkTokenValidity() async -> Bool {    // 토큰 유효성 체크
           await withCheckedContinuation { continuation in
               if (AuthApi.hasToken()) {
                   UserApi.shared.accessTokenInfo { (_, error) in
                       if let error = error {
                           if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true {
                               continuation.resume(returning: false)
                           } else {
                               continuation.resume(returning: false)
                           }
                       } else {
                           continuation.resume(returning: true)
                       }
                   }
               } else {
                   continuation.resume(returning: false)
               }
           }
        }
        
        @MainActor
        func kakaoLogin() {
            Task {
                if await checkTokenValidity() {
                    await setUserInfo()
                    self.isLoggedIn = true
                } else {
                    if (UserApi.isKakaoTalkLoginAvailable()) {
                        isLoggedIn = await kakaoLoginWithApp()
                    } else { // 앱 실행 불가능일 경우, 카카오 계정으로 로그인
                        isLoggedIn = await kakaoLoginWithAccount()
                    }
                }
            }
        }
    
    @MainActor
        func kakaoLoginWithAccountPrompt() async -> Bool {  // 간편 로그인
            await withCheckedContinuation { continuation in
                UserApi.shared.loginWithKakaoAccount(prompts:[.SelectAccount]) {(oauthToken, error) in
                    if let error = error {
                        print(error)
                        continuation.resume(returning: false)
                    }
                    else {
                        print("loginWithKakaoAccount() success.")
                        
                        //do something
                        _ = oauthToken
                        
                        Task {
                            await self.setUserInfo()
                        }
                        
                        continuation.resume(returning: true)
                    }
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
    
    @MainActor
    func setUserInfo() async {
        await withCheckedContinuation { continuation in
            UserApi.shared.me() {(user, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: ())
                }
                else {
                    print("me() success.")
                    //do something
                    self.userInfo = user
                    continuation.resume(returning: ())
                }
            }
        }
    }
}
