//
//  DeleteAccountView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/2/24.
//

import UIKit

final class DeleteAccountView: UIView {
    // MARK: - View
    private let scrollView = UIScrollView()
    
    private let contentView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 0.5)
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    private let descriptionLabel_1 = UILabel().then {
        $0.textColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "회원 탈퇴가 필요하신 경우, 아래의 '회원 탈퇴' 버튼을 클릭해주시기 바랍니다.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let deleteAccountView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    let deleteAccountButton = UIButton().then {
        $0.backgroundColor = .clear
    }
    
    private let deleteAccountLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.89, green: 0.161, blue: 0.22, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "회원탈퇴", attributes: [NSAttributedString.Key.kern: -0.3, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let arrowIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_more")
    }
    
    private let descriptionLabel_2 = UILabel().then {
        $0.textColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        
        let fullText = """
        서비스 이용 중 불편을 겪으셨다면, drinkgourmet.official@gmail.com 으로 문제를 상세히 보내주시면, 저희가 서비스를 개선하는 데 큰 도움이 됩니다.\n
        주의사항:\n
        · 앱 내의 모든 활동은 기록되며, 부적절한 내용을 남기신 후 회원 탈퇴를 하시는 경우, 법적 조치의 대상이 될 수 있습니다.\n
        · 회원 탈퇴를 하실 경우, 작성하신 게시물과 댓글은 모두 삭제되며, 이는 복구가 불가능합니다.\n
        · 회원 탈퇴 후 7일이 경과한 후에만 재가입이 가능합니다.
        """
        
        let attributedString = NSMutableAttributedString(string: fullText, attributes: [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!
        ])
        
        let boldFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)!
        let boldRange = (fullText as NSString).range(of: "주의사항:")
        attributedString.addAttributes([NSAttributedString.Key.font: boldFont], range: boldRange)
        
        $0.attributedText = attributedString
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
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubviews([descriptionLabel_1,
                                       deleteAccountView,
                                       descriptionLabel_2])
        
        deleteAccountView.addSubviews([deleteAccountButton,
                                       deleteAccountLabel,
                                       arrowIcon])
    }
    
    private func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView)
            make.edges.equalTo(scrollView)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(20)
        }
        
        deleteAccountView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        deleteAccountButton.snp.makeConstraints { make in
            make.edges.equalTo(deleteAccountView)
        }
        
        deleteAccountLabel.snp.makeConstraints { make in
            make.leading.equalTo(deleteAccountView).inset(20)
            make.centerY.equalTo(deleteAccountView)
        }
        
        arrowIcon.snp.makeConstraints { make in
            make.size.equalTo(12)
            make.trailing.equalTo(deleteAccountView).inset(20)
            make.centerY.equalTo(deleteAccountView)
        }
    }
}
