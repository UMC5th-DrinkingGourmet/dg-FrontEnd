//
//  TodayCombinationView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/2/24.
//

import UIKit

final class CombinationHomeView: UIView {
    
    // MARK: - View
    let tableView = UITableView().then {
        $0.keyboardDismissMode = .onDrag // 스크롤 할 때 키보드 내리기
        $0.separatorStyle = .none // 테이블뷰 구분선 없애기
    }
    
    let refreshControl = UIRefreshControl()
    
    let customSearchBar = CustomSearchBar()
    
    let uploadButton = UIButton().then {
        $0.backgroundColor = .customOrange
        $0.setImage(UIImage(named: "ic_floating_show"), for: .normal)
        $0.tintColor = .white
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
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
            tableView,
            customSearchBar,
            uploadButton
        ])
    }
    
    private func configureConstraints() {
        customSearchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(customSearchBar.snp.bottom).offset(15)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        uploadButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.trailing.equalToSuperview().inset(18)
            make.bottom.equalToSuperview().inset(58)
        }
    }
}
