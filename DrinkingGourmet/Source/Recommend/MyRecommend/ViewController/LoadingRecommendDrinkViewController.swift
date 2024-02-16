//
//  LoadingRecommendDrinkViewController.swift
//  DrinkingGourmet
//
//  Created by 김희은 on 1/15/24.
//

import UIKit
import Lottie

class LoadingRecommendDrinkViewController: UIViewController {
    
    lazy var guideText: UILabel = {
        let text = UILabel()
        text.textColor = UIColor.baseColor.base01
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 24)
        text.text = "00님을 위한 주류를\n선정하고 있어요."
        return text
    }()
    
    lazy var loadingAnimationView: LottieAnimationView = {
        let animation = LottieAnimation.named("Animation - 1707200937141")
        let animationView = LottieAnimationView(animation: animation)
        animationView.loopMode = .loop // 애니메이션을 반복 재생하도록 설정
        return animationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.baseColor.base10
        
        // navigation
        title = "주류추천"
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backButton
        
        // 임시 타이머
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
        
        loadingAnimationView.play()
        setAddSubViews()
        makeConstraints()
    }
    
    // MARK: - Actions
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    @objc func timerAction() {
        // - 3초 지연 일시 적용 - //
        let nextViewController = RecommendViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
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
