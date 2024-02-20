//
//  SelectMyMoodViewController.swift
//  DrinkingGourmet
//
//  Created by 김희은 on 1/15/24.
//

import UIKit

class SelectMyMoodViewController: UIViewController {
    
    private var isSelectedButton = false
    private let resource: SelectMyMoodResource = SelectMyMoodResource()
    private var buttonTitleArray: [String] {
        return resource.moodButtonTitleArray()
    }
    
    lazy var progressBar: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.clipsToBounds = true
        progressBar.layer.cornerRadius = 5
        progressBar.tintColor = UIColor.baseColor.base01
        progressBar.trackTintColor = UIColor.baseColor.base08
        return progressBar
    }()
    
    lazy var guideText: UILabel = {
        let text = UILabel()
        text.textColor = UIColor.baseColor.base01
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 24)
        text.text = "기분은 어떠신가요?"
        return text
    }()
    
    lazy var subGuideText: UILabel = {
        let text = UILabel()
        text.textColor = UIColor.baseColor.base05
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 14)
        text.text = "기분에 어울리는 주류를 추천해드릴게요."
        return text
    }()
    
    private var selectedButtonCount: Int = 0
    private var isButtonSelected: [Bool] = []
    
    private var selectedButtonTitles: String = ""
    
    lazy var nextButton = makeNextButton(buttonTitle: "다음", buttonSelectability: isSelectedButton)
    lazy var skipButton = makeSkipButton()
    lazy var buttonArray = makeRecommendButtonArray(buttonArray: buttonTitleArray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.baseColor.base10

        // navigation bar
        title = "주류추천"
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backButton
        
        setAddSubViews()
        makeConstraints()
    }
    
    // MARK: - Navigation
    @objc func backButtonPressed() {
        // Handle the back button press (e.g., pop view controller)
        navigationController?.popViewController(animated: true)
    }
    @objc func skipButtonTapped(_ sender: UIButton) {
        let recommendParam = recommendsRequestParameters.shared
        recommendParam.feeling = ""
        
        let nextViewController = InputMyMoodViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    @objc func nextButtonTapped(_ sender: UIButton) {
        if isSelectedButton {
            let recommendParam = recommendsRequestParameters.shared
            recommendParam.feeling = updateSelectedButtonTitles()
            
            let nextViewController = InputMyMoodViewController()
            navigationController?.pushViewController(nextViewController, animated: true)
        } else {
            return
        }
    }
    
    
    // MARK: - Actions
    private func updateNextButtonSelectableColor(_ button: UIButton) {
        button.backgroundColor = UIColor.baseColor.base01
        isSelectedButton = true
    }
    private func updateNextButtonColor(_ button: UIButton) {
        button.backgroundColor = UIColor.baseColor.base06
        isSelectedButton = false
    }
    
    private func updateSelectedButtonTitles() -> String {
        var selectedButtonTitles = ""
        for index in 0..<isButtonSelected.count {
            if isButtonSelected[index] {
                selectedButtonTitles += "\(buttonTitleArray[index]), "
            }
        }
        return selectedButtonTitles
    }
    
    @objc func makeRecommendButtonArray(buttonArray: [String]) -> [UIButton] {
        var buttons: [UIButton] = []
        
        for (index, _) in buttonArray.enumerated() {
            let button = customizedRecommendButton(title: buttonArray[index], foregroundColor: .baseColor.base03, backgroundColor: .baseColor.base10, borderColor: .baseColor.base08)
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            
            isButtonSelected.append(false)
        }
        
        return buttons
    }
    
    private func updateButtonSelectedColor(_ button: UIButton) {
        button.setTitleColor(UIColor.customColor.customOrange, for: .normal)
        button.backgroundColor = UIColor.customColor.customOrange.withAlphaComponent(0.05)
        button.layer.borderColor = UIColor.customColor.customOrange.cgColor
    }
    
    private func updateButtonColor(_ button: UIButton) {
        button.setTitleColor(UIColor.baseColor.base03, for: .normal)
        button.backgroundColor = UIColor.baseColor.base10
        button.layer.borderColor = UIColor.baseColor.base08.cgColor
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let index = sender.tag
        
        if isButtonSelected[index] {
            isButtonSelected[index] = false
            if !(isButtonSelected.contains(true)) {
                updateNextButtonColor(nextButton)
            }
            updateButtonColor(sender)
            
        } else {
            updateNextButtonSelectableColor(nextButton)
            isButtonSelected[index] = true
            updateButtonSelectedColor(sender)
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
            progressBar.progress = 0.6
        }
        
        guideText.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(23)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(36)
        }
        
        subGuideText.snp.makeConstraints { make in
            make.top.equalTo(guideText.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(21)
        }
        
        // Button Array
        let viewFrame: CGFloat = self.view.frame.width - 40
        var buttonFrameWidth = viewFrame
        let defaultMargin: CGFloat = 8
        var topMargin: CGFloat = 45
    
        for i in 0..<buttonArray.count {
            let button = buttonArray[i]
            let buttonWidth = CGFloat(button.frame.width)
            let buttonHeight = CGFloat(button.frame.height)
            buttonArray[i].snp.makeConstraints { make in
                
                if buttonFrameWidth - buttonWidth >= 0 {
                    make.leading.equalTo(subGuideText).offset(viewFrame - buttonFrameWidth)
                    make.top.equalTo(subGuideText.snp.bottom).offset(topMargin)
                }
                else {
                    buttonFrameWidth = viewFrame
                    topMargin += (buttonHeight + defaultMargin)
                    make.leading.equalToSuperview().offset(20 + viewFrame - buttonFrameWidth)
                    make.top.equalTo(subGuideText.snp.bottom).offset(topMargin)
                }
                
                make.width.equalTo(buttonArray[i].frame.width)
                make.height.equalTo(buttonHeight)
            }
            buttonFrameWidth -= (buttonWidth + defaultMargin)
        }
        
        skipButton.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            skipButton.addTarget(self, action: #selector(skipButtonTapped(_:)), for: .touchUpInside)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        }
    }
}
