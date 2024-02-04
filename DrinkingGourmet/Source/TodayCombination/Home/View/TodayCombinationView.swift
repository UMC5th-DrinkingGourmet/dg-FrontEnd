//
//  TodayCombinationView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/2/24.
//

import UIKit
import SnapKit
import Then

class TodayCombinationView: UIView {
    
    // MARK: - View
    let tableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false // 스크롤바 숨기기
        $0.keyboardDismissMode = .onDrag // 스크롤 할 때 키보드 내리기
        $0.separatorStyle = .none // 테이블뷰 구분선 없애기
    }
    
    let customSearchBar = CustomSearchBar()
    
    let floatingButton = UIButton().then {
        $0.backgroundColor = .customOrange
        $0.setImage(UIImage(named: "ic_floating_show"), for: .normal)
        $0.tintColor = .white
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
    }
    
    let writeLabel = UILabel().then {
        $0.text = "작성하기"
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        $0.isHidden = true
    }
    
    let writeButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_write"), for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
        $0.isHidden = true
    }
    
    let modifyLabel = UILabel().then {
        $0.text = "수정하기"
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        $0.isHidden = true
    }
    
    let modifyButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_modify"), for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
        $0.isHidden = true
    }
    
    let floatingStackView = UIStackView().then {
        $0.axis = .vertical // 수직으로 정렬
        $0.spacing = 8
        $0.alignment = .fill // 버튼의 가로 크기를 일정하게 유지
        $0.distribution = .fillEqually // 버튼의 세로 크기를 균등하게 배분
    }
    
    lazy var shadowView: UIView = {
        let view = UIView(frame: self.frame)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.alpha = 0
        view.isHidden = true
        
        self.insertSubview(view, belowSubview: floatingStackView)
        
        return view
    }()
    
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
        floatingStackView.addArrangedSubviews([modifyButton, /*modifyLabel,*/ writeButton, /*writeLabel,*/ floatingButton])
        
        self.addSubviews([tableView, customSearchBar,floatingStackView, writeLabel, modifyLabel])
    }
    
    func configureConstraints() {
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
        
        floatingStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-18)
            make.bottom.equalToSuperview().offset(-58)
        }
        
        floatingButton.snp.makeConstraints { make in
            make.size.equalTo(50)
        }
        
        writeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-80)
            make.bottom.equalToSuperview().offset(-130)
        }
        
        writeButton.snp.makeConstraints { make in
            make.size.equalTo(50)
        }
        
        modifyLabel.snp.makeConstraints { make in
            make.trailing.equalTo(writeLabel)
            make.bottom.equalToSuperview().offset(-188)
        }
        
        modifyButton.snp.makeConstraints { make in
            make.size.equalTo(50)
        }
    }
}
