//
//  GetDrinkingRecommendViewController.swift
//  DrinkingGourmet
//
//  Created by hee on 2/18/24.
//

import UIKit

class GetDrinkingRecommendViewController: UIViewController {
    let myRecommendModelManager = MyRecommendModelManager.shared
    //MyRecommendModelManager.model.result?.imageUrl
    // MARK: - View
    lazy var mainImage: UIImageView = {
        let iv = UIImageView()
        
        if let imageUrl = myRecommendModelManager.model?.result?.imageUrl,
               let url = URL(string: imageUrl) {
                iv.kf.setImage(with: url)
        } else {
            // 이미지 URL이 없을 경우 검은색 배경 표시
            iv.backgroundColor = .black
        }
        
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var drinkNameLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 28)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        lb.textAlignment = .center
        
        if let text = myRecommendModelManager.model?.result?.drinkName
               {
            lb.text = text
            lb.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.kern: -0.84, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        } else {
            // 이미지 URL이 없을 경우 검은색 배경 표시
            lb.text = "추천 음료 없음."
        }
        
        
        return lb
    }()
    
    lazy var scrollView = UIScrollView()
    
    lazy var descriptionLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        
        if let text = myRecommendModelManager.model?.result?.recommendReason
               {
            $0.text = text
            $0.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.kern: -0.48, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        } else {
            $0.text = " ... "
        }
        

    }
    
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
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNaviBar()
        setAddSubViews()
        makeConstraints()
    }
    
    func setupNaviBar() {
        title = "주류추천"
        navigationItem.hidesBackButton = true
    }
    
    // MARK: - UI
    func setAddSubViews() {
        view.addSubviews([mainImage, drinkNameLabel, scrollView, anotherRecommendButton, myRecommendListButton])
        
        scrollView.addSubview(descriptionLabel)
    }
    
    func makeConstraints() {
        
        mainImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(49)
            make.leading.equalToSuperview().offset(67.5)
            make.trailing.equalToSuperview().offset(-67.5)
            make.height.equalTo(240)
        }
        
        drinkNameLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(14)
            make.centerX.equalTo(mainImage)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(drinkNameLabel.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(55)
            make.trailing.equalToSuperview().offset(-55)
            make.height.equalTo(168)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.leading.trailing.equalTo(scrollView).inset(1)
            make.width.equalTo(scrollView.snp.width).offset(-2)
        }
        
        anotherRecommendButton.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(41)
            make.leading.equalTo(scrollView)
            make.trailing.equalTo(mainImage.snp.centerX).offset(-4)
            make.height.equalTo(49)
        }
        
        myRecommendListButton.snp.makeConstraints { make in
            make.top.equalTo(anotherRecommendButton)
            make.leading.equalTo(mainImage.snp.centerX).offset(4)
            make.trailing.equalTo(scrollView)
            make.height.equalTo(anotherRecommendButton)
        }
    }
}

