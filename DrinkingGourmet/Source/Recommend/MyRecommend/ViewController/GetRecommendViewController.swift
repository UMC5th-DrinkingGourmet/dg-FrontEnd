//
//  GetDrinkingRecommendViewController.swift
//  DrinkingGourmet
//
//  Created by hee on 2/18/24.
//

import UIKit

class GetRecommendViewController: UIViewController {
    private let foodName: String = "드실 음식"
    private let drinkName: String = "상큼한 칵테일"
    private let recommendReason: String = "오늘 날씨가 화창하니 기분이 좋은 여자친구와 함께 고기를 먹는 데이트라면, 상큼하고 청량감 넘치는 칵테일이 최적의 선택입니다.\n\n이러한 칵테일은 달콤한 맛과 함께 상쾌한 느낌을 주어 기분 좋은 분위기를 연출할 수 있습니다.이러한 칵테일은 달콤한 맛과 함께 상쾌한 느낌을 주어 기분 좋은 분위기를 연출할 수 있습니다."
    private let imageUrl: String = ""
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        return imageView
    }()
    
    lazy var drinkNameLabel: UILabel = {
        let label = UILabel()
        label.text = drinkName
        label.textAlignment = .center
        label.textColor = UIColor.baseColor.base01
        label.font = UIFont.systemFont(ofSize: 28.0)
        return label
    }()
    
    lazy var recommendReasonLabel: UILabel = {
        // label vertical alignment 정의 필요
        let label = UILabel()
        label.text = recommendReason
        label.textAlignment = .left
        label.textColor = UIColor.baseColor.base04
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    lazy var anotherRecommendButton: UIButton = {
        let button = UIButton()
        button.setTitle("다른 추천 받기", for: .normal)
        button.backgroundColor = UIColor.baseColor.base08
        button.setTitleColor(UIColor.baseColor.base02, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var myRecommendListButton: UIButton = {
        let button = UIButton()
        button.setTitle("나의 추천 목록", for: .normal)
        button.backgroundColor = UIColor.baseColor.base01
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.baseColor.base10
        
        // navigation
        title = "주류추천"
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backButton
        
        setAddSubViews()
        makeConstraints()
        
    }
    
    // MARK: - Actions
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Constraints
    func setAddSubViews() {
        view.addSubview(imageView)
        view.addSubview(drinkNameLabel)
        view.addSubview(recommendReasonLabel)
        view.addSubview(anotherRecommendButton)
        view.addSubview(myRecommendListButton)
    }
    
    func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(11)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.322)
        }
        drinkNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(imageView.snp.bottom).offset(43)
            make.height.equalTo(50)
        }
        recommendReasonLabel.snp.makeConstraints  { make in
            make.top.equalTo(drinkNameLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(55)
            make.trailing.equalToSuperview().offset(-55)
            make.bottom.equalTo(anotherRecommendButton.snp.top).offset(-30)
        }
        anotherRecommendButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
            //make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(myRecommendListButton.snp.leading).offset(-20)
            make.height.equalTo(59)
            make.width.equalTo(myRecommendListButton)
        }
        myRecommendListButton.snp.makeConstraints { make in
            make.bottom.equalTo(anotherRecommendButton)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalTo(anotherRecommendButton.snp.trailing).offset(20)
            make.height.equalTo(59)
            make.width.equalTo(anotherRecommendButton)
        }
    }
}
