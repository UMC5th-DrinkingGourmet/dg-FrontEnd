//
//  LoadingRecommendDrinkViewController.swift
//  DrinkingGourmet
//
//  Created by 김희은 on 1/15/24.
//

import UIKit

class LoadingRecommendDrinkViewController: UIViewController {
    
    lazy var guideText: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 24)
        text.text =
        "00님을 위한 주류를\n선정하고 있어요."
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // navigation
        title = "주류추천"
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backButton
        
        // 임시 타이머
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
        
        setAddSubViews()
        makeConstraints()
    }
    
    // MARK: - Actions
    @objc func backButtonPressed() {
        // Handle the back button press (e.g., pop view controller)
        navigationController?.popViewController(animated: true)
    }
    @objc func timerAction() {
        // Perform the action you want after 3 seconds
        let nextViewController = RecommendViewController() // Replace with your next view controller
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // MARK: - Constraints
    func setAddSubViews() {
        view.addSubview(guideText)
    }
    
    func makeConstraints() {
        guideText.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(72)
        }
    }
}
