//
//  RecommendViewController.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 1/6/24.
//

import UIKit
import SnapKit

class MyDrinkStyleViewController: UIViewController {
       
    lazy var guideText: UILabel = {
        let text = UILabel()
        text.textColor = UIColor.baseColor.base01
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 24)
        text.text = "오늘은 어떤 주류와\n어울리는 음식으로\n기분전환을 해보시겠어요?"
        return text
    }()
    
    private lazy var recommendButton: CustomizedRecommendButtons = {
        let button = CustomizedRecommendButtons(buttonTitle: "주류추천")
        return button
    }()
    private lazy var myRecommendButton: CustomizedRecommendButtons = {
        let button = CustomizedRecommendButtons(buttonTitle: "내가 받은 추천")
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.baseColor.base10
        
        // navigation
        title = "주류추천"
        navigationItem.hidesBackButton = true
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.baseColor.base01]
        navigationController?.navigationBar.tintColor = UIColor.baseColor.base01
        navigationController?.navigationBar.isTranslucent = true
        
        setAddSubViews()
        makeConstraints()
    }
    
    // MARK: - Navigation
    @objc func nextButtonTapped(_ sender: UIButton) {
        let nextViewController = RecommendViewController()
        nextViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nextViewController, animated: true)
    }

    @objc func myRecommendButtonTapped(_ sender: UIButton) {
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

    
    // MARK: - Constraints
    func setAddSubViews() {
        view.addSubview(guideText)
        view.addSubview(myRecommendButton)
        view.addSubview(recommendButton)
    }
    
    func makeConstraints() {
        guideText.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(43)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(108)
        }
        
        recommendButton.snp.makeConstraints { make in
            make.bottom.equalTo(myRecommendButton.snp.top).offset(-16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            recommendButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        }
        
        myRecommendButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-48)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            myRecommendButton.addTarget(self, action: #selector(myRecommendButtonTapped(_:)), for: .touchUpInside)
        }
    }
}
