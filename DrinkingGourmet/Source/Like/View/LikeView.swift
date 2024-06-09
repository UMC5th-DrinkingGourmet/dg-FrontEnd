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
            combinationButton,
            combinationLabel,
            leftLine,
            recipeBookButtonView,
            recipeBookButton,
            recipeBookLabel,
            rightLine,
            collectionView
        ])
    }
    
    func configureConstraints() {
        
        let screenWidth = UIScreen.main.bounds.width
        let backViewWidth = screenWidth / 2 // 화면 너비의 절반
        
        combinationButtonView.snp.makeConstraints { make in
            make.width.equalTo(backViewWidth)
            make.height.equalTo(48)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(25)
            make.leading.equalToSuperview()
        }
        
        combinationButton.snp.makeConstraints { make in
            make.edges.equalTo(combinationButtonView)
        }
        
        combinationLabel.snp.makeConstraints { make in
            make.center.equalTo(combinationButtonView)
        }
        
        leftLine.snp.makeConstraints { make in
            make.width.equalTo(backViewWidth)
            make.height.equalTo(1)
            make.top.equalTo(combinationButtonView.snp.bottom)
            make.leading.equalTo(combinationButtonView)
        }
        
        recipeBookButtonView.snp.makeConstraints { make in
            make.width.equalTo(backViewWidth)
            make.height.equalTo(combinationButtonView)
            make.top.equalTo(combinationButtonView)
            make.leading.equalTo(combinationButtonView.snp.trailing)
        }
        
        recipeBookButton.snp.makeConstraints { make in
            make.edges.equalTo(recipeBookButtonView)
        }
        
        recipeBookLabel.snp.makeConstraints { make in
            make.center.equalTo(recipeBookButtonView)
        }
        
        rightLine.snp.makeConstraints { make in
            make.width.equalTo(188)
            make.height.equalTo(1)
            make.top.equalTo(recipeBookButtonView.snp.bottom)
            make.leading.equalTo(recipeBookButtonView)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(leftLine.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
