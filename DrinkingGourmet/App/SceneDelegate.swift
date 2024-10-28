//
//  SceneDelegate.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 1/6/24.
//

import UIKit
import KakaoSDKAuth
import Toast

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        if !UserDefaultManager.shared.provider.isEmpty,
           !UserDefaultManager.shared.providerId.isEmpty {
            SignService.shared.loginWithProviderInfo { [weak self] in
                DispatchQueue.main.async {
                    print("자동로그인이 성공하여 MainVC로 이동합니다.")
                    self?.window?.rootViewController = TabBarViewController()
                }
            }
        } else {
            self.window?.rootViewController = UINavigationController(rootViewController: AuthenticationViewController())
        }

        window.makeKeyAndVisible()
        
        registerForNotifications()
    }

    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleRefreshTokenExpired), name: Notification.Name("refreshTokenExpired"), object: nil)
    }

    @objc private func handleRefreshTokenExpired() {
        DispatchQueue.main.async {
            print("Refresh token이 만료되었습니다.")

            if let rootVC = self.window?.rootViewController {
                rootVC.view.makeToast("다시 로그인해주세요.", duration: 3.0, position: .bottom)
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                let loginViewController = AuthenticationViewController()
                if let window = self.window {
                    window.rootViewController = loginViewController
                    window.makeKeyAndVisible()
                }
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

