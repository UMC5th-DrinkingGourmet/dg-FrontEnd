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
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 24)
        text.text =
        "오늘은 어떤 주류와\n어울리는 음식으로\n기분전환을 해보시겠어요?"
        return text
    }()
    
    private lazy var recommendButton: CustomRecommendButtons = {
        let button = CustomRecommendButtons(buttonTitle: "주류추천")
        return button
    }()
    private lazy var myRecommendButton: CustomRecommendButtons = {
        let button = CustomRecommendButtons(buttonTitle: "내가 받은 추천")
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // navigation
        title = "주류추천"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.isTranslucent = true
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backButton
        
        setAddSubViews()
        makeConstraints()
    }
    
    // MARK: - Navigation
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    @objc func nextButtonTapped(_ sender: UIButton) {
        let nextViewController = RecommendViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    // - mypage 완성 시 수정 - //
    @objc func myRecommendButtonTapped(_ sender: UIButton) {
        let nextViewController = RecommendViewController() // myPage로 연결
        navigationController?.pushViewController(nextViewController, animated: true)
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
            //myRecommendButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        }
    }
}