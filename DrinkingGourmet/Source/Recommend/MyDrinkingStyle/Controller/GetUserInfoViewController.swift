//
//  GetUserInfoViewController.swift
//  DrinkingGourmet
//
//  Created by hee on 2/5/24.
//

import UIKit

class GetUserInfoViewController: UIViewController {
    
    lazy var guideText: UILabel = {
        let text = UILabel()
        text.textColor = UIColor(named: "base01")
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 24)
        text.text =
        "주류 추천을 위해\n00님의 정보를 알려주세요."
        return text
    }()
    
    lazy var subGuideText: UILabel = {
        let text = UILabel()
        text.textColor = .lightGray
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 14)
        text.text = "지금 입력하신 기본 정보는 주류 추천에 활용되며\n수정이 가능합니다."
        
        return text
        
    }()
    
    lazy var nextButton = makeNextButton(buttonTitle: "다음")
    
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
            make.bottom.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.height.equalTo(100)
            nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        }
    }
}
