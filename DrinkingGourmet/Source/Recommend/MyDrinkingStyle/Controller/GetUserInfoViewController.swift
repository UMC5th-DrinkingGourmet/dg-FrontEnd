//
//  GetUserInfoViewController.swift
//  DrinkingGourmet
//
//  Created by hee on 2/5/24.
//

import UIKit

class GetUserInfoViewController: UIViewController {
    
    private lazy var guideText: UILabel = {
        let text = UILabel()
        text.textColor = UIColor.baseColor.base01
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 24)
        text.text = "주류 추천을 위해\n\(UserDefaultManager.shared.userNickname)님의 정보를 알려주세요."
        return text
    }()
    
    private lazy var subGuideText: UILabel = {
        let text = UILabel()
         text.textColor = UIColor.baseColor.base05
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 14)
        text.text = "지금 입력하신 기본 정보는 주류 추천에 활용되며\n수정이 가능합니다."
        return text
    }()
    
    private lazy var nextButton = makeNextButton(buttonTitle: "다음", buttonSelectability: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.baseColor.base10
        
        // navigation
        title = "주류추천"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = UIColor.baseColor.base01
        navigationController?.navigationBar.isTranslucent = true
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backButton
        
        setAddSubViews()
        makeConstraints()
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        let nextViewController = SelectTypeOfLiquorViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func setAddSubViews() {
        view.addSubview(guideText)
        view.addSubview(subGuideText)
        view.addSubview(nextButton)
    }
    
    func makeConstraints() {
        guideText.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(43)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(72)
        }
        
        subGuideText.snp.makeConstraints { make in
            make.top.equalTo(guideText.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(100)
            nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        }
    }
}
