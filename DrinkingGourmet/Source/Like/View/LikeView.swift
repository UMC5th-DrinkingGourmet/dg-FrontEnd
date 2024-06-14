//
//  LikeView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/17/24.
//

import UIKit

class LikeView: UIView {
    // MARK: - View
    let refreshControl = UIRefreshControl()
    
    private let combinationButtonView = UIView()
    
    let combinationButton = UIButton().then {
        $0.backgroundColor = .clear
    }
    
    let combinationLabel = UILabel().then {
        $0.text = "오늘의 조합"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
    }
    
    let leftLine = UIView().then {
        $0.backgroundColor = .customOrange
    }
    
    private let recipeBookButtonView = UIView()
    
    let recipeBookButton = UIButton().then {
        $0.backgroundColor = .clear
    }
    
    let recipeBookLabel = UILabel().then {
        $0.text = "레시피북"
        $0.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
    }
    
    let rightLine = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let flowlayout = UICollectionViewFlowLayout()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout).then {
        $0.backgroundColor = .clear
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
    func addViews() {
        self.addSubviews([
            combinationButtonView,
            leftLine,
            recipeBookButtonView,
            rightLine,
            collectionView
        ])
        
        combinationButtonView.addSubviews([combinationButton, combinationLabel])
        recipeBookButtonView.addSubviews([recipeBookButton, recipeBookLabel])
    }
    
    func configureConstraints() {
        
        let halfScreenWidth = UIScreen.main.bounds.width / 2 // 화면 너비의 절반
        
        combinationButtonView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(25)
            make.leading.equalToSuperview()
            make.width.equalTo(halfScreenWidth)
            make.height.equalTo(48)
        }
        
        combinationButton.snp.makeConstraints { make in
            make.edges.equalTo(combinationButtonView)
        }
        
        combinationLabel.snp.makeConstraints { make in
            make.center.equalTo(combinationButtonView)
        }
        
        leftLine.snp.makeConstraints { make in
            make.top.equalTo(combinationButtonView.snp.bottom)
            make.leading.equalTo(combinationButtonView)
            make.width.equalTo(combinationButtonView)
            make.height.equalTo(2)
        }
        
        recipeBookButtonView.snp.makeConstraints { make in
            make.top.equalTo(combinationButtonView)
            make.leading.equalTo(combinationButtonView.snp.trailing)
            make.size.equalTo(combinationButtonView)
        }
        
        recipeBookButton.snp.makeConstraints { make in
            make.edges.equalTo(recipeBookButtonView)
        }
        
        recipeBookLabel.snp.makeConstraints { make in
            make.center.equalTo(recipeBookButtonView)
        }
        
        rightLine.snp.makeConstraints { make in
            make.top.equalTo(recipeBookButtonView.snp.bottom)
            make.leading.equalTo(recipeBookButtonView)
            make.size.equalTo(leftLine)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(leftLine.snp.bottom).offset(1)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
