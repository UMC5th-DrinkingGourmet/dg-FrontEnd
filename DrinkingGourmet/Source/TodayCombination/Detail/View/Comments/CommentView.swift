//
//  CommentView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 1/28/24.
//

import UIKit
import SnapKit
import Then

class CommentView: UIView {
    
    enum CommentType {
        case comment // 댓글
        case reply // 대댓글
    }
    
    var commentType: CommentType = .comment {
        didSet { update() }
    }
    
    private var profileLeadingConstraint: Constraint?
    
    let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.image = UIImage(named: "ic_default_profile")
    }
    
    let nameLabel = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
        $0.text = "테스트닉네임"
    }
    
    let dateLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 10)
        $0.text = "2023.12.30 22:54"
    }
    
    let contentLabel = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        $0.numberOfLines = 0
        $0.text = "테스트 내용입니다."
    }
    
    let replyButton = UIButton().then {
        $0.setTitleColor(UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 10)
        $0.setTitle("답글쓰기", for: .normal)
    }
    
    let replyCountLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 10)
        $0.text = "답글 1"
    }
    
    let moreButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_comment_more"), for: .normal)
    }
    
    let dividerLineView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        configureConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ type: CommentType, isLast: Bool = false) {
        defer {
            commentType = type
            dividerLineView.isHidden = isLast
        }
        
        self.init(frame: .zero)
    }
    
    func addViews() {
        addSubviews(
            [profileImageView, nameLabel, dateLabel, contentLabel, replyButton, replyCountLabel, moreButton, dividerLineView]
        )
    }
    
    func configureConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.top.equalToSuperview()
            profileLeadingConstraint = make.leading.equalToSuperview().inset(21).constraint
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(4)
            make.centerY.equalTo(profileImageView)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.trailing).offset(8)
            make.centerY.equalTo(nameLabel)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nameLabel)
            make.trailing.equalToSuperview().inset(40)
        }
        
        replyButton.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(2)
            make.leading.equalTo(nameLabel)
            make.height.equalTo(12)
        }
        
        replyCountLabel.snp.makeConstraints { make in
            make.top.equalTo(replyButton)
            make.leading.equalTo(replyButton.snp.trailing).offset(16)
        }
        
        moreButton.snp.makeConstraints { make in
            make.size.equalTo(16)
            make.trailing.equalToSuperview().inset(21)
            make.centerY.equalTo(profileImageView)
        }
        
        dividerLineView.snp.makeConstraints { make in
            make.top.equalTo(replyButton.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(21)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func update() {
        profileLeadingConstraint?.update(inset: (commentType == .comment) ? 21 : 45)
        replyCountLabel.isHidden = commentType == .reply
    }
}
