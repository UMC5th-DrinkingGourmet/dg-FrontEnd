//
//  WeeklyBestView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

final class WeeklyBestView: UIView {
    
    // MARK: - View
    let tableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false // 스크롤바 숨기기
        $0.keyboardDismissMode = .onDrag // 스크롤 할 때 키보드 내리기
        $0.separatorStyle = .none // 테이블뷰 구분선 없애기
    }
    
    let refreshControl = UIRefreshControl()
    
    let customSearchBar = CustomSearchBar()
    
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
            tableView,
            customSearchBar
        ])
    }
    
    private func configureConstraints() {
        customSearchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(customSearchBar.snp.bottom).offset(10)
            make.leading.trailing.equalTo(customSearchBar)
            make.bottom.equalToSuperview()
        }
    }
}
