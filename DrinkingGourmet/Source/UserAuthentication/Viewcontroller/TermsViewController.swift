//
//  TermsViewController.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 1/28/24.
//

import UIKit

//class TermsViewController: UIViewController {
//    
//    lazy var buttonDictionary: [UIButton: String] = [
//        useTermsBtn: "음주미식회 이용약관 동의 (필수)",
//        financialTermsBtn: "전자 금융거래 이용약관 동의 (필수)",
//        privacyTermsBtn: "개인정보 수집이용 동의 (필수)",
//        providePrivacyTermsBtn: "개인정보 제3자 제공 동의 (선택)",
//        marketingTermsBtn: "마케팅, 정보메일, SMS 수신 동의 (선택)"
//    ]
//        
//    private let termsabel = UILabel().then {
//        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24)
//        $0.numberOfLines = 0
//        $0.lineBreakMode = .byWordWrapping
//        var paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1.25
//        $0.attributedText = NSMutableAttributedString(string: "음주미식회\n서비스 이용약관에\n동의해주세요.", attributes: [NSAttributedString.Key.kern: -0.72, NSAttributedString.Key.paragraphStyle: paragraphStyle])
//    }
//
//    private let totalTermsBtn = UIButton().then {
//        $0.buttonConfiguration(title: "전체 약관에 동의합니다.", font: .boldSystemFont(ofSize: 16), foregroundColor: .black, padding: 15, image: UIImage(systemName: "square")?.withRenderingMode(.alwaysOriginal).withTintColor(.black), imageSize: CGSize(width: 23, height: 20))
//        $0.isSelected = false
//        
//    }
//    
//    private let useTermsBtn = UIButton().then {
//        $0.buttonConfiguration(title: "음주미식회 이용약관 동의 (필수)", font: .systemFont(ofSize: 14), foregroundColor: .darkGray, padding: 14, image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.customColor.checkMarkGray), imageSize: CGSize(width: 16, height: 16))
//        $0.isSelected = false
//    }
//    
//    private let financialTermsBtn = UIButton().then {
//        $0.buttonConfiguration(title: "전자 금융거래 이용약관 동의 (필수)", font: .systemFont(ofSize: 14), foregroundColor: .darkGray, padding: 14, image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.customColor.checkMarkGray), imageSize: CGSize(width: 16, height: 16))
//        $0.isSelected = false
//    }
//    
//    private let privacyTermsBtn = UIButton().then {
//        $0.buttonConfiguration(title: "개인정보 수집이용 동의 (필수)", font: .systemFont(ofSize: 14), foregroundColor: .darkGray, padding: 14, image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.customColor.checkMarkGray), imageSize: CGSize(width: 16, height: 16))
//        $0.isSelected = false
//    }
//    
//    private let providePrivacyTermsBtn = UIButton().then {
//        $0.buttonConfiguration(title: "개인정보 제3자 제공 동의 (선택)", font: .systemFont(ofSize: 14), foregroundColor: .darkGray, padding: 14, image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.customColor.checkMarkGray), imageSize: CGSize(width: 16, height: 16))
//        $0.isSelected = false
//    }
//    
//    private let marketingTermsBtn = UIButton().then {
//        $0.buttonConfiguration(title: "마케팅, 정보메일, SMS 수신 동의 (선택)", font: .systemFont(ofSize: 14), foregroundColor: .darkGray, padding: 14, image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.customColor.checkMarkGray), imageSize: CGSize(width: 16, height: 16))
//        $0.isSelected = false
//    }
//
//    private let stackView = UIStackView().then {
//        $0.axis = .vertical
//        $0.alignment = .leading
//        $0.distribution = .equalSpacing
//        $0.spacing = 20
//    }
//    
//    // 확인 버튼
//    private let completeButton = UIButton().then {
//        $0.backgroundColor = .base0500
//        $0.isEnabled = false
//    }
//    
//    private let completeLabel = UILabel().then {
//        $0.text = "확인"
//        $0.textColor = .base1000
//        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        configHierarchy()
//        layout()
//        configView()
//        configNav()
//    }
//}
//
//extension TermsViewController {
//    func configHierarchy() {
//        view.addSubviews([
//            termsabel,
//            totalTermsBtn,
//            stackView,
//            completeButton
//        ])
//        
//        stackView.addArrangedSubviews([
//            useTermsBtn,
//            financialTermsBtn,
//            privacyTermsBtn,
//            providePrivacyTermsBtn,
//            marketingTermsBtn,
//        ])
//        
//        completeButton.addSubview(completeLabel)
//    }
//    
//    func layout() {
//        termsabel.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
//            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
//        }
//        
//        totalTermsBtn.snp.makeConstraints {
//            $0.centerY.equalToSuperview().offset(70)
//            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
//        }
//        
//        // 확인 버튼
//        completeButton.snp.makeConstraints { make in
//            make.leading.trailing.bottom.equalToSuperview()
//            make.height.equalTo(89)
//        }
//        
//        completeLabel.snp.makeConstraints { make in
//            make.top.equalTo(completeButton).offset(18)
//            make.centerX.equalTo(completeButton)
//        }
//        
//        useTermsBtn.snp.makeConstraints {
//            $0.height.equalTo(30)
//        }
//
//        financialTermsBtn.snp.makeConstraints {
//            $0.height.equalTo(useTermsBtn)
//        }
//
//        privacyTermsBtn.snp.makeConstraints {
//            $0.height.equalTo(useTermsBtn)
//        }
//
//        providePrivacyTermsBtn.snp.makeConstraints {
//            $0.height.equalTo(useTermsBtn)
//        }
//
//        marketingTermsBtn.snp.makeConstraints {
//            $0.height.equalTo(useTermsBtn)
//        }
//        
//        stackView.snp.makeConstraints {
//            $0.top.equalTo(totalTermsBtn.snp.bottom).offset(40)
//            $0.bottom.equalTo(completeButton.snp.top).offset(-40)
//            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
//            $0.trailing.equalTo(view.safeAreaLayoutGuide)
//        }
//    }
//    
//    func configView() {
//        totalTermsBtn.addTarget(self, action: #selector(totalTermsBtnClicked), for: .touchUpInside)
//        useTermsBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
//        financialTermsBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
//        privacyTermsBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
//        providePrivacyTermsBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
//        marketingTermsBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
//        
//        completeButton.addTarget(self, action: #selector(pushViewController), for: .touchUpInside)
//    }
//    
//    @objc func btnClicked(sender: UIButton) {
//        if sender.isSelected == true {
//            sender.buttonConfiguration(
//            title: buttonDictionary[sender] ?? "",
//            font: .systemFont(ofSize: 14),
//            foregroundColor: .darkGray,
//            padding: 14,
//            image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.customColor.checkMarkGray),
//            imageSize: CGSize(width: 16, height: 16)
//            )
//            sender.isSelected = false
//        } else {
//            sender.buttonConfiguration(
//            title: buttonDictionary[sender] ?? "",
//            font: .systemFont(ofSize: 14),
//            foregroundColor: .darkGray,
//            padding: 14,
//            image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.black),
//            imageSize: CGSize(width: 16, height: 16)
//            )
//            sender.isSelected = true
//        }
//        updateConfirmButtonState()
//    }
//    
//    
//    @objc func pushViewController() {
//        self.navigationController?.pushViewController(ProfileCreationViewController(), animated: true)
//    }
//    
//    @objc func totalTermsBtnClicked() {
//        totalTermsBtn.isSelected.toggle()
//            
//        let allTermsAgreed = totalTermsBtn.isSelected
//        
//        totalTermsBtn.buttonConfiguration(
//            title: "전체 약관에 동의합니다.",
//            font: .boldSystemFont(ofSize: 16),
//            foregroundColor: .black,
//            padding: 15,
//            image: UIImage(systemName: allTermsAgreed ? "checkmark.square.fill" : "square")?.withRenderingMode(.alwaysOriginal).withTintColor(.black),
//            imageSize: CGSize(width: 23, height: 20)
//        )
//            
//        for (button, _) in buttonDictionary {
//            button.isSelected = allTermsAgreed
//            button.buttonConfiguration(
//                title: buttonDictionary[button] ?? "",
//                font: .systemFont(ofSize: 14),
//                foregroundColor: .darkGray,
//                padding: 14,
//                image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(allTermsAgreed ? .black : .customColor.checkMarkGray),
//                imageSize: CGSize(width: 16, height: 16)
//            )
//        }
//        updateConfirmButtonState()
//    }
//    
//    func updateConfirmButtonState() {
//        // 필수 약관 동의 여부 확인
//        let allButtons = [useTermsBtn, financialTermsBtn, privacyTermsBtn, providePrivacyTermsBtn, marketingTermsBtn]
//        let requiredButtons = [useTermsBtn, financialTermsBtn, privacyTermsBtn]
//        
//        let allRequiredSelected = requiredButtons.allSatisfy { $0.isSelected }
//        let allTermsAgreed = totalTermsBtn.isSelected
//        
//        completeButton.isEnabled = allRequiredSelected || allTermsAgreed
//        
//        if allButtons.contains(where: { !$0.isSelected }) {
//            totalTermsBtn.buttonConfiguration(
//                title: "전체 약관에 동의합니다.",
//                font: .boldSystemFont(ofSize: 16),
//                foregroundColor: .black,
//                padding: 15,
//                image: UIImage(systemName: "square")?.withRenderingMode(.alwaysOriginal).withTintColor(.black),
//                imageSize: CGSize(width: 23, height: 20)
//            )
//            totalTermsBtn.isSelected = false
//        } else {
//            totalTermsBtn.buttonConfiguration(
//                title: "전체 약관에 동의합니다.",
//                font: .boldSystemFont(ofSize: 16),
//                foregroundColor: .black,
//                padding: 15,
//                image: UIImage(systemName: "checkmark.square.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.black),
//                imageSize: CGSize(width: 23, height: 20)
//            )
//            totalTermsBtn.isSelected = true
//        }
//        
//        if requiredButtons.contains(where: { !$0.isSelected }) {
//            completeButton.isEnabled = false
//        } else {
//            completeButton.isEnabled = true
//        }
//    }
//    
//    func configNav() {
//        navigationItem.title = "이용 약관 동의"
//        navigationItem.hidesBackButton = true
//    }
//}

