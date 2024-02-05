//
//  SelectDrinkCapacityViewController.swift
//  DrinkingGourmet
//
//  Created by 김희은 on 1/13/24.
//

import UIKit

class SelectDrinkCapacityViewController: UIViewController {
    
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
    
    lazy var temporaryButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("다음", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .black
        
        btn.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        return btn
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setAddSubViews()
        makeConstraints()
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        let nextViewController = SelectDrinkFrequencyViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func setAddSubViews() {
        view.addSubview(progressBar)
        view.addSubview(guideText)
        view.addSubview(subGuideText)
        view.addSubview(temporaryButton)
    }
    
    func makeConstraints() {
        
        progressBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
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
        
        temporaryButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.height.equalTo(100)
        }
    }

}
