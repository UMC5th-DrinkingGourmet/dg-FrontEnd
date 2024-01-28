//
//  CommentsView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 1/28/24.
//

import UIKit

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
        addArrangedSubviews([CommentView(.comment), CommentView(.reply), CommentView(.reply), CommentView(.comment), CommentView(.reply), CommentView(.comment, isLast: true)])
    }
}
