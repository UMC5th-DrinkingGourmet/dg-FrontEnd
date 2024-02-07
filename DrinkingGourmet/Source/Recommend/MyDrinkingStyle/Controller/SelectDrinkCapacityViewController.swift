//
//  SelectDrinkCapacityViewController.swift
//  DrinkingGourmet
//
//  Created by 김희은 on 1/13/24.
//

import UIKit

class SelectDrinkCapacityViewController: UIViewController {
    
    private let resource: SelectDrinkCapacityResource = SelectDrinkCapacityResource()
    var buttonImageArray: [UIImage] {
        return resource.capacityButtonImageArray()
    }
    var buttonSelectedImageArray: [UIImage] {
        return resource.capacityButtonSelectedImageArray()
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
        "주량을 선택해주세요."
        return text
    }()
    
    
    lazy var subGuideText: UILabel = {
        let text = UILabel()
        text.textColor = .lightGray
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 14)
        text.text = "00님과 어울리는 주류를 추천해드릴게요."
        
        return text
        
    }()
    
    private var buttonSelected = false
    lazy var nextButton = makeNextButton(buttonTitle: "다음")
    lazy var skipButton = makeSkipButton()
    lazy var buttonArray = makeButtonArray(buttonImageArray: buttonImageArray)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
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
        let nextViewController = SelectDrinkFrequencyViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // MARK: - Actions
    @objc func buttonTapped(_ sender: UIButton){
        let index = sender.tag
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
        view.addSubview(nextButton)
    }
    
    func makeConstraints() {
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(2)
            progressBar.progress = 0.75
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
            let buttonWidth = buttonImageArray[i].size.width
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
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.height.equalTo(100)
            nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        }
    }

}
