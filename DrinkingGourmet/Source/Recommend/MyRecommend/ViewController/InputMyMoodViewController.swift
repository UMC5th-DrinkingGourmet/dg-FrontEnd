//
//  InputMyMoodViewController.swift
//  DrinkingGourmet
//
//  Created by 김희은 on 1/15/24.
//

import UIKit

class InputMyMoodViewController: UIViewController {
    private var isTextInput = false
    
    private let placeHolderText = "기분을 적어주세요"
    private let placeHolderColor = UIColor.baseColor.base07
    private let maxCount = 130
    
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
        text.text = "에피소드를 곁들여주세요."
        return text
        
    }()
    
    lazy var myMoodInputView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.backgroundColor = view.backgroundColor
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.text = placeHolderText
        textView.textColor = placeHolderColor
        textView.delegate = self
        
        //수정 제안 제거
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        return textView
    }()
    
    lazy var textViewBottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.baseColor.base07
        return line
    }()
    
    lazy var textViewCharCount: UILabel = {
        let label = UILabel()
        label.text = " "
        label.backgroundColor = .systemBackground
        label.textColor = UIColor.baseColor.base06
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    lazy var nextButton = makeNextButton(buttonTitle: "다음", buttonSelectability: isTextInput)
    lazy var skipButton = makeSkipButton()
    
    let firstRecommendParam = RecommendsRequestParameters.shared

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.baseColor.base10
        myMoodInputView.delegate = self
        myMoodInputView.translatesAutoresizingMaskIntoConstraints = false

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
    
    @objc func skipButtonTapped(_ sender: UIButton) {
        
        let nextViewController = SelectWeatherViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
        let recommendParam = RecommendsRequestParameters.shared
        recommendParam.feeling += " "
        //print(recommendParam.feeling)
    }
    @objc func nextButtonTapped(_ sender: UIButton) {
        
        if isTextInput {
            let recommendParam = RecommendsRequestParameters.shared
            recommendParam.feeling = updateInputMyMood()
            //logic 상 문제 발생.
            //print(recommendParam.feeling)
            
            let nextViewController = SelectWeatherViewController()
            navigationController?.pushViewController(nextViewController, animated: true)
        } else {
            return
        }
    }
    
    // MARK: - Actions
    func updateNextButtonSelectableColor(_ button: UIButton) {
        button.backgroundColor = UIColor.baseColor.base01
        isTextInput = true
    }
    func updateNextButtonColor(_ button: UIButton) {
        button.backgroundColor = UIColor.baseColor.base06
        isTextInput = false
    }
    
    func updateInputMyMood() -> String {
        // 이 부분에 myMoodInputView.text를 mood에 저장하고 return 하
        if let mood = myMoodInputView.text {
            return mood
        }
        else {
            return ""
        }
    }
    
    // MARK: - Constraints
    func setAddSubViews() {
        view.addSubview(progressBar)
        view.addSubview(guideText)
        view.addSubview(subGuideText)
        view.addSubview(myMoodInputView)
        view.addSubview(textViewBottomLine)
        view.addSubview(textViewCharCount)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
    }
    
    func makeConstraints() {
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(2)
            progressBar.progress = 0.8
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
        
        myMoodInputView.snp.makeConstraints { make in
            make.top.equalTo(subGuideText.snp.bottom).offset(47)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        textViewBottomLine.snp.makeConstraints { make in
            make.top.equalTo(myMoodInputView.snp.bottom)
            make.leading.equalTo(myMoodInputView)
            make.trailing.equalTo(myMoodInputView)
            make.height.equalTo(1)
        }
        
        textViewCharCount.snp.makeConstraints { make in
            make.top.equalTo(textViewBottomLine.snp.bottom).offset(8)
            make.trailing.equalTo(textViewBottomLine)
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


// MARK:  - TextViewDelegate
extension InputMyMoodViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == UIColor.baseColor.base07 else { return }
        if textView.text == placeHolderText && textView.textColor == placeHolderColor {
            textView.text = ""
            textView.textColor = UIColor.baseColor.base01
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = placeHolderText
            textView.textColor = placeHolderColor
        }
        if textView.text.count >= maxCount {
            textView.text.removeLast()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > maxCount {
            textView.text = String(textView.text.prefix(maxCount))
        }
        
        let charCount = textView.text.count
        
        // UI Controll
        if textView.text == "" {
            textViewBottomLine.backgroundColor = UIColor.baseColor.base07
            updateNextButtonColor(nextButton)
        } else {
            textViewBottomLine.backgroundColor = UIColor.baseColor.base01
            updateNextButtonSelectableColor(nextButton)
        }
        textViewCharCount.text = "\(charCount)/130"
    }
}

