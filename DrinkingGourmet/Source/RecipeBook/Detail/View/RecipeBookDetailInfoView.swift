//
//  RecipeBookDetailInfoView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

final class RecipeBookDetailInfoView: UIView {
    
    // MARK: - View
    // 소요시간
    private let timeLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "소요시간"
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        $0.textColor = UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
    }
    
    let timeNumLabel = UILabel().then {
        $0.textColor = .customOrange
        $0.text = "9999m"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
    }
    
    // 구분선
    private let dividerLineView1 = UIView().then {
        $0.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
    }
    
    // 칼로리
    private let kcalLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "칼로리"
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        $0.textColor = UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
    }
    
    let kcalNumLabel = UILabel().then {
        $0.textColor = .customOrange
        $0.text = "9999kcal"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
    }
    
    // 구분선
    private let dividerLineView2 = UIView().then {
        $0.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
    }
    
    // 좋아요
    private let likeLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "좋아요"
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        $0.textColor = UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
    }
    
    let likeNumLabel = UILabel().then {
        $0.textColor = .customOrange
        $0.text = "9999"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1).cgColor
        
        addViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    func addViews() {
        self.addSubviews([timeLabel, timeNumLabel, dividerLineView1, kcalLabel, kcalNumLabel, dividerLineView2, likeLabel, likeNumLabel])
    }
    
    func configureConstraints() {
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(19)
            make.leading.equalToSuperview().inset(35)
        }
        
        timeNumLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(8)
            make.centerX.equalTo(timeLabel)
        }
        
        dividerLineView1.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.equalToSuperview().inset(30.5)
            make.leading.equalTo(timeLabel.snp.trailing).offset(26)
            make.bottom.equalToSuperview().inset(30.5)
        }
        
        kcalLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel)
            make.leading.equalTo(dividerLineView1).offset(39)
        }
        
        kcalNumLabel.snp.makeConstraints { make in
            make.top.equalTo(timeNumLabel)
            make.centerX.equalTo(kcalLabel)
        }
        
        dividerLineView2.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.equalTo(dividerLineView1)
            make.trailing.equalTo(likeLabel.snp.leading).offset(-32)
            make.bottom.equalTo(dividerLineView1)
        }
        
        likeLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel)
            make.trailing.equalToSuperview().inset(42)
        }
        
        likeNumLabel.snp.makeConstraints { make in
            make.top.equalTo(timeNumLabel)
            make.centerX.equalTo(likeLabel)
        }
    }
}
