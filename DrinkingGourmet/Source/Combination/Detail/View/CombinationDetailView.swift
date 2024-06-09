//
//  CombinationDetailView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 4/10/24.
//

import UIKit

final class CombinationDetailView: UIView {
    // MARK: - View
    let tabelView = UITableView(frame: CGRect.zero, style: .grouped).then {
        $0.contentInsetAdjustmentBehavior = .never
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .onDrag
    }
    
    let commentInputView = CommentInputView()
    
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
        self.addSubviews([
            tabelView,
            commentInputView
        ])
    }
    
    private func configureConstraints() {
        tabelView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(commentInputView.snp.top)
        }
        
        commentInputView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(96)
        }
    }
}

