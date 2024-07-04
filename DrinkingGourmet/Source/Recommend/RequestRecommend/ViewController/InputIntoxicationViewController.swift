//
//  InputIntoxicationViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/4/24.
//

import UIKit

final class InputIntoxicationViewController: UIViewController {
    // MARK: - Properties
    private let inputIntoxicationview = InputIntoxicationview()
    
    // MARK: - View 설정
    override func loadView() {
        view = inputIntoxicationview
    }
    
    // MARK: - ViewDidLodad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNaviBar()
        setupButton()
    }
    
    private func setupNaviBar() {
        title = "주류 추천"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupButton() {
        inputIntoxicationview.slider.addTarget(self, action: #selector(changeSlider), for: .valueChanged)
        inputIntoxicationview.nextButton.button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension InputIntoxicationViewController {
    @objc private func changeSlider() {
        inputIntoxicationview.slider.value = roundf(inputIntoxicationview.slider.value)
        print(inputIntoxicationview.slider.value)
        
        inputIntoxicationview.nextButton.button.isEnabled = true
        inputIntoxicationview.nextButton.backgroundColor = .base0100
    }
    
    @objc private func nextButtonTapped() {
        RecommendRequestDTO.shared.desireLevel = Int(inputIntoxicationview.slider.value)
        let VC = InputFoodViewController()
        navigationController?.pushViewController(VC, animated: true)
    }
}
