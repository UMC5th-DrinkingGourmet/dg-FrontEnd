//
//  CommunityHomeView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

final class CommunityHomeView: UIView {
    // MARK: - View
    private let scrollView = UIScrollView()
    
    private let contentView = UIView()
    
    let combinationButton = UIButton().then {
        $0.setImage(UIImage(named: "img_community_home_combination"), for: .normal)
    }
    
    let weeklyBestButton = UIButton().then {
        $0.setImage(UIImage(named: "img_community_home_weeklybest"), for: .normal)
    }
    
    let recipeBookButton = UIButton().then {
        $0.setImage(UIImage(named: "img_community_home_recipebook"), for: .normal)
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
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
        self.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubviews([
            combinationButton,
            weeklyBestButton,
            recipeBookButton
        ])
    }
    
    func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.trailing.equalTo(contentView).inset(20)
            make.bottom.equalTo(contentView)
        }
        
        let buttons = [combinationButton, weeklyBestButton, recipeBookButton]

        buttons.forEach { button in
            button.snp.makeConstraints { make in
                make.height.equalTo(170)
            }
        }
    }
}
