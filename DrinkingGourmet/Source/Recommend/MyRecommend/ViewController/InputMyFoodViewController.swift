//
//  InputMyFoodViewController.swift
//  DrinkingGourmet
//
//  Created by 김희은 on 1/13/24.
//

import UIKit

class InputMyFoodViewController: UIViewController {
    private var isTextInput = false
    
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
        text.text = "드실 음식을 입력해주세요."
        return text
    }()
    
    lazy var subGuideText: UILabel = {
        let text = UILabel()
        text.textColor = UIColor.baseColor.base05
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 14)
        text.text = "오늘은 어떤 음식과 함께 하시나요?"
        return text
    }()
    
    var foodSearchField: UITextField = {
        let textField = UITextField()
        
        textField.placeHolder(string: "치킨", color: UIColor.baseColor.base07)
        textField.text = ""
        textField.textColor = UIColor.baseColor.base01
        textField.font = UIFont.systemFont(ofSize: 20)
        
        //수정 제안 제거
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        
        return textField
    }()
    
    private lazy var clearButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "x.circle.fill"), for: .normal)
        btn.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
        btn.tintColor = UIColor.baseColor.base07
        
        return btn
    }()
    
    
    private var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.baseColor.base07
        return lineView
    }()

    
    lazy var nextButton = makeNextButton(buttonTitle: "다음", buttonSelectability: isTextInput)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.baseColor.base10
        
        foodSearchField.delegate = self
        
        // navigation
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
        if isTextInput {
            let nextViewController = SelectMyMoodViewController()
            navigationController?.pushViewController(nextViewController, animated: true)
        } else {
            return
        }
    }
    
    // MARK: - Actions
    func updateNextButtonSelectableColor(_ button: UIButton) {
        button.backgroundColor = UIColor.baseColor.base01
    }
    func updateNextButtonColor(_ button: UIButton) {
        button.backgroundColor = UIColor.baseColor.base06
    }
    
    @objc private func clearTextField(_ sender: UIButton) {
        self.foodSearchField.text = ""
        isTextInput = false
        updateLineViewColor()
        updateNextButtonColor(nextButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Search Field UI Custom
    private func updateLineViewColor() {
        if isTextInput {
            lineView.backgroundColor = UIColor.baseColor.base01
        }
        else {
            lineView.backgroundColor = UIColor.baseColor.base07
        }
    }
    
    // MARK: - Constraints
    func setAddSubViews() {
        view.addSubview(progressBar)
        view.addSubview(guideText)
        view.addSubview(subGuideText)
        view.addSubview(foodSearchField)
        view.addSubview(clearButton)
        view.addSubview(lineView)
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
        
        foodSearchField.snp.makeConstraints { make in
            make.top.equalTo(subGuideText.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-44)
            make.height.equalTo(44)
        }
        clearButton.snp.makeConstraints { make in
            make.leading.equalTo(foodSearchField.snp.trailing)
            make.centerY.equalTo(foodSearchField)
            make.height.equalTo(24)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(foodSearchField.snp.bottom)
            make.leading.equalTo(foodSearchField.snp.leading)
            make.trailing.equalTo(clearButton.snp.trailing)
            make.height.equalTo(1)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        }
    }
}

// MARK: - TextFieldDelegate
extension InputMyFoodViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text?.count != nil {
            isTextInput = true
            updateLineViewColor()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            isTextInput = false
            updateNextButtonColor(nextButton)
        }
        else {
            isTextInput = true
            updateNextButtonSelectableColor(nextButton)
        }
        updateLineViewColor()
    }
}
