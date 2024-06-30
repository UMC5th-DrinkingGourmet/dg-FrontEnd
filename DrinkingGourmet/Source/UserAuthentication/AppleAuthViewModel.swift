//
//  AppleAuthViewModel.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 6/16/24.
//

import Foundation
import Combine
import AuthenticationServices

class AppleAuthViewModel: NSObject, ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    override init() {
        super.init()
    }
    
    func handleAppleLogin() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension AppleAuthViewModel: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            UserDefaultManager.shared.providerId = userIdentifier
            UserDefaultManager.shared.userName = "\(fullName?.givenName ?? "") \(fullName?.familyName ?? "")"
            UserDefaultManager.shared.email = email ?? ""
            UserDefaultManager.shared.userBirth = ""
            UserDefaultManager.shared.userPhoneNumber = ""
            UserDefaultManager.shared.userProfileImg = ""
            UserDefaultManager.shared.userGender = ""
            UserDefaultManager.shared.provider = "apple"
            
            print(UserDefaultManager.shared.userName)
            
            // 로그인 성공 시
            DispatchQueue.main.async {
                self.isLoggedIn = true
            }
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("애플 로그인 실패: \(error.localizedDescription)")
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first!
    }
}
