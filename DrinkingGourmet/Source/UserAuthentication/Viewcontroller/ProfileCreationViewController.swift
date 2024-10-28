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
    var isPatch = false // 내 정보 수정 여부
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
    
    lazy var inputNameView: InputTextFieldView = {
        let view = InputTextFieldView(frame: .zero)
        view.placeholder = "이름"
        return view
    }()

    lazy var inputBirthView: InputTextFieldView = {
        let view = InputTextFieldView(frame: .zero)
        view.inputType = .date
        view.placeholder = "1990-12-01"
        return view
    }()

    lazy var inputPhoneNumberView: InputTextFieldView = {
        let view = InputTextFieldView(frame: .zero)
        view.inputType = .phoneNumber
        view.placeholder = "휴대폰 번호 (-제외)"
        return view
    }()

    lazy var inputNicknameView: InputTextFieldView = {
        let view = InputTextFieldView(frame: .zero)
        view.placeholder = "10자 이내 한글 혹은 영문"
        return view
    }()
    
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
    
    // 다음 버튼
    private let confirmBtn = UIButton().then {
        $0.backgroundColor = .base0500
        $0.isEnabled = false
    }
    
    private let confirmBtnLabel = UILabel().then {
        $0.text = "다음"
        $0.textColor = .base1000
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        if isPatch { // 수정일 때
            DispatchQueue.main.async {
                self.confirmBtnLabel.text = "수정하기"
                self.inputNameView.textField.text = UserDefaultManager.shared.userName
                self.inputBirthView.textField.text = UserDefaultManager.shared.userBirth
                self.inputPhoneNumberView.textField.text = UserDefaultManager.shared.userPhoneNumber
                self.inputNicknameView.textField.text = UserDefaultManager.shared.userNickname
                
                let gender = UserDefaultManager.shared.userGender
                
                if gender == "MALE" {
                    self.maleBtn.isSelected = true
                    self.updateButtonColor(self.maleBtn, "  남성  ")
                } else if gender == "FEMALE" {
                    self.femaleBtn.isSelected = true
                    self.updateButtonColor(self.femaleBtn, "  여성  ")
                } else {
                    self.noneBtn.isSelected = true
                    self.updateButtonColor(self.noneBtn, "  선택 안함  ")
                }
                
                self.nickNameisgood = true
                self.updateConfirmButtonState()
            }
        }
        
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
        
        confirmBtn.addSubview(confirmBtnLabel)
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
        
        confirmBtn.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(89)
        }
        
        confirmBtnLabel.snp.makeConstraints { make in
            make.top.equalTo(confirmBtn).offset(18)
            make.centerX.equalTo(confirmBtn)
        }
    }
    
    func configView() {
        inputNameView.title = "이름(선택)"
        inputBirthView.title = "생년월일"
        inputPhoneNumberView.title = "전화번호(선택)"
        inputNicknameView.title = "닉네임"
        
        inputBirthView.inputType = .date
        inputPhoneNumberView.inputType = .phoneNumber
        
        inputNicknameView.placeholder = "닉네임을 입력해주세요."
        
        for (button, _) in buttonDictionary {
            button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        }
        
        let gender = UserDefaultManager.shared.userGender
        
        if gender == "MALE" {
            maleBtn.isSelected = true
            updateButtonColor(maleBtn, "  남성  ")
        } else if gender == "FEMALE" {
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
        
        inputBirthView.onTextChanged = { [weak self] _ in
            self?.updateConfirmButtonState()
        }
    }
    
    func handleNicknameTextChanged(_ text: String) {
        let specialChar = ["@", "#", "$", "%"]
        
        if text.count < 2 || text.count > 9 || text.isEmpty {
            stateLabel.text = "2글자 이상 10글자 미만으로 설정해주세요"
            stateLabel.textColor = .red
            nickNameisgood = false
        } else if specialChar.contains(where: text.contains) {
            stateLabel.text = "닉네임에 @, #, $, %는 포함할 수 없어요"
            stateLabel.textColor = .red
            nickNameisgood = false
        } else if text.contains(where: { $0.isNumber }) {
            stateLabel.text = "닉네임에 숫자는 포함할 수 없어요"
            stateLabel.textColor = .red
            nickNameisgood = false
        } else {
            stateLabel.text = "올바른 형식입니다"
            stateLabel.textColor = .customOrange
            nickNameisgood = true
        }
        
        updateConfirmButtonState()
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
        
        updateConfirmButtonState()
    }
    
    func postUserInfo() {
        let userInfo = UserInfo(
            name: inputNameView.textField.text ?? "",
            profileImage: "",
            email: UserDefaultManager.shared.email,
            nickName: inputNicknameView.textField.text ?? "",
            birthDate: inputBirthView.textField.text ?? "",
            phoneNumber: inputPhoneNumberView.textField.text ?? "",
            gender: determineSelectedGender(),
            provider: UserDefaultManager.shared.provider,
            providerId: UserDefaultManager.shared.providerId
        )
                    
        SignService.shared.sendUserInfo(userInfo) { [weak self] userStatus in
            
            guard let self = self else { return }
            guard userStatus != nil else {
                let alert = UIAlertController(title: nil, message: "중복된 닉네임입니다", preferredStyle: .alert)
                let btn1 = UIAlertAction(title: "확인", style: .default)
                alert.addAction(btn1)
                self.present(alert, animated: true)
                return
            }
            
            AdministrationService.shared.postAgree(termList: TermsRequestDTO.shared.termList) { error in
                if let error = error {
                    print("약관 동의 실패 - \(error.localizedDescription)")
                } else {
                    print("약관 동의 성공")
                    let VC = GetUserInfoViewController()
                    self.navigationController?.pushViewController(VC, animated: true)
                }
            }
        }
    }
    
    func determineSelectedGender() -> String {
        if maleBtn.isSelected {
            return "MALE"
        } else if femaleBtn.isSelected {
            return "FEMALE"
        } else {
            return "NONE"
        }
    }
    
    func updateConfirmButtonState() {
        let isNicknameValid = !inputNicknameView.textField.text!.isEmpty && nickNameisgood
        
        // 생년월일 필드가 비어있지 않은지 확인 (필수 항목)
        let isBirthDateValid = !(inputBirthView.textField.text?.isEmpty ?? true)
        
        let isGenderSelected = maleBtn.isSelected || femaleBtn.isSelected || noneBtn.isSelected

        if isNicknameValid && isBirthDateValid && isGenderSelected {
            confirmBtn.isEnabled = true
            confirmBtn.backgroundColor = .black
        } else {
            confirmBtn.isEnabled = false
            confirmBtn.backgroundColor = .lightGray
        }
    }
    
    @objc func confirmBtnClicked() {
        // 닉네임은 필수, 생년월일과 이메일은 선택 항목으로 처리
        if (maleBtn.isSelected || femaleBtn.isSelected || noneBtn.isSelected) && confirmBtn.isEnabled == true && nickNameisgood {
            if isPatch { // 내 정보 수정일 때
                guard let name = inputNameView.textField.text,
                      let birthDate = inputBirthView.textField.text,
                      let phoneNumber = inputPhoneNumberView.textField.text,
                      let nickName = inputNicknameView.textField.text else { return }
                
                MyPageService.shared.patchMyInfo(name: name,
                                                 birthDate: birthDate,
                                                 phoneNumber: phoneNumber,
                                                 gender: determineSelectedGender(),
                                                 nickName: nickName) { error in
                    if let error = error {
                        print("내 정보 수정 실패 - \(error.localizedDescription)")
                        let alert = UIAlertController(title: nil, message: "중복된 닉네임입니다", preferredStyle: .alert)
                        let btn1 = UIAlertAction(title: "확인", style: .default)
                        alert.addAction(btn1)
                        self.present(alert, animated: true)
                    } else {
                        print("내 정보 수정 성공")
                        
                        // 성공 시 UserDefaults 업데이트
                        UserDefaultManager.shared.userName = name
                        UserDefaultManager.shared.userBirth = birthDate
                        UserDefaultManager.shared.userPhoneNumber = phoneNumber
                        UserDefaultManager.shared.userNickname = nickName
                        UserDefaultManager.shared.userGender = self.determineSelectedGender()
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            } else { // 최초 가입일 때
                postUserInfo()  // 회원 가입 진행
                // 필수 항목이 아닌 데이터도 UserDefaults에 저장, 비어있을 수 있음
                UserDefaultManager.shared.userNickname = inputNicknameView.textField.text ?? "Guest"
                UserDefaultManager.shared.userName = inputNameView.textField.text ?? ""
                UserDefaultManager.shared.userBirth = inputBirthView.textField.text ?? ""
                UserDefaultManager.shared.userPhoneNumber = inputPhoneNumberView.textField.text ?? ""
                UserDefaultManager.shared.userGender = self.determineSelectedGender()
            }
        } else {
            return
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
