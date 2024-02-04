//
//  TermsViewController.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 1/28/24.
//

import UIKit
import SnapKit
import Then

class TermsViewController: UIViewController {
    
    lazy var buttonDictionary: [UIButton: String] = [
        useTermsBtn: "음주미식회 이용약관 동의 (필수)",
        financialTermsBtn: "전자 금융거래 이용약관 동의 (필수)",
        privacyTermsBtn: "개인정보 수집이용 동의 (필수)",
        providePrivacyTermsBtn: "개인정보 제3자 제공 동의 (선택)",
        marketingTermsBtn: "마케팅, 정보메일, SMS 수신 동의 (선택)"
    ]
        
    private let termsabel = UILabel().then {
        $0.text = "음주미식회\n서비스 이용약관에\n동의해주세요."
        $0.numberOfLines = 3
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 24, weight: .bold)
    }

    private let totalTermsBtn = UIButton().then {
        $0.buttonConfiguration(title: "전체 약관에 동의합니다.", font: .boldSystemFont(ofSize: 16), foregroundColor: .black, padding: 15, image: UIImage(systemName: "square")?.withRenderingMode(.alwaysOriginal).withTintColor(.black), imageSize: CGSize(width: 23, height: 20))
        $0.isSelected = false
        
    }
    
    private let useTermsBtn = UIButton().then {
        $0.buttonConfiguration(title: "음주미식회 이용약관 동의 (필수)", font: .systemFont(ofSize: 14), foregroundColor: .darkGray, padding: 14, image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.customColor.checkMarkGray), imageSize: CGSize(width: 16, height: 16))
        $0.isSelected = false
    }
    
    private let financialTermsBtn = UIButton().then {
        $0.buttonConfiguration(title: "전자 금융거래 이용약관 동의 (필수)", font: .systemFont(ofSize: 14), foregroundColor: .darkGray, padding: 14, image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.customColor.checkMarkGray), imageSize: CGSize(width: 16, height: 16))
        $0.isSelected = false
    }
    
    private let privacyTermsBtn = UIButton().then {
        $0.buttonConfiguration(title: "개인정보 수집이용 동의 (필수)", font: .systemFont(ofSize: 14), foregroundColor: .darkGray, padding: 14, image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.customColor.checkMarkGray), imageSize: CGSize(width: 16, height: 16))
        $0.isSelected = false
    }
    
    private let providePrivacyTermsBtn = UIButton().then {
        $0.buttonConfiguration(title: "개인정보 제3자 제공 동의 (선택)", font: .systemFont(ofSize: 14), foregroundColor: .darkGray, padding: 14, image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.customColor.checkMarkGray), imageSize: CGSize(width: 16, height: 16))
        $0.isSelected = false
    }
    
    private let marketingTermsBtn = UIButton().then {
        $0.buttonConfiguration(title: "마케팅, 정보메일, SMS 수신 동의 (선택)", font: .systemFont(ofSize: 14), foregroundColor: .darkGray, padding: 14, image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.customColor.checkMarkGray), imageSize: CGSize(width: 16, height: 16))
        $0.isSelected = false
    }

    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .equalSpacing
        $0.spacing = 8
    }
    
    private let confirmBtn = UIButton().then {
        $0.backgroundColor = .black
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configHierarchy()
        layout()
        configView()
    }
}

extension TermsViewController {
    func configHierarchy() {
        view.addSubviews([
            termsabel,
            totalTermsBtn,
            stackView,
            confirmBtn
        ])
        
        stackView.addArrangedSubviews([
            useTermsBtn,
            financialTermsBtn,
            privacyTermsBtn,
            providePrivacyTermsBtn,
            marketingTermsBtn,
        ])
    }
    
    func layout() {
        termsabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        totalTermsBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(70)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        confirmBtn.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(90)
        }
        
        useTermsBtn.snp.makeConstraints {
            $0.height.equalTo(30)
        }

        financialTermsBtn.snp.makeConstraints {
            $0.height.equalTo(useTermsBtn)
        }

        privacyTermsBtn.snp.makeConstraints {
            $0.height.equalTo(useTermsBtn)
        }

        providePrivacyTermsBtn.snp.makeConstraints {
            $0.height.equalTo(useTermsBtn)
        }

