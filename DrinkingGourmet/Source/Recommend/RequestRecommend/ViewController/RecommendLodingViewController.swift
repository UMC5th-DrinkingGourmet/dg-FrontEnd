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
    private var toggleTimer: Timer?
    private var isSearchingText = true
    private var startTime: Date?
    
    // MARK: - View 설정
    override func loadView() {
        view = recommendLodingView
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNaviBar()
        setupAnimation()
        startToggleTextTimer() // 타이머 시작
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
    
    // 타이머 시작
    private func startToggleTextTimer() {
        startTime = Date()
        toggleTimer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(toggleText), userInfo: nil, repeats: true)
    }
    
    // 타이머 정지
    private func stopToggleTextTimer() {
        toggleTimer?.invalidate()
        toggleTimer = nil
    }
    
    // 텍스트 교체
    @objc private func toggleText() {
        guard let startTime = startTime else { return }
        let elapsedTime = Date().timeIntervalSince(startTime)
        
        if elapsedTime <= 12 {
            // 0 ~ 10초
            recommendLodingView.timeRequiredLabel.text = isSearchingText ? "맛있는 조합을 연구 중입니다" : "완벽한 조합을 찾고 있어요"
        } else {
            // 10초 이후
            recommendLodingView.timeRequiredLabel.text = isSearchingText ? "좋은 조합이 떠올랐어요!" : "거의 다 됐어요!"
        }
        
        isSearchingText.toggle()
    }
    
    private func fetchData() {
        RecommendService.shared.postRecommend(request: RecommendRequestDTO.shared) { result in
            switch result {
            case .success(let data):
                print("주류추천 요청 성공")
                self.stopToggleTextTimer() // 타이머 정지
                
                let VC = RecommendResultViewController()
                VC.recommendResult = data.result
                self.navigationController?.pushViewController(VC, animated: true)
            case .failure(let error):
                print("주류추천 요청 실패 - \(error.localizedDescription)")
            }
        }
    }
}
