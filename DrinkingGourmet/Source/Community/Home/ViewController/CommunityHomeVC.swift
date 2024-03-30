//
//  CommunityHomeVC.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

final class CommunityHomeVC: UIViewController {
    
    private let communityHomeView = CommunityHomeView()
    
    // MARK: - View 설정
    override func loadView() {
        view = communityHomeView
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
        communityHomeView.combinationButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        communityHomeView.weeklyBestButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        communityHomeView.recipeBookButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
}

// MARK: - @objc
extension CommunityHomeVC {
    @objc private func buttonTapped(_ sender: UIButton) {
        var destinationVC: UIViewController
        
        switch sender {
        case communityHomeView.combinationButton:
            destinationVC = TodayCombinationViewController()
        case communityHomeView.weeklyBestButton:
            destinationVC = WeeklyBestVC()
        case communityHomeView.recipeBookButton:
            destinationVC = RecipeBookHomeVC()
        default:
            return
        }
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
