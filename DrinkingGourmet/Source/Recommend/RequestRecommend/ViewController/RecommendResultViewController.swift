//
//  RecommendResultViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/4/24.
//

import UIKit

final class RecommendResultViewController: UIViewController {
    // MARK: - Properties
    var recommendResult: RecommendResultDTO?
    
    private let recommendResultView = RecommendResultView()
    
    // MARK: - View 설정
    override func loadView() {
        view = recommendResultView
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepare()
        setupNaviBar()
        setupButton()
    }
    
    private func prepare() {
        guard let recommendResult = self.recommendResult else { return }
        
        if let url = URL(string: recommendResult.imageUrl) {
            recommendResultView.image.kf.setImage(with: url)
        }
        recommendResultView.titleLabel.text = "\(recommendResult.foodName) & \(recommendResult.drinkName)"
        recommendResultView.descriptionLabel.text = recommendResult.recommendReason
    }
    
    private func setupNaviBar() {
        title = "주류 추천"
        navigationItem.hidesBackButton = true
    }
    
    private func setupButton() {
        recommendResultView.anotherButton.addTarget(self, action: #selector(anotherButtonTapped), for: .touchUpInside)
        recommendResultView.myRecommendButton.addTarget(self, action: #selector(myRecommendButtonTaaped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension RecommendResultViewController {
    @objc private func anotherButtonTapped() {
        if let tabBarVC = self.tabBarController as? TabBarViewController {
            // '주류추천' 탭을 선택
            tabBarVC.selectedIndex = 0
            
            // '주류추천' 탭의 네비게이션 컨트롤러를 가져옴
            if let vc = tabBarVC.viewControllers?[0] as? UINavigationController {
                // 네비게이션 컨트롤러의 스택을 루트 뷰 컨트롤러로 초기화
                vc.popToRootViewController(animated: true)
            }
        }
    }
    
    @objc private func myRecommendButtonTaaped() {
        if let tabBarVC = self.tabBarController as? TabBarViewController {
            // '마이페이지' 탭을 선택
            tabBarVC.selectedIndex = 4
            
            // '마이페이지' 탭의 네비게이션 컨트롤러를 가져옴
            if let vc = tabBarVC.viewControllers?[4] as? UINavigationController {
                // 네비게이션 컨트롤러의 스택을 루트 뷰 컨트롤러로 초기화
                vc.popToRootViewController(animated: true)
            }
        }
    }
}
