//
//  LoadingRecommendDrinkViewController.swift
//  DrinkingGourmet
//
//  Created by 김희은 on 1/15/24.
//

import UIKit
import Lottie

class LoadingRecommendDrinkViewController: UIViewController {
    let myRecommendModelManager = MyRecommendModelManager.shared
    
    var startTime: Date?
      var elapsedTime: TimeInterval = 0
      var timer: Timer?
    
    lazy var guideText: UILabel = {
        let text = UILabel()
        text.textColor = UIColor.baseColor.base01
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 24)
        text.text = "\(UserDefaultManager.shared.userNickname)님을 위한 주류를\n선정하고 있어요."
        return text
    }()
    
    lazy var loadingAnimationView: LottieAnimationView = {
        let animation = LottieAnimation.named("Animation - 1707200937141")
        let animationView = LottieAnimationView(animation: animation)
        animationView.loopMode = .loop // 애니메이션을 반복 재생
        return animationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.baseColor.base10
        
        // navigation
        title = "주류추천"
        navigationItem.hidesBackButton = true
        
        // 타이머 시작
        startTime = Date()
        // 1초마다 timerHandler 메서드 호출
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerHandler), userInfo: nil, repeats: true)
        
        loadingAnimationView.play()
        setAddSubViews()
        makeConstraints()
    }
    
    // MARK: - Timer
    @objc func timerHandler() {
        // 1초마다 elapsedTime 증가
        elapsedTime += 1
        
        // 주류 추천 완료 여부 확인
        if let time = myRecommendModelManager.netWorkDuration, elapsedTime >= time {
            // 타이머 정지
            timer?.invalidate()
            timer = nil
            
            // 주류 추천 완료 시 다음 뷰컨트롤러로 이동
            let nextViewController = GetDrinkingRecommendViewController()
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
        
    // MARK: - Constraints
    func setAddSubViews() {
        view.addSubview(guideText)
        view.addSubview(loadingAnimationView)
    }
    
    func makeConstraints() {
        guideText.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(72)
        }
        loadingAnimationView.snp.makeConstraints { make in
            make.top.equalTo(guideText.snp.bottom).offset(150)
            make.centerX.equalToSuperview()
            make.width.equalTo(90)
            make.height.equalTo(90)
        }
    }
}
