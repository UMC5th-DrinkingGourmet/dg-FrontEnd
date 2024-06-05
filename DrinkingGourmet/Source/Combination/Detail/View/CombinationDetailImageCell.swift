//
//  CombinationDetailImageCell.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 4/10/24.
//

import UIKit

final class CombinationDetailImageCell: UICollectionViewCell {
    // MARK: - View
    let mainImage = UIImageView().then {
        $0.image = UIImage(named: "img_home_review_01")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func addViews() {
        contentView.addSubview(mainImage)
    }
    
    private func configureConstraints() {
        mainImage.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
