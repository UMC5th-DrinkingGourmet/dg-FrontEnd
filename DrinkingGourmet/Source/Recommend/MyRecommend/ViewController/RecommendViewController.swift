//
//  RecommendViewController.swift
//  DrinkingGourmet
//
//  Created by 김희은 on 1/13/24.
//

import UIKit

class RecommendViewController: UIViewController {
    
    lazy var guideText: UILabel = {
        let text = UILabel()
        text.textColor = UIColor.baseColor.base01
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 24)
        text.text = "\(UserDefaultManager.shared.userNickname)님을 위한 주류를\n추천해드립니다."
        return text
    }()
    
    lazy var temporaryButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("시작하기", for: .normal)
        btn.setTitleColor(UIColor.baseColor.base10, for: .normal)
        btn.backgroundColor = UIColor.baseColor.base01
        btn.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var nextButton = makeNextButton(buttonTitle: "시작하기", buttonSelectability: true)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.baseColor.base10
        
        // navigation
        title = "주류추천"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.baseColor.base01]
        navigationController?.navigationBar.tintColor = UIColor.baseColor.base01
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
        let nextViewController = SelectDrunkDegreeViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    // MARK: - Constraints
    func setAddSubViews() {
        view.addSubview(guideText)
        view.addSubview(nextButton)
    }
    
    func makeConstraints() {
        guideText.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(39)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(72)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        }
    }
}
