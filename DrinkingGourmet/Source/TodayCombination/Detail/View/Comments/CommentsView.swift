//
//  CommentsView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 1/28/24.
//

import UIKit
import Kingfisher

class CommentsView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        addViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        axis = .vertical
        spacing = 12
    }
    
    func addViews() {
        //        addArrangedSubviews([CommentView(.comment), CommentView(.reply), CommentView(.reply), CommentView(.comment), CommentView(.reply), CommentView(.comment, isLast: true)])
    }
    
    func configureComments(_ comments: [CombinationCommentModel.CombinationCommentList]) {
        arrangedSubviews.forEach { $0.removeFromSuperview() }  // 기존 뷰들 제거
        
        for comment in comments {
            let commentView = CommentView(.comment)
            configureCommentView(commentView, with: comment)
            addArrangedSubview(commentView)
            
            for childComment in comment.childComments {
                let replyView = CommentView(.reply)
                configureCommentView(replyView, with: childComment)
                addArrangedSubview(replyView)
            }
        }
    }
    
    private func configureCommentView(_ view: CommentView, with data: CombinationCommentModel.CombinationCommentList) {
        if let imageUrlString = data.memberProfile {
            if let imageUrl = URL(string: imageUrlString) {
                view.profileImageView.kf.setImage(with: imageUrl)
            }
            view.nameLabel.text = data.memberNickName
            view.dateLabel.text = data.createdAt
            view.contentLabel.text = data.content
//            view.replyCountLabel.text = "답글 \(data.childCount)"
        }
    }
}
