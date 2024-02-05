//
//  UserDrinkingTasteViewController.swift
//  DrinkingGourmet
//
//  Created by 김희은 on 1/10/24.
//

import UIKit

class UserDrinkingTasteViewController: UIViewController {

    lazy var welcomeImageView: UIImageView = { // 수정 요망
        let imgView = UIImageView()
        imgView.image = UIImage(named: "img_welcome")!
        return imgView
    }()
    
    lazy var guideText: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 24)
        text.textAlignment = .center
        text.text =
        "000님,\n환영합니다"
        return text
    }()
    
    lazy var subGuideText: UILabel = {
        let text = UILabel()
        text.textColor = .lightGray
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 14)
        text.text = "회원가입이 완료되었습니다"
        
        return text
        
    }()
    
    lazy var nextButton = makeNextButton(buttonTitle: "시작하기")
    
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
            make.top.equalTo(view.safeAreaLayoutGuide).offset(121)
            make.centerX.equalTo(self.view)
        }
        guideText.snp.makeConstraints { make in
            //make.top.equalToSuperview().offset(43)
            make.bottom.equalTo(nextButton.snp.top).offset(-89)
            make.centerX.equalTo(self.view)
            make.height.equalTo(72)
        }
        subGuideText.snp.makeConstraints { make in
            make.bottom.equalTo(guideText.snp.top).offset(-16)
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
