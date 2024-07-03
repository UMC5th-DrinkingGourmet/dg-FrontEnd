//
//  NextButtonView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/3/24.
//

import UIKit

final class NextButtonView: UIView {
    // MARK: - View
    let label = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1
        $0.attributedText = NSMutableAttributedString(string: "다음", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let button = UIButton().then {
        $0.backgroundColor = .clear
        $0.isEnabled = false
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        
        addViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func addViews() {
        self.addSubviews([label,
                          button])
    }
    
    private func configureConstraints() {
        self.snp.makeConstraints { make in
            make.height.equalTo(89)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.centerX.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
