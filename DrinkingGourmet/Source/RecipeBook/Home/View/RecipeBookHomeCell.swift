//
//  RecipeBookHomeCell.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

final class RecipeBookHomeCell: UITableViewCell {
    
    // MARK: - View
    let mainImage = UIImageView().then {
        $0.image = UIImage(named: "img_community_weekly_thumbnail")
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    let titleLabel = UILabel().then {
        $0.text = "음주미식회 레시피북 테스트"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
    }
    
    let subTitleLabel = UILabel().then {
        $0.text = "소제목 테스트입니다"
        $0.textColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
    }
    
    let commentIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_reply")
    }
    
    let commentNumLabel = UILabel().then {
        $0.text = "99"
        $0.textColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
    }
    
    let likeIcon = UIImageView().then {
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
//        $0.isHidden = true
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentView()
        addViews()
        configureConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0))
    }
    
    func setupContentView() {
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8
        contentView.layer.borderColor = UIColor(red: 0.935, green: 0.935, blue: 0.935, alpha: 1).cgColor
    }
    
    func addViews() {
        contentView.addSubviews([mainImage, titleLabel, subTitleLabel, commentIcon, commentNumLabel, likeIcon, likeNumLabel, likeSelectedIcon])
    }
    
    func configureConstraints() {
        
        mainImage.snp.makeConstraints { make in
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
        
        subTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.trailing.equalTo(commentIcon.snp.leading)
            make.bottom.equalTo(contentView.snp.bottom).offset(-12)
        }
        
        commentIcon.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-73)
            make.centerY.equalTo(subTitleLabel)
        }
        
        commentNumLabel.snp.makeConstraints { make in
            make.leading.equalTo(commentIcon.snp.trailing).offset(4)
            make.centerY.equalTo(subTitleLabel)
        }
        
        likeIcon.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.leading.equalTo(commentNumLabel.snp.trailing).offset(8)
            make.centerY.equalTo(subTitleLabel)
        }
        
        likeNumLabel.snp.makeConstraints { make in
            make.leading.equalTo(likeIcon.snp.trailing).offset(4)
            make.centerY.equalTo(subTitleLabel)
        }
        
        likeSelectedIcon.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.top).offset(16)
            make.leading.equalTo(mainImage.snp.leading).offset(294)
            make.trailing.equalTo(mainImage.snp.trailing).offset(-15)
        }
    }
}
