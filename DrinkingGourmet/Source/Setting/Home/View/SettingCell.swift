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
        $0.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.kern: -0.3, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let arrowIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_more")
    }
    
    let iconImageView = UIImageView() // 아이콘 이미지 뷰 추가
    let versionLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.isHidden = true // 기본적으로 숨김 처리
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func addViews() {
        contentView.addSubviews([
            iconImageView,
            titleLabel,
            versionLabel, // 버전 레이블 추가
            arrowIcon
        ])
    }
    
    func configureConstraints(hasIcon: Bool) {
        iconImageView.snp.remakeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(18)
            make.leading.equalTo(contentView).inset(20)
            make.size.equalTo(hasIcon ? 20 : 0) // 아이콘 크기 설정
        }
        
        titleLabel.snp.remakeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(16)
            if hasIcon {
                make.leading.equalTo(iconImageView.snp.trailing).offset(16) // 아이콘과 간격 설정
            } else {
                make.leading.equalTo(contentView).inset(20) // 아이콘 없을 때
            }
        }
        
        versionLabel.snp.remakeConstraints { make in
            make.top.equalTo(contentView).inset(18)
            make.bottom.equalTo(contentView).inset(17)
            make.trailing.equalTo(arrowIcon.snp.leading).offset(-10)
        }
        
        arrowIcon.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(22)
            make.trailing.equalTo(contentView).inset(25)
            make.size.equalTo(12)
        }
    }
    
    func setTitleColor(_ color: UIColor) {
        titleLabel.textColor = color
    }
}
