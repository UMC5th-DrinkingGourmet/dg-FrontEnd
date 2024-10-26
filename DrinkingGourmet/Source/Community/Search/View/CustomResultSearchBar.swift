//
//  CustomResultSearchBar.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

class CustomResultSearchBar: UIView {
    
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
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1),
            .font: UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!,
            .kern: -0.42,
            .paragraphStyle: paragraphStyle
        ]
        
        $0.attributedPlaceholder = NSAttributedString(string: "검색어를 입력해주세요", attributes: attributes)
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
        
        magnifyingImage.snp.makeConstraints { make in
            make.top.bottom.equalTo(textFieldView).inset(11)
            make.leading.equalTo(textFieldView).inset(16)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(textFieldView).inset(11)
            make.leading.equalTo(magnifyingImage).inset(25)
            make.trailing.equalTo(textFieldView).offset(-16)
            make.bottom.equalTo(textFieldView).inset(10)
        }
    }

}
