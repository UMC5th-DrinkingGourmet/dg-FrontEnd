//
//  CommunityHomeDataManager.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

class CommunityHomeCell: UITableViewCell {
    
    let mainImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentView()
        addViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 셀 테두리 설정
    func setupContentView() {
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
    }
    
    func addViews() {
        contentView.addSubviews([mainImage])
    }
    
    func configureConstraints() {
        mainImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
}
