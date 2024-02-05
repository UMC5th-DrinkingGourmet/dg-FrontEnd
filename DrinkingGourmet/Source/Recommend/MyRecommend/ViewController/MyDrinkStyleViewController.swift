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
    
    lazy var recommendButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("주류추천", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        
        btn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return btn
    }()
    lazy var myRecommendButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("내가 받은 추천", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        
        btn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return btn
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default // 또는 .lightContent 등
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        // 네비게이션 바 타이틀 설정
        title = "주류추천"
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = UIColor.blue
        //navigationController?.navigationBar.barStyle = .default
        
        // 네비게이션 바의 투명도 설정 (원하는 값으로 변경)
        navigationController?.navigationBar.isTranslucent = false
    
        
        setAddSubViews()
        makeConstraints()
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        // 버튼이 탭되었을 때 실행되는 코드
        let nextViewController = UserDrinkingTasteViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    func setAddSubViews() {
        //view.addSubview(progressBar)
        view.addSubview(guideText)
        view.addSubview(recommendButton)
        view.addSubview(myRecommendButton)
        //view.addSubview(myFoodTextField)
    }
    
    func makeConstraints() {
        guideText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(43)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(108)
        }
        recommendButton.snp.makeConstraints { make in
            make.top.equalTo(guideText.snp.bottom).offset(317)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        myRecommendButton.snp.makeConstraints { make in
            make.top.equalTo(recommendButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
}
