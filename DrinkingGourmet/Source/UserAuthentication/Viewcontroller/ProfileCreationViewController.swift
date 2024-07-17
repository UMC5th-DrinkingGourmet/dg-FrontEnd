//
//  ProfileCreationViewController.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 2/2/24.
//

import UIKit
import SnapKit
import Then

class ProfileCreationViewController: UIViewController {
    
    var nickNameisgood = false  // 닉네임 제대로 입력 했는지
    
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.keyboardDismissMode = .onDrag
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let titleLabel = UILabel().then {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 12 // 줄 사이 간격 설정
        
        let attrString = NSMutableAttributedString(string: "음주미식회 이용을 위해\n정보를 입력해주세요.")
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        
        $0.attributedText = attrString
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    lazy var inputNameView = InputTextFieldView(frame: .zero)
    
    lazy var inputBirthView = InputTextFieldView(frame: .zero)
    
    lazy var inputPhoneNumberView = InputTextFieldView(frame: .zero)
    
    lazy var inputNicknameView = InputTextFieldView(frame: .zero)
    
    private let stateLabel = UILabel().then {
        $0.text = ""
        $0.textColor = .red
        $0.font = .systemFont(ofSize: 13)
        $0.textAlignment = .left
    }
    
    private let genderLabel = UILabel().then {
        $0.text = "성별"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        $0.textAlignment = .left
    }
    
    lazy var buttonDictionary: [UIButton: String] = [
        maleBtn: "  남성  ",
        femaleBtn: "  여성  ",
        noneBtn: "  선택 안함  "
    ]
    
    private let maleBtn = UIButton().then {
        $0.genderBtnConfig(title: "  남성  ", font: .systemFont(ofSize: 16), foregroundColor: .darkGray, borderColor: .checkmarkGray)
    }
    
    private let femaleBtn = UIButton().then {
        $0.genderBtnConfig(title: "  여성  ", font: .systemFont(ofSize: 16), foregroundColor: .darkGray, borderColor: .checkmarkGray)
    }
    
    private let noneBtn = UIButton().then {
        $0.genderBtnConfig(title: "  선택 안함  ", font: .systemFont(ofSize: 16), foregroundColor: .darkGray, borderColor: .checkmarkGray)
    }
    
    lazy var confirmBtn = UIButton().then {
        $0.backgroundColor = .black
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configHierarchy()
        layout()
        configView()
        configNav()
        setupKeyboardNotifications()
    }
}

extension ProfileCreationViewController {
    func configHierarchy() {
        view.addSubviews([
            scrollView,
            confirmBtn
        ])
        
        scrollView.addSubviews([
            contentView
        ])
        
        contentView.addSubviews([
            titleLabel,
            inputNameView,
            inputBirthView,
            inputPhoneNumberView,
            genderLabel,
            maleBtn,
            femaleBtn,
            noneBtn,
            inputNicknameView,
            stateLabel
        ])
    }
    
    func layout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.equalTo(inputNicknameView.snp.bottom).offset(150)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(62)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        inputNameView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(72)
            $0.top.equalTo(titleLabel.snp.bottom).offset(70)
        }
        