        marketingTermsBtn.snp.makeConstraints {
            $0.height.equalTo(useTermsBtn)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(totalTermsBtn.snp.bottom).offset(40)
            $0.bottom.equalTo(confirmBtn.snp.top).offset(-40)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configView() {
        totalTermsBtn.addTarget(self, action: #selector(totalTermsBtnClicked), for: .touchUpInside)
        useTermsBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        financialTermsBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        privacyTermsBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        providePrivacyTermsBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        marketingTermsBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        
        confirmBtn.addTarget(self, action: #selector(pushViewController), for: .touchUpInside)
    }
    
    @objc func btnClicked(sender: UIButton) {
        if sender.isSelected == true {
            print("이미 선택되어있던 걸 클릭")
                
            sender.buttonConfiguration(
            title: buttonDictionary[sender] ?? "",
            font: .systemFont(ofSize: 14),
            foregroundColor: .darkGray,
            padding: 14,
            image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.customColor.checkMarkGray),
            imageSize: CGSize(width: 16, height: 16)
            )
            sender.isSelected = false
        } else {
            print("그 외를 클릭")
            print(buttonDictionary[sender] ?? "")
            sender.buttonConfiguration(
            title: buttonDictionary[sender] ?? "",
            font: .systemFont(ofSize: 14),
            foregroundColor: .darkGray,
            padding: 14,
            image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.black),
            imageSize: CGSize(width: 16, height: 16)
            )
            sender.isSelected = true
        }
        updateConfirmButtonState()
    }
    
    
    @objc func pushViewController() {
        self.navigationController?.pushViewController(ProfileCreationViewController(), animated: true)
    }
    
    @objc func totalTermsBtnClicked() {
        totalTermsBtn.isSelected.toggle()
            
        let allTermsAgreed = totalTermsBtn.isSelected
        
        totalTermsBtn.buttonConfiguration(
            title: "전체 약관에 동의합니다.",
            font: .boldSystemFont(ofSize: 16),
            foregroundColor: .black,
            padding: 15,
            image: UIImage(systemName: allTermsAgreed ? "checkmark.square.fill" : "square")?.withRenderingMode(.alwaysOriginal).withTintColor(.black),
            imageSize: CGSize(width: 23, height: 20)
        )
            
        for (button, _) in buttonDictionary {
            button.isSelected = allTermsAgreed
            button.buttonConfiguration(
                title: buttonDictionary[button] ?? "",
                font: .systemFont(ofSize: 14),
                foregroundColor: .darkGray,
                padding: 14,
                image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(allTermsAgreed ? .black : .customColor.checkMarkGray),
                imageSize: CGSize(width: 16, height: 16)
            )
        }
        updateConfirmButtonState()
    }
    
    func updateConfirmButtonState() {
        // 필수 약관 동의 여부 확인
        let allButtons = [useTermsBtn, financialTermsBtn, privacyTermsBtn, providePrivacyTermsBtn, marketingTermsBtn]
        let requiredButtons = [useTermsBtn, financialTermsBtn, privacyTermsBtn]
        
        let allRequiredSelected = requiredButtons.allSatisfy { $0.isSelected }
        let allTermsAgreed = totalTermsBtn.isSelected
        
        confirmBtn.isEnabled = allRequiredSelected || allTermsAgreed
        
        if allButtons.contains(where: { !$0.isSelected }) {
            totalTermsBtn.buttonConfiguration(
                title: "전체 약관에 동의합니다.",
                font: .boldSystemFont(ofSize: 16),
                foregroundColor: .black,
                padding: 15,
                image: UIImage(systemName: "square")?.withRenderingMode(.alwaysOriginal).withTintColor(.black),
                imageSize: CGSize(width: 23, height: 20)
            )
            totalTermsBtn.isSelected = false
            print("totaltermsbtn이 false")
        } else {
            totalTermsBtn.buttonConfiguration(
                title: "전체 약관에 동의합니다.",
                font: .boldSystemFont(ofSize: 16),
                foregroundColor: .black,
                padding: 15,
                image: UIImage(systemName: "checkmark.square.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.black),
                imageSize: CGSize(width: 23, height: 20)
            )
            totalTermsBtn.isSelected = true
            print("totaltermsbtn이 true")
        }
        
        if requiredButtons.contains(where: { !$0.isSelected }) {
            confirmBtn.isEnabled = false
        } else {
            confirmBtn.isEnabled = true
        }
    }
    
}
