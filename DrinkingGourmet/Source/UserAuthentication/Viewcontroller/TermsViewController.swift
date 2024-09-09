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
    
    // 서비스 이용약관
    private let useTermsCheckButton = UIButton().then {
        $0.isSelected = false
        $0.setImage(UIImage(named: "ic_check"), for: .normal)
    }
    
    private let useTermsLabelButton = UIButton().then {
        $0.setTitle("서비스 이용약관 동의 (필수)", for: .normal)
        $0.setTitleColor(UIColor.base0300, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        
        
        let attributedString = NSMutableAttributedString(
            string: "서비스 이용약관 동의 (필수)",
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
    
    // 개인정보 처리방침
    private let privacyTermsCheckButton = UIButton().then {
        $0.isSelected = false
        $0.setImage(UIImage(named: "ic_check"), for: .normal)
    }
    
    private let privacyLabelButton = UIButton().then {
        $0.setTitle("개인정보 처리방침 동의 (필수)", for: .normal)
        $0.setTitleColor(UIColor.base0300, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        
        
        let attributedString = NSMutableAttributedString(
            string: "개인정보 처리방침 동의 (필수)",
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
        
        privacyTermsCheckButton.tag = 1
        privacyLabelButton.tag = 1
        
        marketingTermsCheckButton.tag = 2
        marketingLabelButton.tag = 2
        
        
        [totalTermsCheckButton].forEach {
            $0.addTarget(self, action: #selector(totalTermsButtonTapped), for: .touchUpInside)
        }
        
        [useTermsCheckButton, useTermsLabelButton,
         privacyTermsCheckButton, privacyLabelButton,
         marketingTermsCheckButton, marketingLabelButton].forEach {
            $0.addTarget(self, action: #selector(termsButtonTapped), for: .touchUpInside)
        }
        
        useTermsMoreButton.addTarget(self, action: #selector(useTermsMoreButtonTapped), for: .touchUpInside)
        privacyTermsMoreButton.addTarget(self, action: #selector(privacyTermsMoreButtonTapped), for: .touchUpInside)
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
        let allButtons = [useTermsCheckButton, privacyTermsCheckButton, marketingTermsCheckButton]
        
        let requiredButtons = [useTermsCheckButton, privacyTermsCheckButton]
        
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
        let allButtons = [useTermsCheckButton, privacyTermsCheckButton, marketingTermsCheckButton]

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
        let allButtons = [useTermsCheckButton, privacyTermsCheckButton, marketingTermsCheckButton]
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
        if privacyTermsCheckButton.isSelected {
            selectedTerms.append("PERSONAL_INFORMATION_COLLECT")
        }
        if marketingTermsCheckButton.isSelected {
            selectedTerms.append("MARKETING")
        }
        
        let VC = ProfileCreationViewController()
        navigationController?.pushViewController(VC, animated: true)
        

//        AdministrationService.shared.postAgree(termList: selectedTerms) { error in
//            if let error = error {
//                print("약관 동의 실패 - \(error.localizedDescription)")
//            } else {
//                print("약관 동의 성공")
//            }
//        }
    }
    
    @objc private func useTermsMoreButtonTapped() {
        let VC = AnswerViewController()
        VC.answer = """
        사용자 콘텐츠 정책
         · 사용자가 서비스 내에서 공유하는 모든 콘텐츠(리뷰, 평가, 사진 등)는 타인을 존중하는 방식으로 게시되어야 합니다. 욕설, 혐오 발언, 저작권 침해 콘텐츠 등은 엄격히 금지되며, 위반 시 콘텐츠 삭제 및 계정 정지 조치가 취해질 수 있습니다.
        
        연령 제한 정책
         · 본 서비스는 알코올 관련 콘텐츠를 포함하고 있으므로, 주의가 필요합니다. 앱스토어에서 본인의 계정을 사용하지 않을 경우 앱 이용에 제한이 있을 수 있습니다. 지나친 음주는 뇌졸중, 기억력 손상이나 치매를 유발합니다. 임신 중 음주는 기형아 출생 위험을 높입니다.
        
        저작권 및 상표 정책
         · 서비스 내에 표시된 모든 상표, 로고, 서비스 마크는 해당 소유자의 재산이며, 무단 사용은 금지됩니다. 또한, 서비스에서 제공되는 콘텐츠(텍스트, 이미지, 디자인 등)는 저작권법에 의해 보호되며, 사용자는 서비스 제공자의 명시적 동의 없이 이를 상업적으로 사용할 수 없습니다.
        
        서비스 변경 및 중단 정책
         · 서비스 제공자는 서비스의 내용을 개선하거나 사용자의 경험을 향상시키기 위해 서비스의 일부 또는 전체를 변경, 중단, 중지할 권리를 보유합니다. 이러한 변경이 발생할 경우, 가능한 한 빨리 사용자에게 통지하며, 중대한 변경의 경우 사용자의 동의를 다시 얻을 수도 있습니다.
        """
        VC.isTermsAndPolicies = true
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc private func privacyTermsMoreButtonTapped() {
        let VC = AnswerViewController()
        VC.answer = """
        사용자 데이터 및 개인정보 보호 정책
         · 본 서비스는 사용자의 개인정보 및 사용 데이터를 최대한 보호하며, 이는 서비스 제공 목적으로만 사용됩니다. 사용자의 개인정보는 해당 사용자의 명시적 동의 없이 제3자에게 공유되거나 판매되지 않습니다. 모든 데이터 처리는 관련 데이터 보호 법규를 준수합니다.
        
         · 개인정보 입력받는 항목: 이름, 이메일 주소, 전화번호, 위치 정보 등.
        """
        VC.isTermsAndPolicies = true
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc private func marketingTermsMoreButtonTapped() {
        let VC = AnswerViewController()
        VC.answer = """
        마케팅 동의 정책
         · 마케팅 목적의 데이터 사용: 사용자는 마케팅 목적으로 개인정보 및 사용 데이터를 활용하는 것에 동의할 수 있습니다. 이 데이터는 맞춤형 광고 제공, 프로모션 및 이벤트 알림에 사용됩니다.
        
         · 데이터 공유: 마케팅 목적으로 제3자와 데이터를 공유할 경우, 사용자의 명시적 동의를 받습니다. 공유된 데이터는 제3자의 개인정보 보호 정책에 따라 보호됩니다.
        
        광고 및 프로모션 이메일/SMS 수신 동의
         · 사용자는 본 서비스에서 발송하는 광고 및 프로모션 이메일 또는 SMS 수신에 동의할 수 있습니다. 이 동의는 언제든지 철회할 수 있으며, 철회 시 관련 알림을 더 이상 받지 않게 됩니다.
        
        서비스 관련 업데이트 및 통지 동의
         · 서비스 업데이트, 새로운 기능, 이용자 혜택 등에 관한 정보를 이메일 또는 SMS로 수신하는 것에 동의할 수 있습니다. 이 정보는 사용자의 서비스 경험을 향상시키기 위한 목적으로만 사용됩니다.
        """
        VC.isTermsAndPolicies = true
        navigationController?.pushViewController(VC, animated: true)
    }
    
}

// MARK: - UI
extension TermsViewController {
    private func addViews() {
        view.addSubviews([termsLabel,
                          totalTermsView,
                          useTermsView,
                          privacyTermsView,
                          marketingTermsView,
                          completeButton])
        
        // 전체
        totalTermsView.addSubviews([totalTermsCheckButton, totalTermsLabelButton])
        // 서비스 이용약관
        useTermsView.addSubviews([useTermsCheckButton, useTermsLabelButton, useTermsMoreButton])
        // 개인정보 처리방침
        privacyTermsView.addSubviews([privacyTermsCheckButton, privacyLabelButton, privacyTermsMoreButton])
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
            make.top.equalTo(termsLabel.snp.bottom).offset(300)
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
            make.top.equalTo(useTermsView.snp.bottom).offset(20)
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
            make.top.equalTo(privacyTermsView.snp.bottom).offset(20)
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
