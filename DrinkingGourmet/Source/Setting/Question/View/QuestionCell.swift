//
//  QuestionCell.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/1/24.
//

import UIKit

final class QuestionCell: UITableViewCell {
    // MARK: - View
    let questionLabel = UILabel().then {
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "이 서비스는 어떤 기준으로 음식과 어울리는 주류를 추천하나요?", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let arrowIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_more")
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        addViews()
        configureConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func addViews() {
        contentView.addSubviews([questionLabel,
                          arrowIcon])
    }
    
    private func configureConstraints() {
        questionLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(28)
            make.top.bottom.equalTo(contentView).inset(20)
            make.trailing.equalTo(arrowIcon.snp.leading).offset(-8)
        }
        
        arrowIcon.snp.makeConstraints { make in
            make.size.equalTo(12)
            make.trailing.equalTo(contentView).inset(28)
            make.centerY.equalTo(contentView)
        }
    }
}
