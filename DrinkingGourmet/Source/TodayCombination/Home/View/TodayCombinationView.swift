//
//  TodayCombinationView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/2/24.
//

import UIKit

final class TodayCombinationView: UIView {
    
    // MARK: - View
    let tableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false // 스크롤바 숨기기
        $0.keyboardDismissMode = .onDrag // 스크롤 할 때 키보드 내리기
        $0.separatorStyle = .none // 테이블뷰 구분선 없애기
    }
    
    let refreshControl = UIRefreshControl()
    
    let customSearchBar = CustomSearchBar()
    
    let floatingButton = UIButton().then {
        $0.backgroundColor = .customOrange
        $0.setImage(UIImage(named: "ic_floating_show"), for: .normal)
        $0.tintColor = .white
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
            customSearchBar,
            floatingButton
        ])
    }
    
    private func configureConstraints() {
        customSearchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(customSearchBar.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
        
        floatingButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.trailing.equalToSuperview().offset(-18)
            make.bottom.equalToSuperview().offset(-58)
        }
    }
}
