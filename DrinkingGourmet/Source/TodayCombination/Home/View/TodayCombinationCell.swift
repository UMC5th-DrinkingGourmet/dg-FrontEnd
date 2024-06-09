//
//  TodayCombinationCell.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 1/17/24.
//

import UIKit

final class TodayCombinationCell: UITableViewCell {
    
    // MARK: - View
    let thumnailImage = UIImageView().then {
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.contentMode = .scaleAspectFill
    }
    
    let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
    }
    
    let hashtagLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
    }
    
    private let commentIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_reply")
    }
    
    let commentNumLabel = UILabel().then {
        $0.text = "99"
        $0.textColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
    }
    
    private let likeIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_like")
    }
    
    let likeNumLabel = UILabel().then {
        $0.text = "99"
        $0.textColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
    }
    
    let likeSelectedIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_like_selected")
        $0.contentMode = .scaleAspectFit
    }

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none // cell 선택 시 시각효과 제거
        
        setupContentView()
        addViews()
        configureConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    override func layoutSubviews() { // 셀 간 간격 설정
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 15, right: 20))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        likeSelectedIcon.isHidden = true
    }

    private func setupContentView() { // 셀 테두리 설정
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8
        contentView.layer.borderColor = UIColor(red: 0.935, green: 0.935, blue: 0.935, alpha: 1).cgColor
    }
    
    private func addViews() {
        contentView.addSubviews([
            thumnailImage,
            titleLabel,
            hashtagLabel,
            commentIcon,
            commentNumLabel,
            likeIcon,
            likeNumLabel,
            likeSelectedIcon
        ])
    }
    
    private func configureConstraints() {
        
        thumnailImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading).offset(1)
            make.trailing.equalTo(contentView.snp.trailing).offset(-1)
            make.bottom.equalTo(contentView.snp.bottom).offset(-71)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(22)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom).offset(-35)
        }
        
        hashtagLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.trailing.equalTo(commentIcon.snp.leading)
            make.bottom.equalTo(contentView.snp.bottom).offset(-12)
        }
        
        commentIcon.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-73)
            make.centerY.equalTo(hashtagLabel)
        }
        
        commentNumLabel.snp.makeConstraints { make in
            make.leading.equalTo(commentIcon.snp.trailing).offset(4)
            make.centerY.equalTo(hashtagLabel)
        }
        
        likeIcon.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.leading.equalTo(commentNumLabel.snp.trailing).offset(8)
            make.centerY.equalTo(hashtagLabel)
        }
        
        likeNumLabel.snp.makeConstraints { make in
            make.leading.equalTo(likeIcon.snp.trailing).offset(4)
            make.centerY.equalTo(hashtagLabel)
        }
        
        likeSelectedIcon.snp.makeConstraints { make in
            make.top.equalTo(thumnailImage.snp.top).offset(16)
            make.leading.equalTo(thumnailImage.snp.leading).offset(294)
            make.trailing.equalTo(thumnailImage.snp.trailing).offset(-15)
        }
    }
}
