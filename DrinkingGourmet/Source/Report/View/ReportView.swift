//
//  ReportView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 3/26/24.
//

import UIKit

final class ReportView: UIView {
    // MARK: - View
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
        $0.keyboardDismissMode = .onDrag // 스크롤 시 키보드 숨김
    }
    
    private let contentView = UIView()
    
    let pickerView = UIPickerView()
    
    // 신고 유형
    private let reportTypeLabel = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "신고 유형", attributes: [NSAttributedString.Key.kern: -0.48, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let reportTypeView = UIView().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.base0700.cgColor
    }
    
    let reportTypeTextField = UITextField().then {
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.tintColor = .clear
        $0.textColor = .base0400
        
        let textColor = UIColor.base0700
        let font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16) ?? UIFont.systemFont(ofSize: 16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25

        let attributedText = NSAttributedString(string: "신고 유형을 선택해주세요.", attributes: [
            .font: font,
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle
        ])

        $0.attributedPlaceholder = attributedText
    }
    
    private let reportTypeArrowIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_upload_more_false")
    }
    
    // 신고 내용
    private let reportDetailsLabel = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "신고 내용", attributes: [NSAttributedString.Key.kern: -0.48, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let reportDetailsTextView = UITextView().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.base0700.cgColor
        $0.textContainerInset = UIEdgeInsets(top: 12.0, left: 16.0, bottom: 12.0, right: 16.0)
    }
    
    // 설명
    private let descriptionLabel = UILabel().then {
        $0.textColor = UIColor.base0400
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "· 이 회원이 신고 대상에 해당하는지 다시 한번 확인해주시기 바랍니다.\n\n· 신고가 처리되면 해당 게시물은 삭제됩니다.\n\n· 신고 처리 결과는 영업일 기준 3일 이내에 이메일로 안내드립니다.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    // 신고하기
    let completeView = UIView().then {
        $0.backgroundColor = .base0500
    }
    
    let completeButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.isEnabled = false
    }
    
    private let completeLabel = UILabel().then {
        $0.textColor = .base1000
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1
        $0.attributedText = NSMutableAttributedString(string: "신고하기", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func addViews() {
        self.addSubviews([scrollView, 
                          completeView])
        
        scrollView.addSubview(contentView)
        
        contentView.addSubviews([reportTypeLabel,
                                 reportTypeView,
                                 reportTypeTextField,
                                 reportTypeArrowIcon,
                                 reportDetailsLabel,
                                 reportDetailsTextView,
                                 descriptionLabel])
        
        completeView.addSubviews([completeButton, completeLabel])
    }
    
    private func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(completeView.snp.top)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        // 신고 유형
        reportTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(15)
            make.leading.equalTo(contentView).offset(20)
        }
        
        reportTypeView.snp.makeConstraints { make in
            make.top.equalTo(reportTypeLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(contentView).inset(20)
            make.height.equalTo(49)
        }
        
        reportTypeTextField.snp.makeConstraints { make in
            make.top.equalTo(reportTypeView).inset(13)
            make.leading.equalTo(reportTypeView).inset(16)
            make.trailing.equalTo(reportTypeArrowIcon).inset(16)
            make.bottom.equalTo(reportTypeView).inset(12)
        }
        
        reportTypeArrowIcon.snp.makeConstraints { make in
            make.size.equalTo(12)
            make.top.equalTo(reportTypeView).inset(19)
            make.trailing.equalTo(reportTypeView).inset(16)
            make.bottom.equalTo(reportTypeView).inset(18)
        }
        
        // 신고 내용
        reportDetailsLabel.snp.makeConstraints { make in
            make.top.equalTo(reportTypeView.snp.bottom).offset(56)
            make.leading.equalTo(reportTypeLabel)
        }
        
        reportDetailsTextView.snp.makeConstraints { make in
            make.top.equalTo(reportDetailsLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(reportTypeView)
            make.height.equalTo(150)
        }
        
        // 설명
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(reportDetailsTextView.snp.bottom).offset(24)
            make.leading.equalTo(contentView).inset(20)
            make.trailing.equalTo(contentView).inset(36)
            make.bottom.equalTo(contentView)
        }
        
        // 신고하기
        completeView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(89)
        }
        
        completeButton.snp.makeConstraints { make in
            make.edges.equalTo(completeView)
        }
        
        completeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(completeView)
            make.top.equalTo(completeView).offset(18)
        }
    }
}
