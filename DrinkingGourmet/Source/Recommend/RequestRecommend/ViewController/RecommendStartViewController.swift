//
//  RecommendStartViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/4/24.
//

import UIKit

final class RecommendStartViewController: UIViewController {
    // MARK: - Properties
    private let recommendstartView = RecommendStartView()
    
    // MARK: - View 설정
    override func loadView() {
        view = recommendstartView
    }
    
    // MARK: - ViewDidLodad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepare()
        setupNaviBar()
        setupButton()
    }
    
    private func prepare() {
        recommendstartView.nextButton.backgroundColor = .black
        recommendstartView.nextButton.label.text = "시작하기"
        recommendstartView.nextButton.button.isEnabled = true
    }
    
    private func setupNaviBar() {
        title = "주류 추천"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupButton() {
        recommendstartView.nextButton.button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension RecommendStartViewController {
    @objc private func startButtonTapped() {
        RecommendRequestDTO.shared.desireLevel = 0
        RecommendRequestDTO.shared.foodName = ""
        RecommendRequestDTO.shared.mood = ""
        RecommendRequestDTO.shared.weather = ""
        
        let VC = InputIntoxicationViewController()
        navigationController?.pushViewController(VC, animated: true)
    }
}