final class TermsViewController: UIViewController {
    // MARK: - UI
    private let termsLabel = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24)
        $0.textColor = .base0100
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "음주미식회\n서비스 이용약관에\n동의해주세요.", attributes: [NSAttributedString.Key.kern: -0.72, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    // 전체
    private let totalTermsCheckButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_terms_total_unchecked"), for: .normal)
    }
    
    private let totalTermsLabelButton = UIButton().then {
        $0.setTitle("전체 약관에 동의합니다.", for: .normal)
        $0.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 19.2
        paragraphStyle.maximumLineHeight = 19.2
        paragraphStyle.alignment = .left
        
        let attributedString = NSAttributedString(
            string: "전체 약관에 동의합니다.",
            attributes: [
                .kern: 0,
                .paragraphStyle: paragraphStyle
            ]
        )
        
        $0.setAttributedTitle(attributedString, for: .normal)
    }
    
    private let totalTermsView = UIView()
    
    // 이용약관
    private let useTermsCheckButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_check"), for: .normal)
    }
    
    private let useTermsLabelButton = UIButton().then {
        $0.setTitle("음주미식회 이용약관 동의 (필수)", for: .normal)
        $0.setTitleColor(UIColor.base0300, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        
        
        let attributedString = NSMutableAttributedString(
            string: "음주미식회 이용약관 동의 (필수)",
            attributes: [
                .kern: 0.0,
                .paragraphStyle: paragraphStyle
            ]
        )
        $0.setAttributedTitle(attributedString, for: .normal)
    }
    
    private let useTermsMoreButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_more"), for: .normal)
    }
    
    private let useTermsView = UIView()
    
    // 전자금융
    private let financialTermsCheckButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_check"), for: .normal)
    }
    
    private let financialLabelbutton = UIButton().then {
        $0.setTitle("전자 금융거래 이용약관 동의 (필수)", for: .normal)
        $0.setTitleColor(UIColor.base0300, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        
        
        let attributedString = NSMutableAttributedString(
            string: "전자 금융거래 이용약관 동의 (필수)",
            attributes: [
                .kern: 0.0,
                .paragraphStyle: paragraphStyle
            ]
        )
        $0.setAttributedTitle(attributedString, for: .normal)
    }
    
    private let financialTermsMoreButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_more"), for: .normal)
    }
    
    private let financialTermssView = UIView()
    
    // 개인정보 수집
    private let privacyTermsCheckButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_check"), for: .normal)
    }
    
    private let privacyLabelbutton = UIButton().then {
        $0.setTitle("개인정보 수집이용 동의 (필수)", for: .normal)
        $0.setTitleColor(UIColor.base0300, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        
        
        let attributedString = NSMutableAttributedString(
            string: "개인정보 수집이용 동의 (필수)",
            attributes: [
                .kern: 0.0,
                .paragraphStyle: paragraphStyle
            ]
        )
        $0.setAttributedTitle(attributedString, for: .normal)
    }
    
    private let privacyTermsMoreButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_more"), for: .normal)
    }
    
    private let privacyTermssView = UIView()
    
    // 개인정보 제3자
    private let providePrivacyTermsCheckButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_check"), for: .normal)
    }
    
    private let providePrivacyLabelbutton = UIButton().then {
        $0.setTitle("개인정보 제3자 제공 동의 (선택)", for: .normal)
        $0.setTitleColor(UIColor.base0300, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        
        
        let attributedString = NSMutableAttributedString(
            string: "개인정보 제3자 제공 동의 (선택)",
            attributes: [
                .kern: 0.0,
                .paragraphStyle: paragraphStyle
            ]
        )
        $0.setAttributedTitle(attributedString, for: .normal)
    }
    
    private let providePrivacyTermsMoreButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_more"), for: .normal)
    }
    
    private let providePrivacyTermssView = UIView()
    
    // 마케팅
    private let marketingTermsCheckButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_check"), for: .normal)
    }
    
    private let marketingLabelbutton = UIButton().then {
        $0.setTitle("마케팅, 정보메일, SMS 수신 동의 (선택)", for: .normal)
        $0.setTitleColor(UIColor.base0300, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        
        
        let attributedString = NSMutableAttributedString(
            string: "마케팅, 정보메일, SMS 수신 동의 (선택)",
            attributes: [
                .kern: 0.0,
                .paragraphStyle: paragraphStyle
            ]
        )
        $0.setAttributedTitle(attributedString, for: .normal)
    }
    
    private let marketingTermsMoreButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_more"), for: .normal)
    }
    
    private let marketingTermssView = UIView()
    
    
    // 확인 버튼
    private let completeButton = UIButton().then {
        $0.backgroundColor = .base0500
        $0.isEnabled = false
    }
    
    private let completeLabel = UILabel().then {
        $0.text = "확인"
        $0.textColor = .base1000
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
    }
    
    // MARK: - Properties
    
    // MARK: - ViewDidLodad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNaviBar()
        
        addViews()
        configureConstraints()
    }
    
    private func setupNaviBar() {
        title = "이용약관 동의"
        navigationItem.hidesBackButton = true
    }
}

