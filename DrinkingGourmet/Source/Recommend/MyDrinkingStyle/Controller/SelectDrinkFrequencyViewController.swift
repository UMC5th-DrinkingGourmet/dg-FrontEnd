//
//  SelectDrinkFrequencyViewController.swift
//  DrinkingGourmet
//
//  Created by 김희은 on 1/13/24.
//

import UIKit

class SelectDrinkFrequencyViewController: UIViewController {
    
    private var isSelectedButton =  false
    private let resource: SelectDrinkFrequencyResource = SelectDrinkFrequencyResource()
    var buttonTitleArray: [String] {
        return resource.frequencyButtonTitleArray()
    }
    
    lazy var progressBar: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.clipsToBounds = true
        progressBar.layer.cornerRadius = 5
        progressBar.tintColor = .black
        progressBar.trackTintColor = UIColor.baseColor.base08
        
        return progressBar
    }()
    
    lazy var guideText: UILabel = {
        let text = UILabel()
        text.textColor = UIColor.baseColor.base01
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 24)
        text.text = "음주 빈도를 알려주세요."
        return text
    }()
    
    
    lazy var subGuideText: UILabel = {
        let text = UILabel()
        text.textColor = UIColor.baseColor.base05
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 14)
        text.text = "00님과 어울리는 주류를 추천해드릴게요."
        return text
    }()
    
    private var selectedButtonIndex: Int?
    
    lazy var nextButton = makeNextButton(buttonTitle: "다음", buttonSelectability: isSelectedButton)
    lazy var skipButton = makeSkipButton()
    lazy var buttonArray = makeDrinkingButtonArray(buttonArray: buttonTitleArray)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  UIColor.baseColor.base10
        
        //navigation
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
    @objc func nextButtonTapped(_ sender: UIButton) {
        if isSelectedButton {
            let nextViewController = WelcomeUserViewController()
            navigationController?.pushViewController(nextViewController, animated: true)
        } else {
            return
        }
    }
    
    
    // MARK: - Actions
    func updateNextButtonSelectableColor(_ button: UIButton) {
        button.backgroundColor = UIColor.baseColor.base01
        isSelectedButton = true
    }
    func updateNextButtonColor(_ button: UIButton) {
        button.backgroundColor = UIColor.baseColor.base06
        isSelectedButton = false
    }
    
    func updateButtonSelectedColor(_ button: UIButton) {
        button.setTitleColor(UIColor.customColor.customOrange, for: .normal)
        button.backgroundColor = UIColor.customColor.customOrange.withAlphaComponent(0.05)
        button.layer.borderColor = UIColor.customColor.customOrange.cgColor
    }
    func updateButtonColor(_ button: UIButton) {
        button.setTitleColor(UIColor.baseColor.base03, for: .normal)
        button.backgroundColor = UIColor.baseColor.base10
        button.layer.borderColor = UIColor.baseColor.base08.cgColor
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let index = sender.tag
        
        // 이미 선택된 버튼이 있는 경우
        if let selectedButtonIndex = selectedButtonIndex {
            
            updateButtonSelectedColor(buttonArray[selectedButtonIndex])
            
            if selectedButtonIndex != index {
                self.selectedButtonIndex = index
                updateButtonSelectedColor(sender)
                updateButtonColor(buttonArray[selectedButtonIndex])
                updateNextButtonSelectableColor(nextButton)
            } else {
                updateButtonColor(sender)
                self.selectedButtonIndex = nil
                updateNextButtonColor(nextButton)
            }
        } else {
            // 현재 선택된 버튼이 없는 경우
            self.selectedButtonIndex = index
            updateButtonSelectedColor(sender)
            updateNextButtonSelectableColor(nextButton)
        }
    }
    
    @objc func makeDrinkingButtonArray(buttonArray: [String]) -> [UIButton] {
        var buttons: [UIButton] = []
        
        for (index, _) in buttonArray.enumerated() {
            let button = customizedDrinkingButton(title: buttonArray[index], foregroundColor: .baseColor.base03, backgroundColor: .baseColor.base10, borderColor: .baseColor.base08)
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        return buttons
    }
    
    
    // MARK: - Constraints
    func setAddSubViews() {
        view.addSubview(progressBar)
        view.addSubview(guideText)
        view.addSubview(subGuideText)
        for i in 0..<buttonArray.count {
            view.addSubview(buttonArray[i])
        }
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
            make.height.equalTo(36)
        }
        
        subGuideText.snp.makeConstraints { make in
            make.top.equalTo(guideText.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(21)
        }
        
        var topMargin = 45
        let heightMargin: CGFloat = 8
        let buttonHeight: CGFloat = 56
        for i in 0..<buttonArray.count {
            buttonArray[i].snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().offset(-20)
                make.height.equalTo(buttonHeight)
                make.top.equalTo(subGuideText.snp.bottom).offset(topMargin)
            }
            topMargin += Int((buttonHeight + heightMargin))
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(100)
            nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        }
    }
}
