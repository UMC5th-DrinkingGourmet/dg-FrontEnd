//
//  CustomizedNextButton.swift
//  DrinkingGourmet
//
//  Created by hee on 1/27/24.
//

import UIKit
import SnapKit

class CustomRecommendButtons: UIButton {
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

func makeNextButton(buttonTitle: String) -> UIButton {
    let btn = UIButton()
    
    btn.setTitle(buttonTitle, for: .normal)
    btn.backgroundColor = UIColor.baseColor.base01
    btn.setTitleColor(UIColor.baseColor.base10, for: .normal)
    btn.titleEdgeInsets.top = -40
    
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

func makeButtonArray(buttonImageArray: [UIImage]) -> [UIButton] {
    var buttons: [UIButton] = []
    
    for (index, image) in buttonImageArray.enumerated() {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.tag = index // Set the tag to the current index
        buttons.append(button)
    }
    return buttons
}

