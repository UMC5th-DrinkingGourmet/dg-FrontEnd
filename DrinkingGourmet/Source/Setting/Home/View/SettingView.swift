//
//  SettingView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 3/31/24.
//

import UIKit

final class SettingView: UIView {
    // MARK: - View
    let tableView = UITableView().then {
        $0.separatorStyle = .none
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
        self.addSubviews([
            tableView
        ])
    }
    
    private func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
