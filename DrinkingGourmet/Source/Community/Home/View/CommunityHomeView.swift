//
//  CommunityHomeView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

class CommunityHomeView: UIView {

    // MARK: - View
    let tableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false // 스크롤바 숨기기
        $0.keyboardDismissMode = .onDrag // 스크롤 할 때 키보드 내리기
        $0.separatorStyle = .none // 테이블뷰 구분선 없애기
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
    func addViews() {
        self.addSubviews([tableView])
    }
    
    func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
    }

}

