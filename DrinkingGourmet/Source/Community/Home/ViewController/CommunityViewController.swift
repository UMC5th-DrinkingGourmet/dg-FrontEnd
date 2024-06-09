//
//  CommunityViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

final class CommunityViewController: UIViewController {
    
    private let communityView = CommunityView()
    
    // MARK: - View 설정
    override func loadView() {
        view = communityView
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNaviBar()
        setupButtons()
    }
    
    private func setupNaviBar() {
        title = "커뮤니티"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // 불투명
        appearance.backgroundColor = .white
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupButtons() {
        communityView.combinationButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        communityView.weeklyBestButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        communityView.recipeBookButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
}

// MARK: - @objc
extension CommunityViewController {
    @objc private func buttonTapped(_ sender: UIButton) {
        var destinationVC: UIViewController
        
        switch sender {
        case communityView.combinationButton:
            destinationVC = CombiationViewController()
        case communityView.weeklyBestButton:
            destinationVC = WeeklyBestVC()
        case communityView.recipeBookButton:
            destinationVC = RecipeBookHomeVC()
        default:
            return
        }
        
        destinationVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
