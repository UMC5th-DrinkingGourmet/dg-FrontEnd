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
    
    private let inputNameView = InputTextFieldView(frame: .zero)
    
    private let inputBirthView = InputTextFieldView(frame: .zero)
    
    private let inputPhoneNumberView = InputTextFieldView(frame: .zero)
    
    private let inputNicknameView = InputTextFieldView(frame: .zero)
    
    private let genderLabel = UILabel().then {
        $0.text = "성별"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        $0.textAlignment = .left
    }
    
    private let maleBtn = UIButton().then {
        $0.genderBtnConfig(title: "남성", font: .systemFont(ofSize: 16), foregroundColor: .darkGray)
    }
    
    private let femaleBtn = UIButton().then {
        $0.genderBtnConfig(title: "여성", font: .systemFont(ofSize: 16), foregroundColor: .darkGray)
    }
    
    private let noneBtn = UIButton().then {
        $0.genderBtnConfig(title: "선택 안함", font: .systemFont(ofSize: 16), foregroundColor: .darkGray)
    }
    
    private let confirmBtn = UIButton().then {
        $0.backgroundColor = .black
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.isEnabled = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        configHierarchy()
        layout()
        configView()
        configNav()
    }
    
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
            inputNicknameView
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
            $0.top.equalTo(genderLabel.snp.bottom).offset(12)
            $0.height.equalTo(40)
        }
        
        femaleBtn.snp.makeConstraints {
            $0.leading.equalTo(maleBtn.snp.trailing).offset(8)
            $0.top.equalTo(genderLabel.snp.bottom).offset(12)
            $0.height.equalTo(40)
        }
        
        noneBtn.snp.makeConstraints {
            $0.leading.equalTo(femaleBtn.snp.trailing).offset(8)
            $0.top.equalTo(genderLabel.snp.bottom).offset(12)
            $0.height.equalTo(40)
        }
        
        inputNicknameView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(72)
            $0.top.equalTo(noneBtn.snp.bottom).offset(56)
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
    }
    
    func configNav() {
        navigationItem.title = "회원 정보 입력"
        let item = UIBarButtonItem(image: UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal).withTintColor(.white), style: .plain, target: self, action: #selector(backToPrevious))
        navigationItem.leftBarButtonItem = item
    }
    
    @objc func backToPrevious() {
        navigationController?.popViewController(animated: true)
    }

}

extension ProfileCreationViewController {
    
}

extension ProfileCreationViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("입력값 변경이 감지되었습니다.")
    }
}
