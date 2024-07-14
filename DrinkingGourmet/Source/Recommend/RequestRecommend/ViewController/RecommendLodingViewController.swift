//
//  RecommendLodingViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/4/24.
//

import UIKit

final class RecommendLodingViewController: UIViewController {
    // MARK: - Properties
    private let recommendLodingView = RecommendLodingView()
    
    // MARK: - View 설정
    override func loadView() {
        view = recommendLodingView
    }
    
    // MARK: - ViewDidLodad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNaviBar()
        setupAnimation()
        fetchData()
    }
    
    private func setupNaviBar() {
        title = "주류 추천"
        navigationItem.hidesBackButton = true
    }
    
    private func setupAnimation() {
        recommendLodingView.animationView.play()
        recommendLodingView.animationView.loopMode = .loop
    }
    
    private func fetchData() {
        RecommendService.shared.postRecommend(request: RecommendRequestDTO.shared) { result in
            switch result {
            case .success(let data):
                print("주류추천 요청 성공")
                let VC = RecommendResultViewController()
                VC.recommendResult = data.result
                self.navigationController?.pushViewController(VC, animated: true)
            case .failure(let error):
                print("주류추천 요청 실패 - \(error.localizedDescription)")
            }
        }
    }
}
