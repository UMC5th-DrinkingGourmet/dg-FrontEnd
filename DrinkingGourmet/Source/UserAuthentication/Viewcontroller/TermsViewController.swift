//
//  TermsViewController.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 1/28/24.
//

import UIKit

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
        $0.isSelected = false
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
        $0.isSelected = false
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
        $0.isSelected = false
        $0.setImage(UIImage(named: "ic_check"), for: .normal)
    }
    
    private let financialLabelButton = UIButton().then {
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
    
    private let financialTermsView = UIView()
    
    // 개인정보 수집
    private let privacyTermsCheckButton = UIButton().then {
        $0.isSelected = false
        $0.setImage(UIImage(named: "ic_check"), for: .normal)
    }
    
    private let privacyLabelButton = UIButton().then {
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
    
    private let privacyTermsView = UIView()
    
    // 개인정보 제3자
    private let providePrivacyTermsCheckButton = UIButton().then {
        $0.isSelected = false
        $0.setImage(UIImage(named: "ic_check"), for: .normal)
    }
    
    private let providePrivacyLabelButton = UIButton().then {
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
    
    private let providePrivacyTermsView = UIView()
    
    // 마케팅
    private let marketingTermsCheckButton = UIButton().then {
        $0.isSelected = false
        $0.setImage(UIImage(named: "ic_check"), for: .normal)
    }
    
    private let marketingLabelButton = UIButton().then {
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
    
    private let marketingTermsView = UIView()
    
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
        
        addViews()
        configureConstraints()
        
        setupNaviBar()
        setupButton()
    }
    
    private func setupNaviBar() {
        title = "이용약관 동의"
        navigationItem.hidesBackButton = true
        
        // 백버튼 커스텀
        let customBackImage = UIImage(named: "ic_back")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = customBackImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = customBackImage
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupButton() {
        useTermsCheckButton.tag = 0
        useTermsLabelButton.tag = 0

        financialTermsCheckButton.tag = 1
        financialLabelButton.tag = 1
        
        privacyTermsCheckButton.tag = 2
        privacyLabelButton.tag = 2
        
        providePrivacyTermsCheckButton.tag = 3
        providePrivacyLabelButton.tag = 3
        
        marketingTermsCheckButton.tag = 4
        marketingLabelButton.tag = 4
        
        
        [totalTermsCheckButton].forEach {
            $0.addTarget(self, action: #selector(totalTermsButtonTapped), for: .touchUpInside)
        }
        
        [useTermsCheckButton, useTermsLabelButton,
         financialTermsCheckButton, financialLabelButton,
         privacyTermsCheckButton, privacyLabelButton,
         providePrivacyTermsCheckButton, providePrivacyLabelButton,
         marketingTermsCheckButton, marketingLabelButton].forEach {
            $0.addTarget(self, action: #selector(termsButtonTapped), for: .touchUpInside)
        }
        
        useTermsMoreButton.addTarget(self, action: #selector(useTermsMoreButtonTapped), for: .touchUpInside)
        financialTermsMoreButton.addTarget(self, action: #selector(financialTermsMoreButtonTapped), for: .touchUpInside)
        privacyTermsMoreButton.addTarget(self, action: #selector(privacyTermsMoreButtonTapped), for: .touchUpInside)
        providePrivacyTermsCheckButton.addTarget(self, action: #selector(providePrivacyTermsCheckButtonTapped), for: .touchUpInside)
        marketingTermsMoreButton.addTarget(self, action: #selector(marketingTermsMoreButtonTapped), for: .touchUpInside)
        
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
    private func showTermsDetail(answer: String) {
        let VC = AnswerViewController()
        VC.answer = answer
        VC.isTermsAndPolicies = true
        navigationController?.pushViewController(VC, animated: true)
    }
    
    private func updateConfirmButtonState() {
        // 필수 약관 동의 여부 확인
        let allButtons = [useTermsCheckButton, financialTermsCheckButton, privacyTermsCheckButton, providePrivacyTermsCheckButton, marketingTermsCheckButton]
        
        let requiredButtons = [useTermsCheckButton, financialTermsCheckButton, privacyTermsCheckButton]
        
        // 필수 약관 모두 동의한 경우
        let allRequiredSelected = requiredButtons.allSatisfy { $0.isSelected }
        
        // 전체 약관 동의 여부
        let allTermsAgreed = totalTermsCheckButton.isSelected
        
        // 확인 버튼 활성화 조건 설정
        completeButton.isEnabled = allRequiredSelected || allTermsAgreed
        
        // 전체 약관 체크 버튼 상태 업데이트
        if allButtons.contains(where: { !$0.isSelected }) {
            totalTermsCheckButton.setImage(UIImage(named: "ic_terms_total_unchecked"), for: .normal)
            totalTermsCheckButton.isSelected = false
        } else {
            totalTermsCheckButton.setImage(UIImage(named: "ic_terms_total_checked"), for: .normal)
            totalTermsCheckButton.isSelected = true
        }
        
        // 필수 약관 동의 상태에 따른 확인 버튼 스타일 업데이트
        if requiredButtons.contains(where: { !$0.isSelected }) {
            completeButton.backgroundColor = .base0500
        } else {
            completeButton.backgroundColor = .base0100
        }
    }

}

// MARK: - Actions
extension TermsViewController {
    // 전체
    @objc private func totalTermsButtonTapped() {
        // 전체 약관 동의 버튼의 현재 상태를 반대로 변경
        totalTermsCheckButton.isSelected.toggle()

        // 전체 동의 버튼의 상태에 따라 다른 모든 약관 버튼의 상태를 설정
        let newState = totalTermsCheckButton.isSelected
        let allButtons = [useTermsCheckButton, financialTermsCheckButton, privacyTermsCheckButton, providePrivacyTermsCheckButton, marketingTermsCheckButton]

        allButtons.forEach { button in
            button.isSelected = newState
            button.setImage(UIImage(named: newState ? "ic_check_selected" : "ic_check"), for: .normal)
        }

        // 모든 버튼 상태가 변경된 후 확인 버튼의 상태를 업데이트
        updateConfirmButtonState()
    }

    
    // 각각
    @objc private func termsButtonTapped(sender: UIButton) {
        // 클릭된 버튼(체크박스 또는 라벨)의 태그를 가져옵니다.
        let tag = sender.tag

        // 동일한 태그를 가진 체크박스를 찾습니다.
        let allButtons = [useTermsCheckButton, financialTermsCheckButton, privacyTermsCheckButton, providePrivacyTermsCheckButton, marketingTermsCheckButton]
        let checkBox = allButtons.first { $0.tag == tag }

        // 체크박스의 상태를 반대로 변경하고, 이미지를 업데이트합니다.
        if let checkBox = checkBox {
            checkBox.isSelected.toggle()
            checkBox.setImage(UIImage(named: checkBox.isSelected ? "ic_check_selected" : "ic_check"), for: .normal)
        }

        // 확인 버튼의 상태를 업데이트합니다.
        updateConfirmButtonState()
    }

    
    // 확인
    @objc private func completeButtonTapped() {
        var selectedTerms: [String] = []

        if useTermsCheckButton.isSelected {
            selectedTerms.append("TERMS_OF_SERVICE")
        }
        if financialTermsCheckButton.isSelected {
            selectedTerms.append("ELECTRONIC_FINANCIAL_TRANSACTION")
        }
        if privacyTermsCheckButton.isSelected {
            selectedTerms.append("PERSONAL_INFORMATION_COLLECT")
        }
        if providePrivacyTermsCheckButton.isSelected {
            selectedTerms.append("PERSONAL_INFORMATION_THIRD_PARTY")
        }
        if marketingTermsCheckButton.isSelected {
            selectedTerms.append("MARKETING")
        }

        AdministrationService.shared.postAgree(termList: selectedTerms) { error in
            if let error = error {
                print("약관 동의 실패 - \(error.localizedDescription)")
            } else {
                print("약관 동의 성공")
            }
        }
    }

    
    @objc private func useTermsMoreButtonTapped() {
        let VC = AnswerViewController()
        VC.answer = """
        서비스 소개
         · 본 이용 약관은 "음주 미식회" 서비스(이하 '서비스')의 이용 조건 및 절차, 사용자와 운영자의 권리, 의무, 책임 사항 등 기본적인 사항을 규정합니다.
        
        이용 조건
         · 서비스를 사용함으로써, 사용자는 본 약관에 동의하는 것으로 간주합니다.
         · 사용자는 서비스 이용 시 법적인 제한사항을 준수해야 합니다.
        
        계정 관리
         · 사용자는 자신의 계정 정보를 안전하게 관리해야 합니다.
         · 계정의 부정 사용에 대한 책임은 사용자에게 있습니다.
        
        지적 재산권
         · 서비스에 포함된 모든 콘텐츠의 저작권은 "음주 미식회"에 있습니다.
        
        면책 조항
         · 서비스 운영자는 서비스 이용으로 발생하는 직접적, 간접적 손해에 대해 책임지지 않습니다.
        
        약관의 변경
         · 서비스 운영자는 필요시 이용 약관을 변경할 수 있으며, 변경된 약관은 서비스 내에 공지됩니다.
        """
        VC.isTermsAndPolicies = true
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc private func financialTermsMoreButtonTapped() {
        
    }
    
    @objc private func privacyTermsMoreButtonTapped() {
        
    }
    
    @objc private func providePrivacyTermsCheckButtonTapped() {
        
    }
    
    @objc private func marketingTermsMoreButtonTapped() {
        
    }
    
}

// MARK: - UI
extension TermsViewController {
    private func addViews() {
        view.addSubviews([termsLabel, totalTermsView, useTermsView, financialTermsView, privacyTermsView, providePrivacyTermsView, marketingTermsView, completeButton])
        
        // 전체
        totalTermsView.addSubviews([totalTermsCheckButton, totalTermsLabelButton])
        // 이용약관
        useTermsView.addSubviews([useTermsCheckButton, useTermsLabelButton, useTermsMoreButton])
        // 전자금융
        financialTermsView.addSubviews([financialTermsCheckButton, financialLabelButton, financialTermsMoreButton])
        // 개인정보 수집
        privacyTermsView.addSubviews([privacyTermsCheckButton, privacyLabelButton, privacyTermsMoreButton])
        // 개인정보 제3자
        providePrivacyTermsView.addSubviews([providePrivacyTermsCheckButton, providePrivacyLabelButton, providePrivacyTermsMoreButton])
        // 마케팅
        marketingTermsView.addSubviews([marketingTermsCheckButton, marketingLabelButton, marketingTermsMoreButton])
        
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
            make.leading.trailing.equalToSuperview().inset(20)
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
            make.leading.equalTo(financialTermsView)
            make.centerY.equalTo(financialTermsView)
        }
        
        financialLabelButton.snp.makeConstraints { make in
            make.leading.equalTo(financialTermsCheckButton.snp.trailing).offset(14)
            make.centerY.equalTo(financialTermsView)
        }
        
        financialTermsMoreButton.snp.makeConstraints { make in
            make.trailing.equalTo(financialTermsView)
            make.centerY.equalTo(financialTermsView)
        }
        
        financialTermsView.snp.makeConstraints { make in
            make.top.equalTo(useTermsView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(useTermsView)
            make.height.equalTo(17)
        }
        
        // 개인정보 수집
        privacyTermsCheckButton.snp.makeConstraints { make in
            make.leading.equalTo(privacyTermsView)
            make.centerY.equalTo(privacyTermsView)
        }
        
        privacyLabelButton.snp.makeConstraints { make in
            make.leading.equalTo(privacyTermsCheckButton.snp.trailing).offset(14)
            make.centerY.equalTo(privacyTermsView)
        }
        
        privacyTermsMoreButton.snp.makeConstraints { make in
            make.trailing.equalTo(privacyTermsView)
            make.centerY.equalTo(privacyTermsView)
        }
        
        privacyTermsView.snp.makeConstraints { make in
            make.top.equalTo(financialTermsView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(useTermsView)
            make.height.equalTo(17)
        }
        
        // 개인정보 제3자
        providePrivacyTermsCheckButton.snp.makeConstraints { make in
            make.leading.equalTo(providePrivacyTermsView)
            make.centerY.equalTo(providePrivacyTermsView)
        }
        
        providePrivacyLabelButton.snp.makeConstraints { make in
            make.leading.equalTo(providePrivacyTermsCheckButton.snp.trailing).offset(14)
            make.centerY.equalTo(providePrivacyTermsView)
        }
        
        providePrivacyTermsMoreButton.snp.makeConstraints { make in
            make.trailing.equalTo(providePrivacyTermsView)
            make.centerY.equalTo(providePrivacyTermsView)
        }
        
        providePrivacyTermsView.snp.makeConstraints { make in
            make.top.equalTo(privacyTermsView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(useTermsView)
            make.height.equalTo(17)
        }
        
        // 마케팅
        marketingTermsCheckButton.snp.makeConstraints { make in
            make.leading.equalTo(marketingTermsView)
            make.centerY.equalTo(marketingTermsView)
        }
        
        marketingLabelButton.snp.makeConstraints { make in
            make.leading.equalTo(marketingTermsCheckButton.snp.trailing).offset(14)
            make.centerY.equalTo(marketingTermsView)
        }
        
        marketingTermsMoreButton.snp.makeConstraints { make in
            make.trailing.equalTo(marketingTermsView)
            make.centerY.equalTo(marketingTermsView)
        }
        
        marketingTermsView.snp.makeConstraints { make in
            make.top.equalTo(providePrivacyTermsView.snp.bottom).offset(20)
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
