//
//  SettingCell.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 4/1/24.
//

import UIKit

final class SettingCell: UITableViewCell {
    // MARK: - View
    let titleLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "자주 묻는 질문", attributes: [NSAttributedString.Key.kern: -0.3, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let arrowIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_more")
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        addViews()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func addViews() {
        contentView.addSubviews([
            titleLabel,
            arrowIcon
        ])
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).inset(20)
        }
        
        arrowIcon.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).inset(25)
            make.size.equalTo(12)
        }
    }
}
