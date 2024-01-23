//
//  CustomCommentsInputView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 1/23/24.
//

import UIKit
import SnapKit
import Then

// 댓글 입력창 커스텀
class CustomCommentsInputView: UIView {
    
    let mainView = UIView().then {
        $0.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
//        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 20
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
        
        $0.attributedPlaceholder = NSAttributedString(
            string: "댓글을 남겨주세요",
            attributes: [
                .foregroundColor: UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1),
                .font: UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!
            ]
        )
    }
    
    let button = UIButton().then {
        
        $0.backgroundColor = .customOrange
        $0.layer.cornerRadius = 15
    }
    
    let arrow = UIImageView().then {
        $0.image = UIImage(systemName: "arrow.up")
        $0.tintColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubviews([mainView, textField, button, arrow])
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        configureConstraints()
    }
    
    
    func configureConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(42)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(mainView).inset(11)
            make.leading.equalTo(mainView).inset(26)
            make.trailing.equalTo(button.snp.leading).offset(-10)
            make.bottom.equalTo(mainView).inset(10)
        }
        
        button.snp.makeConstraints { make in
            make.width.equalTo(48)
            make.height.equalTo(30)
            make.top.equalTo(mainView).inset(6)
            make.trailing.equalTo(mainView).inset(8)
            make.bottom.equalTo(mainView).inset(6)
        }
        
        arrow.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.top.bottom.equalTo(button).inset(7)
            make.leading.trailing.equalTo(button).inset(16)
        }
        
    }
}

