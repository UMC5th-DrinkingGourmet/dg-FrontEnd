//
//  QuestionAnswerView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/2/24.
//

import UIKit

final class AnswerView: UIView {
    // MARK: - View
    private let scrollView = UIScrollView()
    
    private let contentView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 0.5)
    }
    
    let answerLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "네, 가능합니다. \n\n사용자가 알레르기 정보를 프로필에 입력할 경우, 우리 시스템은 해당 정보를 고려하여 알레르기 유발 요소를 포함하지 않은 주류를 추천합니다. \n\n알레르기 정보는 언제든지 프로필 설정에서 업데이트할 수 있습니다.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
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
        contentView.addSubview(answerLabel)
    }
    
    private func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView)
            make.edges.equalTo(scrollView)
        }
        
        answerLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(20)
        }
    }
}