// MARK: - UI
extension TermsViewController {
    private func addViews() {
        view.addSubviews([termsLabel, totalTermsView, useTermsView, financialTermssView, privacyTermssView, providePrivacyTermssView, marketingTermssView, completeButton])
        
        // 전체
        totalTermsView.addSubviews([totalTermsCheckButton, totalTermsLabelButton])
        // 이용약관
        useTermsView.addSubviews([useTermsCheckButton, useTermsLabelButton, useTermsMoreButton])
        // 전자금융
        financialTermssView.addSubviews([financialTermsCheckButton, financialLabelbutton, financialTermsMoreButton])
        // 개인정보 수집
        privacyTermssView.addSubviews([privacyTermsCheckButton, privacyLabelbutton, privacyTermsMoreButton])
        // 개인정보 제3자
        providePrivacyTermssView.addSubviews([providePrivacyTermsCheckButton, providePrivacyLabelbutton, providePrivacyTermsMoreButton])
        // 마케팅
        marketingTermssView.addSubviews([marketingTermsCheckButton, marketingLabelbutton, marketingTermsMoreButton])
        
        completeButton.addSubview(completeLabel)
    }
    
    private func configureConstraints() {
        termsLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.leading.equalToSuperview().inset(20)
        }
        
        // 전체
        totalTermsCheckButton.snp.makeConstraints { make in
            make.leading.equalTo(totalTermsView)
            make.centerY.equalTo(totalTermsView)
        }
        
