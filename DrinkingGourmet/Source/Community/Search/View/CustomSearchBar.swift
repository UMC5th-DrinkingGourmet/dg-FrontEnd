//
//  CustomSearchBar.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

class CustomSearchBar: UIView {
    
    let textFieldView = UIView().then {
        $0.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.935, green: 0.935, blue: 0.935, alpha: 1).cgColor
    }
    
    let textField = UITextField().then {
        $0.backgroundColor = .clear
        $0.textColor = .black
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.tintColor = UIColor.customOrange // 커서 색상
        
        $0.attributedPlaceholder = NSAttributedString(
            string: "~~를 입력하세요.",
            attributes: [
                .foregroundColor: UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1),
                .font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!
            ]
        )
    }
    
    let magnifyingImage = UIImageView().then {
        $0.image = UIImage(named: "ic_magnifying")
        $0.contentMode = .scaleAspectFit
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubviews([textFieldView, textField, magnifyingImage])
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        configureConstraints()
    }
    
    
    func configureConstraints() {
        
        textFieldView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(textFieldView).inset(11)
            make.leading.equalTo(textFieldView).inset(26)
            make.trailing.equalTo(magnifyingImage.snp.leading).offset(-10)
            make.bottom.equalTo(textFieldView).inset(10)
        }
        
        magnifyingImage.snp.makeConstraints { make in
            make.top.bottom.equalTo(textFieldView).inset(11)
            make.trailing.equalTo(textFieldView).inset(16)
        }
        
    }

}
