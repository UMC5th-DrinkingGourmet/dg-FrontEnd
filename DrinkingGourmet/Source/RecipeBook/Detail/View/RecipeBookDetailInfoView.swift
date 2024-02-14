//
//  RecipeBookDetailInfoView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

final class RecipeBookDetailInfoView: UIView {
    
    // MARK: - View
    private let backgroudView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1).cgColor
    }
    
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
    
    private let dividerLineView1 = UIView().then {
        $0.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
    }
    
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
    
    private let dividerLineView2 = UIView().then {
        $0.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
    }
    
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
        addViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    func addViews() {
        self.addSubviews([backgroudView, timeLabel, timeNumLabel, dividerLineView1, kcalLabel, kcalNumLabel, dividerLineView2, likeLabel, likeNumLabel])
    }
    
    func configureConstraints() {
        backgroudView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(82)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroudView).inset(19)
            make.leading.equalTo(backgroudView).inset(35)
        }
        
        timeNumLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(8)
            make.centerX.equalTo(timeLabel)
        }
        
        dividerLineView1.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.equalTo(backgroudView).inset(30.5)
            make.leading.equalTo(timeLabel.snp.trailing).offset(26)
            make.bottom.equalTo(backgroudView).inset(30.5)
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
            make.trailing.equalTo(backgroudView).inset(42)
        }
        
        likeNumLabel.snp.makeConstraints { make in
            make.top.equalTo(timeNumLabel)
            make.centerX.equalTo(likeLabel)
        }
    }
}
