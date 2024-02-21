//
//  GetDrinkingRecommendViewController.swift
//  DrinkingGourmet
//
//  Created by hee on 2/18/24.
//

import UIKit

class GetDrinkingRecommendViewController: UIViewController {
    let myRecommendModelData = MyRecommendModelData.shared
    //MyRecommendModelManager.model.result?.imageUrl
    // MARK: - View
    lazy var mainImage: UIImageView = {
        let iv = UIImageView()
        
        if let imageUrl = myRecommendModelData.model?.result?.imageUrl,
               let url = URL(string: imageUrl) {
                iv.kf.setImage(with: url)
        } else {
            iv.backgroundColor = .black
        }
        
        iv.contentMode = .scaleAspectFill
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
        
        if let text = myRecommendModelData.model?.result?.drinkName
               {
            lb.text = text
            lb.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.kern: -0.84, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        } else {
            lb.text = " "
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
        
        if let text = myRecommendModelData.model?.result?.recommendReason
               {
            $0.text = text
            $0.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.kern: -0.48, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        } else {
            $0.text = " "
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
        
        button.addTarget(self, action: #selector(anotherRecommendButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var myRecommendListButton: UIButton = {
        let button = UIButton()
        button.setTitle("나의 추천 목록", for: .normal)
        button.backgroundColor = UIColor.baseColor.base01
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(myRecommendListButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Navigation
    @objc func anotherRecommendButtonTapped(_ sender: UIButton) {
        if let tabBarVC = self.tabBarController as? TabBarViewController {
            // '주류추천' 탭을 선택
            tabBarVC.selectedIndex = 0
            
            // '주류추천' 탭의 네비게이션 컨트롤러를 가져옴
            if let vc = tabBarVC.viewControllers?[0] as? UINavigationController {
                // 네비게이션 컨트롤러의 스택을 루트 뷰 컨트롤러로 초기화
                vc.popToRootViewController(animated: true)
            }
        }
    }
    @objc func myRecommendListButtonTapped(_ sender: UIButton) {
        if let tabBarVC = self.tabBarController as? TabBarViewController {
            // '마이페이지' 탭을 선택
            tabBarVC.selectedIndex = 4
            
            // '마이페이지' 탭의 네비게이션 컨트롤러를 가져옴
            if let myPageNavController = tabBarVC.viewControllers?[4] as? UINavigationController {
                // 네비게이션 컨트롤러의 스택을 루트 뷰 컨트롤러로 초기화
                myPageNavController.popToRootViewController(animated: true)
            }
        }
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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

