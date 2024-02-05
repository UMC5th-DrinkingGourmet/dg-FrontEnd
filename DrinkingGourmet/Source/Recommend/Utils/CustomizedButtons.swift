//
//  CustomizedNextButton.swift
//  DrinkingGourmet
//
//  Created by hee on 1/27/24.
//

import UIKit
import SnapKit

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
