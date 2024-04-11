//
//  CombinationDetailCommentCell.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 4/10/24.
//

import UIKit

final class CombinationDetailCommentCell: UITableViewCell {
    // MARK: - View
    let profileImage = UIImageView().then {
        $0.backgroundColor = UIColor(red: 0.935, green: 0.935, blue: 0.935, alpha: 1)
        $0.image = UIImage(named: "ic_default_profile")
        $0.layer.cornerRadius = 10
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    let nicknameLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "미쉭가", attributes: [NSAttributedString.Key.kern: -0.36, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let dateLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 10)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "2023.12.30 22:57", attributes: [NSAttributedString.Key.kern: -0.3, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let moreButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_comment_more"), for: .normal)
    }
    
    let commentLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "이렇게 어울릴 수가 없습니다..", attributes: [NSAttributedString.Key.kern: -0.42, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let dividerView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.935, green: 0.935, blue: 0.935, alpha: 1)
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        self.selectionStyle = .none
        
        addViews()
        configureConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func addViews() {
        contentView.addSubviews([
            profileImage,
            nicknameLabel,
            dateLabel,
            moreButton,
            commentLabel,
            dividerView
        ])
    }
    
    private func configureConstraints() {
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(12)
            make.leading.equalTo(contentView).inset(24)
            make.size.equalTo(20)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(4)
            make.centerY.equalTo(profileImage)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(nicknameLabel.snp.trailing).offset(8)
            make.centerY.equalTo(profileImage)
        }
        
        moreButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(21)
            make.centerY.equalTo(profileImage)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(3)
            make.leading.equalTo(nicknameLabel)
            make.trailing.equalTo(moreButton)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(contentView).inset(21)
            make.height.equalTo(1)
        }
    }
}

