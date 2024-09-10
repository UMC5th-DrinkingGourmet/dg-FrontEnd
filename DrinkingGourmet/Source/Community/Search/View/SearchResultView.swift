//
//  SearchResultView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

class SearchResultView: UIView {
    
    // MARK: - View
    let searchBar = CustomResultSearchBar()
    
    let cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
    }
    
    let recentLabel = UILabel().then {
        $0.text = "최근검색어"
        $0.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "최근 검색어", attributes: [NSAttributedString.Key.kern: -0.36, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let deleteAllButton = UIButton().then {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1),
            .font: UIFont(name: "AppleSDGothicNeo-Medium", size: 12)!,
            .kern: -0.36,
            .paragraphStyle: paragraphStyle
        ]
        
        $0.setAttributedTitle(NSAttributedString(string: "전체삭제", attributes: attributes), for: .normal)
    }

    
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
        self.addSubviews([searchBar, cancelButton, /*recentLabel, deleteAllButton, tableView*/])
    }
    
    func configureConstraints() {
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(2)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-61)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(searchBar)
            make.leading.equalTo(searchBar.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-20)
        }
        
//        recentLabel.snp.makeConstraints { make in
//            make.top.equalTo(searchBar.snp.bottom).offset(33)
//            make.leading.equalTo(searchBar)
//        }
//        
//        deleteAllButton.snp.makeConstraints { make in
//            make.top.equalTo(recentLabel)
//            make.trailing.equalTo(cancelButton)
//        }
//        
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(recentLabel.snp.bottom).offset(32)
//            make.leading.equalTo(searchBar)
//            make.trailing.equalTo(cancelButton)
//            make.bottom.equalToSuperview()
//        }
    }
    
}

