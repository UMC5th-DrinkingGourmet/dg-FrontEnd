//
//  InputIntoxicationViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/4/24.
//

import UIKit

final class InputIntoxicationViewController: UIViewController {
    // MARK: - Properties
    private let inputIntoxicationView = InputIntoxicationView()
    
    // MARK: - View 설정
    override func loadView() {
        view = inputIntoxicationView
    }
    
    // MARK: - ViewDidLodad
    override func viewDidLoad() {
        super.viewDidLoad()
        inputIntoxicationView.nextButton.button.isEnabled = true
        inputIntoxicationView.nextButton.backgroundColor = .base0100
        
        setupNaviBar()
        setupButton()
    }
    
    private func setupNaviBar() {
        title = "주류 추천"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupButton() {
        inputIntoxicationView.slider.addTarget(self, action: #selector(changeSlider), for: .valueChanged)
        inputIntoxicationView.nextButton.button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension InputIntoxicationViewController {
    @objc private func changeSlider() {
        inputIntoxicationView.slider.value = roundf(inputIntoxicationView.slider.value)
    }
    
    @objc private func nextButtonTapped() {
        RecommendRequestDTO.shared.desireLevel = Int(inputIntoxicationView.slider.value)
        let VC = InputFoodViewController()
        navigationController?.pushViewController(VC, animated: true)
    }
}
