//
//  InputMoodeViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/4/24.
//

import UIKit

final class InputMoodeViewController: UIViewController {
    // MARK: - Properties
    private let inputMoodView = InputFoodView()
    var previousMood: String = "" // 이전 뷰컨에서 전달받은 상태를 저장
    
    // MARK: - View 설정
    override func loadView() {
        view = inputMoodView
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepare()
        setupNaviBar()
        setupButton()
        setupTextField()
    }
    
    private func prepare() {
        inputMoodView.progressBar.progress = 0.8
        inputMoodView.titleLabel.text = "기분은 어떠신가요?"
        inputMoodView.descriptionLabel.text = "에피소드를 곁들여주세요."
        inputMoodView.textField.placeholder = "기분을 적어주세요"
        inputMoodView.passButton.isHidden = false
    }
    
    private func setupNaviBar() {
        title = "주류 추천"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupButton() {
        inputMoodView.passButton.addTarget(self, action: #selector(passButtonTapped), for: .touchUpInside)
        inputMoodView.nextButton.button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    private func setupTextField() {
        inputMoodView.textField.delegate = self
    }
}

// MARK: - Actions
extension InputMoodeViewController {
    private func navigateToNextViewController() {
        let VC = SelectWeatherViewController()
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc private func passButtonTapped() {
        RecommendRequestDTO.shared.mood = previousMood // 이전 상태로 되돌리기
        navigateToNextViewController()
    }
    
    @objc private func nextButtonTapped() {
        guard let moodText = inputMoodView.textField.text, !moodText.isEmpty else { return }
        RecommendRequestDTO.shared.mood.append(", \(moodText)")
        navigateToNextViewController()
    }
}

// MARK: - UITextFieldDelegate
extension InputMoodeViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        inputMoodView.lineView.backgroundColor = .customOrange
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        inputMoodView.lineView.backgroundColor = .base0700
        
        if let text = textField.text, !text.isEmpty {
            inputMoodView.nextButton.button.isEnabled = true
            inputMoodView.nextButton.backgroundColor = .base0100
        } else {
            inputMoodView.nextButton.button.isEnabled = false
            inputMoodView.nextButton.backgroundColor = .base0500
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
