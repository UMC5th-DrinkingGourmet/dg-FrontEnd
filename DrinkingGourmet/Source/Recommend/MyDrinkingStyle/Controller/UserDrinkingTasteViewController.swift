//
//  UserDrinkingTasteViewController.swift
//  DrinkingGourmet
//
//  Created by 김희은 on 1/10/24.
//

import UIKit

class UserDrinkingTasteViewController: UIViewController {

    lazy var guideText: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 24)
        text.text =
        "주류 추천을 위해\n000님에 대해 알려주세요"
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
    
    lazy var temporaryButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("다음", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .black
        
        btn.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        return btn
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setAddSubViews()
        makeConstraints()
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        let nextViewController = SelectTypeOfLiquorViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    func setAddSubViews() {
        view.addSubview(guideText)
        view.addSubview(subGuideText)
        view.addSubview(temporaryButton)
    }
    func makeConstraints() {
        guideText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(43)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(72)
        }
        subGuideText.snp.makeConstraints { make in
            make.top.equalTo(guideText.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(42)
        }
        temporaryButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.height.equalTo(100)
        }
    }

}
