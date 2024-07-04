//
//  RecommendGuideViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/3/24.
//

import UIKit

final class RecommendGuideViewController: UIViewController {
    // MARK: - Properties
    private let recommendGuideView = RecommendGuideView()
    
    // MARK: - View 설정
    override func loadView() {
        view = recommendGuideView
    }
    
    // MARK: - ViewDidLodad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNaviBar()
        setupButton()
    }
    
    private func setupNaviBar() {
        title = "주류 추천"
        
        // 백버튼 커스텀
        let customBackImage = UIImage(named: "ic_back")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = customBackImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = customBackImage
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupButton() {
        recommendGuideView.recommendButton.addTarget(self, action: #selector(recommendButtonTapped), for: .touchUpInside)
        recommendGuideView.myRecommendButton.addTarget(self, action: #selector(myRecommendButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension RecommendGuideViewController {
    @objc private func recommendButtonTapped() {
        let VC = RecommendStartViewController()
        VC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc private func myRecommendButtonTapped() {
        if let tabBarVC = self.tabBarController as? TabBarViewController {
            // '마이페이지' 탭을 선택
            tabBarVC.selectedIndex = 4
            
            // '마이페이지' 탭의 네비게이션 컨트롤러를 가져옴
            if let myPageNavController = tabBarVC.viewControllers?[4] as? UINavigationController {
                // 네비게이션 컨트롤러의 스택을 루트 뷰 컨트롤러로 초기화
                myPageNavController.popToRootViewController(animated: true)
            }
        }
    }
}
