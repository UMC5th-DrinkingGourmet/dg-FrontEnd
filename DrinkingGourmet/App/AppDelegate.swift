//
//  AppDelegate.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 1/6/24.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var kakaoAuthVM = KakaoAuthViewModel()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        sleep(1)
        
        let appKey = Bundle.main.infoDictionary?["KAKAO_APP_KEY"] ?? ""
        
        KakaoSDK.initSDK(appKey: appKey as! String)

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // 웹 브라우저에서 URL이 열리게 되면, 카카오 로그인 scheme이랑 일치하는지 체크
        if (AuthApi.isKakaoTalkLoginUrl(url)) { // 일차할 경우 웹뷰(AuthController)를 연다
            print("scheme과 일치하지 않습니다")
            return AuthController.handleOpenUrl(url: url)
        }

        return false
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

