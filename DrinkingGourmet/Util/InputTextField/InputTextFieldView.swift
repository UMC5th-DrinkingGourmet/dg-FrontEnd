//
//  InputTextFieldView.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 2/3/24.
//

import UIKit

class InputTextFieldView: UIView {
    var onTextChanged: ((String) -> Void)?
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var placeholder: String? {
        didSet {
            textField.placeholder = placeholder
            textField.setPlaceholder(color: .checkmarkGray)
        }
    }
    
    var textfieldText: String? {
        didSet {
            textField.text = textfieldText
        }
    }
    
    let titleLabel = UILabel().then {
        $0.text = "title"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        $0.textAlignment = .left
    }
    
    lazy var textField = UITextField().then {
        $0.textColor = .black
        $0.text = "textfield.text"
        $0.attributedPlaceholder = NSAttributedString(
            string: "입력 부탁드려요~",
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        )
        $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged) // 수정된 부분
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }

        // 콜백 클로저 호출
        onTextChanged?(text)
    }
    
    lazy var xBtn = UIButton().then {
        $0.setImage(UIImage(named: "ic_delete"), for: .normal)
        $0.addTarget(self, action: #selector(xBtnClicked), for: .touchUpInside)
    }
    
    let borderView = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configHierarchy()
        layout()
    }
    
    func configHierarchy() {
        addSubviews([
            titleLabel,
            borderView,
            textField,
            xBtn
        ])
    }
    
    func layout() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        borderView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        textField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(borderView.snp.top).offset(-8)
            $0.height.equalTo(24)
        }
        
        xBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(4)
            $0.bottom.equalTo(textField.snp.bottom)
            $0.width.height.equalTo(24)
        }
    }
    
    @objc func xBtnClicked() {
        textField.text = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
