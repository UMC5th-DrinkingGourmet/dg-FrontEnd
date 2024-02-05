//
//  InputMyFoodViewController.swift
//  DrinkingGourmet
//
//  Created by 김희은 on 1/13/24.
//

import UIKit

class InputMyFoodViewController: UIViewController {
    
    lazy var progressBar: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.clipsToBounds = true
        progressBar.layer.cornerRadius = 5
        progressBar.tintColor = .black
        progressBar.trackTintColor = UIColor(named: "base08")
        
        return progressBar
    }()
    
    lazy var guideText: UILabel = {
        let text = UILabel()
        text.textColor = UIColor(named: "base01")
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 24)
        text.text =
        "드실 음식을 입력해주세요."
        
        return text
    }()
    
    
    lazy var subGuideText: UILabel = {
        let text = UILabel()
        text.textColor = .lightGray
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 14)
        text.text = "오늘은 어떤 음식과 함께 하시나요?"
        
        return text
        
    }()
    
    lazy var searchBar: FoodSearchBarView = .init()
    
    lazy var foodSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "치킨"
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    lazy var nextButton = makeNextButton(buttonTitle: "다음")
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "주류추천"
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        
        navigationItem.leftBarButtonItem = backButton
        
        setAddSubViews()
        makeConstraints()
    }
    
    // MARK: - Navigation
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    @objc func nextButtonTapped(_ sender: UIButton) {
        let nextViewController = SelectMyMoodViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    // MARK: - Constraints
    func setAddSubViews() {
        view.addSubview(progressBar)
        view.addSubview(guideText)
        view.addSubview(subGuideText)
        view.addSubview(searchBar)
        view.addSubview(nextButton)
    }
    
    func makeConstraints() {
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(2)
            progressBar.progress = 0.4
        }
        
        guideText.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(23)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(36)
        }
        
        subGuideText.snp.makeConstraints { make in
            make.top.equalTo(guideText.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(21)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(subGuideText.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        }
    }
}

