//
//  SelectWeatherViewController.swift
//  DrinkingGourmet
//
//  Created by 김희은 on 1/15/24.
//

import UIKit

class SelectWeatherViewController: UIViewController {
    var buttonSelected: Bool = false
    
    private let resource: SelectWeatherResource = SelectWeatherResource()
    var buttonImageArray: [UIImage] {
        return resource.weatherButtonImageArray()
    }
    var buttonSelectedImageArray: [UIImage] {
        return resource.weatherButtonSelectedImageArray()
    }
    
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
        "지금 날씨는 어떤가요?"
        
        return text
    }()
    
    
    lazy var subGuideText: UILabel = {
        let text = UILabel()
        text.textColor = .lightGray
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 14)
        text.text = "날씨와 어울리는 주류를 추천해드릴게요."
        
        return text
        
    }()
    
    lazy var buttonArry: UIButton = {
        let button = UIButton()
        button.setImage(buttonImageArray[0], for: .normal)
        //button.setImage(buttonSelectedImageArray[0], for: .highlighted)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var nextButton = makeNextButton(buttonTitle: "다음")
    lazy var skipButton = makeSkipButton()
    lazy var buttonArray = makeButtonArray(buttonImageArray: buttonImageArray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // navigation
        title = "주류추천"
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backButton
        
        setAddSubViews()
        makeConstraints()
    }
    
    
    // MARK: - Navigaiton
    @objc func backButtonPressed() {
        // Handle the back button press (e.g., pop view controller)
        navigationController?.popViewController(animated: true)
    }
    @objc func nextButtonTapped(_ sender: UIButton) {
        let nextViewController = LoadingRecommendDrinkViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // MARK: - Actions
    @objc func buttonTapped(_ sender: UIButton){
        let index = sender.tag
        print(index)
        if buttonSelected {
            buttonSelected = false
            sender.setImage(buttonImageArray[index], for: .normal)
        } else {
            buttonSelected = true
            sender.setImage(buttonSelectedImageArray[index], for: .normal)
        }
    }
    
    
    // MARK: - Constraints
    
    func setAddSubViews() {
        view.addSubview(progressBar)
        view.addSubview(guideText)
        view.addSubview(subGuideText)
        for i in 0..<buttonArray.count {
            view.addSubview(buttonArray[i])
        }
        view.addSubview(skipButton)
        view.addSubview(nextButton)
    }
    
    func makeConstraints() {
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(2)
            progressBar.progress = 1
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
        
        // Button Array
         let viewFrame: CGFloat = self.view.frame.width - 32
         var buttonFrameWidth = viewFrame
         var heightMargin = 45
        
        for i in 0..<buttonArray.count {
            let button = buttonArray[i]
            let buttonWidth = button.frame.width
            let widthMargin = buttonImageArray[i].size.width + 8
            let buttonHeight: Int = Int(buttonImageArray[i].size.height + 8)
            
            button.snp.makeConstraints { make in
                if (buttonFrameWidth - widthMargin) >= 0 {
                    make.leading.equalToSuperview().offset(20 + viewFrame - buttonFrameWidth)
                    make.top.equalTo(subGuideText.snp.bottom).offset(heightMargin)
                    make.size.equalTo(buttonImageArray[i].size) // 버튼의 크기 설정
                } else {
                    buttonFrameWidth = viewFrame
                    heightMargin += buttonHeight
                    make.leading.equalToSuperview().offset(20 + viewFrame - buttonFrameWidth)
                    make.top.equalTo(subGuideText.snp.bottom).offset(heightMargin)
                    make.size.equalTo(buttonImageArray[i].size) // 버튼의 크기 설정
                }
                buttonFrameWidth -= widthMargin
            }
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
        
        skipButton.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            skipButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        }
    }
}