        inputBirthView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(72)
            $0.top.equalTo(inputNameView.snp.bottom).offset(56)
        }
        
        inputPhoneNumberView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(72)
            $0.top.equalTo(inputBirthView.snp.bottom).offset(56)
        }
        
        genderLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(inputPhoneNumberView.snp.bottom).offset(56)
            $0.height.equalTo(24)
        }
        
        maleBtn.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(genderLabel.snp.bottom).offset(20)
            $0.height.equalTo(40)
        }
        
        femaleBtn.snp.makeConstraints {
            $0.leading.equalTo(maleBtn.snp.trailing).offset(8)
            $0.top.equalTo(genderLabel.snp.bottom).offset(20)
            $0.height.equalTo(40)
        }
        
        noneBtn.snp.makeConstraints {
            $0.leading.equalTo(femaleBtn.snp.trailing).offset(8)
            $0.top.equalTo(genderLabel.snp.bottom).offset(20)
            $0.height.equalTo(40)
        }
        
        inputNicknameView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(72)
            $0.top.equalTo(noneBtn.snp.bottom).offset(56)
        }
        
        stateLabel.snp.makeConstraints {
            $0.top.equalTo(inputNicknameView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(20)
        }
        
        confirmBtn.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(90)
        }
    }
    
    func configView() {
        inputNameView.title = "이름"
        inputBirthView.title = "생년월일"
        inputPhoneNumberView.title = "전화번호"
        inputNicknameView.title = "닉네임"
        
        inputNameView.textfieldText = UserDefaultManager.shared.userName
        inputBirthView.textfieldText = UserDefaultManager.shared.userBirth
        inputPhoneNumberView.textfieldText = UserDefaultManager.shared.userPhoneNumber
        inputNicknameView.textfieldText = UserDefaultManager.shared.userNickname
        
        inputNicknameView.placeholder = "닉네임을 입력해주세요."
        
        for (button, _) in buttonDictionary {
            button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        }
        
        let gender = UserDefaultManager.shared.userGender
        
        if gender == "male" {
            maleBtn.isSelected = true
            updateButtonColor(maleBtn, "  남성  ")
        } else if gender == "female" {
            femaleBtn.isSelected = true
            updateButtonColor(femaleBtn, "  여성  ")
        } else {
            noneBtn.isSelected = true
            updateButtonColor(noneBtn, "  선택 안함  ")
        }
        
        self.confirmBtn.addTarget(self, action: #selector(confirmBtnClicked), for: .touchUpInside)
        
        inputNicknameView.onTextChanged = { [weak self] text in
            self?.handleNicknameTextChanged(text)
        }
    }
    
    func handleNicknameTextChanged(_ text: String) {
        let specialChar = ["@", "#", "$", "%"]
        if text.count < 2 || text.count > 9 || text.isEmpty {
            stateLabel.text = "2글자 이상 10글자 미만으로 설정해주세요"
            confirmBtn.isEnabled = false
            nickNameisgood = false
        } else if specialChar.contains(where: text.contains) {
            stateLabel.text = "닉네임에 @, #, $, %는 포함할 수 없어요"
            confirmBtn.isEnabled = false
            nickNameisgood = false
        } else if text.contains(where: { $0.isNumber }) {
            stateLabel.text = "닉네임에 숫자는 포함할 수 없어요"
            confirmBtn.isEnabled = false
            nickNameisgood = false
        } else if text == "" {
            stateLabel.text = "닉네임을 반드시 입력해야 합니다"
            confirmBtn.isEnabled = false
            nickNameisgood = false
        } else {
            stateLabel.text = "사용할 수 있는 닉네임이에요"
            confirmBtn.isEnabled = true
            nickNameisgood = true
        }
    }
    
    func updateButtonColor(_ button: UIButton, _ title: String) {
        if button.isSelected {
            button.genderBtnConfig(title: title, font: .systemFont(ofSize: 16), foregroundColor: .customOrange, borderColor: .customOrange)
        } else {
            button.genderBtnConfig(title: title, font: .systemFont(ofSize: 16), foregroundColor: .darkGray, borderColor: .checkmarkGray)
        }
    }

    @objc func buttonClicked(_ sender: UIButton) {
        for (button, title) in buttonDictionary {
            button.isSelected = false
            updateButtonColor(button, title)
        }
        sender.isSelected.toggle()
        if let title = sender.titleLabel?.text {
            updateButtonColor(sender, title)
        }
    }
    
    func postUserInfo() {
        let userInfo = UserInfoDTO(
            name: inputNameView.textField.text ?? "",
            profileImage: UserDefaultManager.shared.userProfileImg,
            email: UserDefaultManager.shared.email,
            nickName: inputNicknameView.textField.text ?? "",
            birthDate: inputBirthView.textField.text ?? "",
            phoneNumber: inputPhoneNumberView.textField.text ?? "",
            gender: determineSelectedGender(),
            provider: UserDefaultManager.shared.provider,
            providerId: UserDefaultManager.shared.providerId
        )
                
        SignUpService.shared.sendUserInfo(userInfo) {_ in 
            let tabbarVC = TabBarViewController()
            self.navigationController?.pushViewController(tabbarVC, animated: true)
        }
    }
    
    func determineSelectedGender() -> String {
        if maleBtn.isSelected {
            return "male"
        } else if femaleBtn.isSelected {
            return "female"
        } else {
            return "none"
        }
    }
    
    @objc func confirmBtnClicked() {
        if (maleBtn.isSelected || femaleBtn.isSelected || noneBtn.isSelected) && confirmBtn.isEnabled == true && nickNameisgood {
            UserDefaultManager.shared.userNickname = inputNicknameView.textField.text ?? "Guest"
            
            postUserInfo()
        } else {
            let alert = UIAlertController(title: "프로필을 제대로 입력해주세요!", message: "프로필을 제대로 입력하지 않으셨습니다.", preferredStyle: .alert)
            
            let btn1 = UIAlertAction(title: "취소", style: .cancel)
            let btn2 = UIAlertAction(title: "확인", style: .default)
            
            alert.addAction(btn1)
            alert.addAction(btn2)
            
            present(alert, animated: true)
        }
    }
    
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(noti: Notification) {
        guard let userInfo = noti.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height
        var contentInset = scrollView.contentInset
        contentInset.bottom = keyboardHeight
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(noti: Notification) {
        var contentInset = scrollView.contentInset
        contentInset.bottom = 0
        scrollView.contentInset = contentInset
    }
    
    func configNav() {
        navigationItem.title = "회원 정보 입력"
        let item = UIBarButtonItem(image: UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal).withTintColor(.black), style: .plain, target: self, action: #selector(backToPrevious))
        navigationItem.leftBarButtonItem = item
    }
    
    @objc func backToPrevious() {
        navigationController?.popViewController(animated: true)
    }

}

extension ProfileCreationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
