//
//  SelectDrunkDegreeViewController.swift
//  DrinkingGourmet
//
//  Created by 김희은 on 1/15/24.
//

import UIKit

class SelectDrunkDegreeViewController: UIViewController {
    
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
        text.text = "어느 정도 취하고 싶으신가요?"
        return text
    }()
    
    lazy var subGuideText: UILabel = {
        let text = UILabel()
        text.textColor = UIColor.baseColor.base05
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 14)
        text.text = "1에서 5까지의 수치로 표현해주세요"
        return text
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    private let sliderView: SliderView = .init(maxValue: 5)
    
    lazy var nextButton = makeNextButton(buttonTitle: "다음", buttonSelectability: true)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.baseColor.base10
        sliderView.delegate = self
        
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
        let nextViewController = InputMyFoodViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    // MARK: - Constraints
    func setAddSubViews() {
        view.addSubview(progressBar)
        view.addSubview(guideText)
        view.addSubview(subGuideText)
        view.addSubview(sliderView)
        view.addSubview(nextButton)
    }
    
    func makeConstraints() {
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(2)
            progressBar.progress = 0.2
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
        
        sliderView.snp.makeConstraints { make in
            make.top.equalTo(subGuideText.snp.bottom).offset(70)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        }
    }
}

// MARK: - SliderViewDelegate
extension SelectDrunkDegreeViewController: SliderViewDelegate {
    func sliderView(_ sender: SliderView, changedValue value: Int) {
        mainLabel.text = "\(value)"
    }
}
