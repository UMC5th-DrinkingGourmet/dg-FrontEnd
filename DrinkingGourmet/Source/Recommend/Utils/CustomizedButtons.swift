//
//  CustomizedNextButton.swift
//  DrinkingGourmet
//
//  Created by hee on 1/27/24.
//

import UIKit
import SnapKit

class CustomizedRecommendButtons: UIButton {
    init(buttonTitle: String) {
        super.init(frame: .zero)
        
        self.setTitle(buttonTitle, for: .normal)
        self.setTitleColor(UIColor.baseColor.base03, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.baseColor.base08.cgColor
        self.layer.borderWidth = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

func customizedDrinkingButton(title: String, foregroundColor: UIColor, backgroundColor: UIColor, borderColor: UIColor) -> UIButton {
    let btn = UIButton()
    
    btn.backgroundColor = backgroundColor
    btn.setTitle(title, for: .normal)
    btn.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
    btn.setTitleColor(foregroundColor, for: .normal)
    btn.layer.cornerRadius = 8
    btn.layer.masksToBounds = true
    btn.layer.borderColor = borderColor.cgColor
    btn.layer.borderWidth = 1
    
    return btn
}

func makeNextButton(buttonTitle: String, buttonSelectability: Bool) -> UIButton {
    let btn = UIButton()
    
    btn.setTitle(buttonTitle, for: .normal)
    btn.setTitleColor(UIColor.baseColor.base10, for: .normal)
    btn.contentVerticalAlignment = .top
    btn.titleEdgeInsets.top = 10
    
    if buttonSelectability {
        btn.backgroundColor = UIColor.baseColor.base01
    }else {
        btn.backgroundColor = UIColor.baseColor.base06
    }
    
    btn.snp.makeConstraints { make in
        make.height.equalTo(100)
    }
    return btn
}

func makeSkipButton() -> UIButton {
    let btn = UIButton()
    btn.setTitle("건너뛰기", for: .normal)
    btn.setTitleColor(UIColor.baseColor.base06, for: .normal)
    btn.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
    btn.backgroundColor = .white
    
    btn.snp.makeConstraints { make in
        make.height.equalTo(90)
    }
    return btn
}

func makeButtonArray(buttonArray: [String]) -> [UIButton] {
    var buttons: [UIButton] = []
    
    for (index, name) in buttonArray.enumerated() {
        let button: CustomizedRecommendButtons = {
            CustomizedRecommendButtons(buttonTitle: name)
            
        }()
        button.tag = index
        buttons.append(button)
    }
    return buttons
}
//used
func makeRecommendButtonArray(buttonArray: [UIImage]) -> [UIButton] {
    var buttons: [UIButton] = []
    
    for (index, image) in buttonArray.enumerated() {
        let button = UIButton()
        button.setImage(buttonArray[index], for: .normal)
        button.tag = index
        buttons.append(button)
    }
    return buttons
}
