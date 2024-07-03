//
//  InputFoodViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/4/24.
//

import UIKit

final class InputFoodViewController: UIViewController {
    // MARK: - Properties
    private let inputFoodView = InputFoodView()
    
    // MARK: - View 설정
    override func loadView() {
        view = inputFoodView
    }
    
    // MARK: - ViewDidLodad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNaviBar()
        setupButton()
        setupTextField()
    }
    
    private func setupNaviBar() {
        title = "주류 추천"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupButton() {
        inputFoodView.nextButton.button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    private func setupTextField() {
        inputFoodView.textField.delegate = self
    }
}

// MARK: - Actions
extension InputFoodViewController {
    @objc private func nextButtonTapped() {
        if let foodName = inputFoodView.textField.text {
            RecommendRequestDTO.shared.foodName = foodName
        }
        
//        let VC = SelectMoodViewController()
//        navigationController?.pushViewController(VC, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension InputFoodViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        inputFoodView.lineView.backgroundColor = .customOrange
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        inputFoodView.lineView.backgroundColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1)
        
        if let text = textField.text, !text.isEmpty {
            inputFoodView.nextButton.button.isEnabled = true
            inputFoodView.nextButton.backgroundColor = .black
        } else {
            inputFoodView.nextButton.button.isEnabled = false
            inputFoodView.nextButton.backgroundColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
