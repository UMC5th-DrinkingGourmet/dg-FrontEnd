//
//  CommentAreaView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 1/28/24.
//

import UIKit
import SnapKit
import Then

class CommentAreaView: UIView {
    
    let titleLabel = UILabel().then {
        $0.text = "댓글 6"
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
    }
    
    let commentsView = CommentsView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureSubviews()
        configureConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        addSubviews([titleLabel, commentsView])
    }
    
    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(21)
        }
        
        commentsView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
