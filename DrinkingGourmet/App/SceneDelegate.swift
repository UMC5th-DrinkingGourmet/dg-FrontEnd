//
//  SceneDelegate.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 1/6/24.
//

import UIKit
import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        do {
            let refreshToken = try Keychain.shared.getToken(kind: .refreshToken)
            print("Refresh Token 존재: \(refreshToken)")

            if TokenParser.isTokenExpired(refreshToken) {
                print("RefreshToken이 만료되었습니다. 로그인 화면을 띄웁니다.")
                window.rootViewController = UINavigationController(rootViewController: AuthenticationViewController())
            } else {
                print("RefreshToken이 유효합니다. 메인 화면으로 이동합니다.")
                SignService.shared.loginWithProviderInfo { [weak self] in
                    DispatchQueue.main.async {
                        print("자동로그인이 성공하여 MainVC로 이동합니다.")
                        self?.window?.rootViewController = TabBarViewController()
                    }
                }
            }
        } catch {
            print("Refresh Token을 찾을 수 없음: \(error)")
            window.rootViewController = UINavigationController(rootViewController: AuthenticationViewController())
        }

        window.makeKeyAndVisible()
        
        registerForNotifications()
    }

    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleRefreshTokenExpired), name: Notification.Name("refreshTokenExpired"), object: nil)
    }

    @objc private func handleRefreshTokenExpired() {
        DispatchQueue.main.async {
            print("Refresh token이 만료되었습니다. 로그인 화면으로 이동합니다.")
            let loginViewController = AuthenticationViewController()
            if let window = self.window {
                window.rootViewController = loginViewController
                window.makeKeyAndVisible()
            }
        }
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

