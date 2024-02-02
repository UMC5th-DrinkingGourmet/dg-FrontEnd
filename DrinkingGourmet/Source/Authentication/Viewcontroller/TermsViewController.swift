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
        config()
        totalTermsBtn.addTarget(self, action: #selector(totalTermsBtnClicked), for: .touchUpInside)
    }
}

extension TermsViewController {
    func config() {
        layout()
    }
    
    func layout() {
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
    
    @objc func totalTermsBtnClicked() {
        if totalTermsBtn.isSelected == false {
            totalTermsBtn.isSelected = true
            totalTermsBtn.buttonConfiguration(title: "전체 약관에 동의합니다.", font: .boldSystemFont(ofSize: 16), foregroundColor: .black, padding: 15, image: UIImage(systemName: "checkmark.square.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.black), imageSize: CGSize(width: 23, height: 20))
            
            useTermsBtn.isSelected = true
            useTermsBtn.buttonConfiguration(
                title: "음주미식회 이용약관 동의 (필수)",
                font: .systemFont(ofSize: 14),
                foregroundColor: .darkGray,
                padding: 14,
                image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.black),
                imageSize: CGSize(width: 16, height: 16)
            )
            financialTermsBtn.isSelected = true
            financialTermsBtn.buttonConfiguration(
                title: "전자 금융거래 이용약관 동의 (필수)",
                font: .systemFont(ofSize: 14),
                foregroundColor: .darkGray,
                padding: 14,
                image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.black),
                imageSize: CGSize(width: 16, height: 16)
            )
            privacyTermsBtn.isSelected = true
            privacyTermsBtn.buttonConfiguration(
                title: "개인정보 수집이용 동의 (필수)",
                font: .systemFont(ofSize: 14),
                foregroundColor: .darkGray,
                padding: 14,
                image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.black),
                imageSize: CGSize(width: 16, height: 16)
            )
            providePrivacyTermsBtn.isSelected = true
            providePrivacyTermsBtn.buttonConfiguration(
                title: "개인정보 제3자 제공 동의 (선택)",
                font: .systemFont(ofSize: 14),
                foregroundColor: .darkGray,
                padding: 14,
                image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.black),
                imageSize: CGSize(width: 16, height: 16)
            )
            marketingTermsBtn.isSelected = true
            marketingTermsBtn.buttonConfiguration(
                title: "마케팅, 정보메일, SMS 수신 동의 (선택)",
                font: .systemFont(ofSize: 14),
                foregroundColor: .darkGray,
                padding: 14,
                image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.black),
                imageSize: CGSize(width: 16, height: 16)
            )
        } else {
            totalTermsBtn.isSelected = false
            totalTermsBtn.buttonConfiguration(title: "전체 약관에 동의합니다.", font: .boldSystemFont(ofSize: 16), foregroundColor: .black, padding: 15, image: UIImage(systemName: "square")?.withRenderingMode(.alwaysOriginal).withTintColor(.black), imageSize: CGSize(width: 23, height: 20))
        }
    }
}
