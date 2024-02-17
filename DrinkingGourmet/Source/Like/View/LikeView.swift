//
//  LikeView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/17/24.
//

import UIKit

class LikeView: UIView {
    
    // MARK: - View
    private let combinationBackView = UIView()
    
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
    
    private let recipeBookBackView = UIView()
    
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
        addViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    func addViews() {
        self.addSubviews([combinationBackView, combinationButton, combinationLabel, leftLine, recipeBookBackView, recipeBookButton, recipeBookLabel, rightLine, collectionView])
    }
    
    func configureConstraints() {
        
        let screenWidth = UIScreen.main.bounds.width
        let backViewWidth = screenWidth / 2 // 화면 너비의 절반
        
        combinationBackView.snp.makeConstraints { make in
            make.width.equalTo(backViewWidth)
            make.height.equalTo(48)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(25)
            make.leading.equalToSuperview()
        }
        
        combinationButton.snp.makeConstraints { make in
            make.edges.equalTo(combinationBackView)
        }
        
        combinationLabel.snp.makeConstraints { make in
            make.center.equalTo(combinationBackView)
        }
        
        leftLine.snp.makeConstraints { make in
            make.width.equalTo(backViewWidth)
            make.height.equalTo(1)
            make.top.equalTo(combinationBackView.snp.bottom)
            make.leading.equalTo(combinationBackView)
        }
        
        recipeBookBackView.snp.makeConstraints { make in
            make.width.equalTo(backViewWidth)
            make.height.equalTo(combinationBackView)
            make.top.equalTo(combinationBackView)
            make.leading.equalTo(combinationBackView.snp.trailing)
        }
        
        recipeBookButton.snp.makeConstraints { make in
            make.edges.equalTo(recipeBookBackView)
        }
        
        recipeBookLabel.snp.makeConstraints { make in
            make.center.equalTo(recipeBookBackView)
        }
        
        rightLine.snp.makeConstraints { make in
            make.width.equalTo(188)
            make.height.equalTo(1)
            make.top.equalTo(recipeBookBackView.snp.bottom)
            make.leading.equalTo(recipeBookBackView)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(leftLine.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
