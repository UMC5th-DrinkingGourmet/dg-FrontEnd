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
    
    // 레시피북 댓글 설정
    func configureRecipeBookComments(_ comments: [RecipeBookCommentModel.CommentList]) {
        arrangedSubviews.forEach { $0.removeFromSuperview() }  // 기존 뷰들 제거
        
        for comment in comments {
            let commentView = CommentView(.comment)
            configureRecipeBookView(commentView, with: comment)
            addArrangedSubview(commentView)
            
            for childComment in comment.childCommentList {
                let replyView = CommentView(.reply)
                configureRecipeBookView(replyView, with: childComment)
                addArrangedSubview(replyView)
            }
        }
    }
    
    // 댓글 뷰 구성
    private func configureRecipeBookView(_ view: CommentView, with data: RecipeBookCommentModel.CommentList) {
        if let imageUrl = URL(string: data.member.profileImageUrl ?? "") {
            view.profileImageView.kf.setImage(with: imageUrl)
        }
        view.nameLabel.text = data.member.nickName
        view.dateLabel.text = formatDate(data.createdDate)
        view.contentLabel.text = data.content
    }
    
    func formatDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.locale = Locale(identifier: "en_US_POSIX") // ISO8601 형식 처리를 위해 설정
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS" // 서버에서 오는 날짜 형식에 맞춤

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy.MM.dd HH:mm" // 원하는 출력 형식

        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return ""
        }
    }

}