        totalTermsLabelButton.snp.makeConstraints { make in
            make.leading.equalTo(totalTermsCheckButton.snp.trailing).offset(13)
            make.centerY.equalTo(totalTermsView)
        }
        
        totalTermsView.snp.makeConstraints { make in
            make.top.equalTo(termsLabel.snp.bottom).offset(233)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(21)
        }
        
        // 이용약관
        useTermsCheckButton.snp.makeConstraints { make in
            make.leading.equalTo(useTermsView)
            make.centerY.equalTo(useTermsView)
        }
        
        useTermsLabelButton.snp.makeConstraints { make in
            make.leading.equalTo(useTermsCheckButton.snp.trailing).offset(14)
            make.centerY.equalTo(useTermsView)
        }
        
        useTermsMoreButton.snp.makeConstraints { make in
            make.trailing.equalTo(useTermsView)
            make.centerY.equalTo(useTermsView)
        }
        
        useTermsView.snp.makeConstraints { make in
            make.top.equalTo(totalTermsView.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(22)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(17)
        }
        
        // 전자금융
        financialTermsCheckButton.snp.makeConstraints { make in
            make.leading.equalTo(financialTermssView)
            make.centerY.equalTo(financialTermssView)
        }
        
        financialLabelbutton.snp.makeConstraints { make in
            make.leading.equalTo(financialTermsCheckButton.snp.trailing).offset(14)
            make.centerY.equalTo(financialTermssView)
        }
        
        financialTermsMoreButton.snp.makeConstraints { make in
            make.trailing.equalTo(financialTermssView)
            make.centerY.equalTo(financialTermssView)
        }
        
        financialTermssView.snp.makeConstraints { make in
            make.top.equalTo(useTermsView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(useTermsView)
            make.height.equalTo(17)
        }
        
        // 개인정보 수집
        privacyTermsCheckButton.snp.makeConstraints { make in
            make.leading.equalTo(privacyTermssView)
            make.centerY.equalTo(privacyTermssView)
        }
        
        privacyLabelbutton.snp.makeConstraints { make in
            make.leading.equalTo(privacyTermsCheckButton.snp.trailing).offset(14)
            make.centerY.equalTo(privacyTermssView)
        }
        
        privacyTermsMoreButton.snp.makeConstraints { make in
            make.trailing.equalTo(privacyTermssView)
            make.centerY.equalTo(privacyTermssView)
        }
        
        privacyTermssView.snp.makeConstraints { make in
            make.top.equalTo(financialTermssView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(useTermsView)
            make.height.equalTo(17)
        }
        
        // 개인정보 제3자
        providePrivacyTermsCheckButton.snp.makeConstraints { make in
            make.leading.equalTo(providePrivacyTermssView)
            make.centerY.equalTo(providePrivacyTermssView)
        }
        
        providePrivacyLabelbutton.snp.makeConstraints { make in
            make.leading.equalTo(providePrivacyTermsCheckButton.snp.trailing).offset(14)
            make.centerY.equalTo(providePrivacyTermssView)
        }
        
        providePrivacyTermsMoreButton.snp.makeConstraints { make in
            make.trailing.equalTo(providePrivacyTermssView)
            make.centerY.equalTo(providePrivacyTermssView)
        }
        
        providePrivacyTermssView.snp.makeConstraints { make in
            make.top.equalTo(privacyTermssView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(useTermsView)
            make.height.equalTo(17)
        }
        
        // 마케팅
        marketingTermsCheckButton.snp.makeConstraints { make in
            make.leading.equalTo(marketingTermssView)
            make.centerY.equalTo(marketingTermssView)
        }
        
        marketingLabelbutton.snp.makeConstraints { make in
            make.leading.equalTo(marketingTermsCheckButton.snp.trailing).offset(14)
            make.centerY.equalTo(marketingTermssView)
        }
        
        marketingTermsMoreButton.snp.makeConstraints { make in
            make.trailing.equalTo(marketingTermssView)
            make.centerY.equalTo(marketingTermssView)
        }
        
        marketingTermssView.snp.makeConstraints { make in
            make.top.equalTo(providePrivacyTermssView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(useTermsView)
            make.height.equalTo(17)
        }
        
        // 확인 버튼
        completeButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(89)
        }
        
        completeLabel.snp.makeConstraints { make in
            make.top.equalTo(completeButton).offset(18)
            make.centerX.equalTo(completeButton)
        }
    }
}
