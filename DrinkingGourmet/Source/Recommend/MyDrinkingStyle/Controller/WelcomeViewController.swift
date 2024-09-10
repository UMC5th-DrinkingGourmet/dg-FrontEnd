//
//  WelcomeViewController.swift
//  DrinkingGourmet
//
//  Created by 김희은 on 1/10/24.
//

import UIKit

class WelcomeViewController: UIViewController {

    lazy var welcomeImageView: UIImageView = { // 수정 요망
        let imgView = UIImageView()
        imgView.image = UIImage(named: "img_welcome")!
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    lazy var guideText: UILabel = {
        let text = UILabel()
        text.textColor = UIColor.baseColor.base01
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 24)
        text.textAlignment = .center
        text.text = "\(UserDefaultManager.shared.userNickname)님,\n환영합니다"
        return text
    }()
    
    lazy var subGuideText: UILabel = {
        let text = UILabel()
        text.textColor = UIColor.baseColor.base05
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 14)
        text.text = "회원가입이 완료되었습니다"
        return text
    }()
    
    lazy var nextButton = makeNextButton(buttonTitle: "시작하기", buttonSelectability: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.baseColor.base10
        
        //navigation
        title = "주류추천"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        setAddSubViews()
        makeConstraints()
    }
    
    // MARK: - Navigation
    @objc func backButtonPressed() {
        // Handle the back button press (e.g., pop view controller)
        navigationController?.popViewController(animated: true)
    }
    @objc func nextButtonTapped(_ sender: UIButton) {
        let nextViewController = GetUserInfoViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    func setAddSubViews() {
        view.addSubview(welcomeImageView)
        view.addSubview(nextButton)
        view.addSubview(subGuideText)
        view.addSubview(guideText)
    }
    
    func makeConstraints() {
        welcomeImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(123)
            make.centerX.equalTo(self.view)
            make.height.equalToSuperview().multipliedBy(0.253)
        }

        guideText.snp.makeConstraints { make in
            make.top.equalTo(subGuideText.snp.bottom).offset(16)
            make.bottom.equalTo(nextButton.snp.top).offset(-89)
            make.centerX.equalTo(self.view)
            make.height.equalTo(72)
        }
        subGuideText.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.height.equalTo(42)
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
