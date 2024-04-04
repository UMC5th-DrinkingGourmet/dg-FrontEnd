//
//  CustomSearchBar.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

final class CustomSearchBar: UIView {
    // MARK: - View
    private let baseView = UIView().then {
        $0.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.935, green: 0.935, blue: 0.935, alpha: 1).cgColor
    }
    
    let searchBarButton = UIButton().then {
        $0.backgroundColor = .clear
    }
    
    let placeholderLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "~~를 입력하세요.", attributes: [NSAttributedString.Key.kern: -0.42, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let magnifyingIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_magnifying")
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func addViews() {
        self.addSubview(baseView)
        
        baseView.addSubviews([
            searchBarButton,
            placeholderLabel,
            magnifyingIcon
        ])
    }
    
    private func configureConstraints() {
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(42)
        }
        
        searchBarButton.snp.makeConstraints { make in
            make.edges.equalTo(baseView)
        }
        
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalTo(baseView).inset(11)
            make.leading.equalTo(baseView).inset(16)
            make.bottom.equalTo(baseView).inset(10)
        }
        
        magnifyingIcon.snp.makeConstraints { make in
            make.centerY.equalTo(placeholderLabel)
            make.trailing.equalTo(baseView).inset(16)
            make.size.equalTo(20)
        }
    }
}
