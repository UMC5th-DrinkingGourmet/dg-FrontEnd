//
//  QuestionView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/1/24.
//

import UIKit

final class QuestionView: UIView {
    // MARK: - View
    let tableView = UITableView().then {
        $0.separatorInset.left = 20
        $0.separatorInset.right = 20
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
        self.addSubview(tableView)
    }
    
    private func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
