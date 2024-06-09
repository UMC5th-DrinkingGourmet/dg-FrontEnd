//
//  CombinationDetailHeaderView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 4/10/24.
//

import UIKit

final class CombinationDetailHeaderView: UITableViewHeaderFooterView {
    // MARK: - View
    private let flowlayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal // 가로 스크롤
    }
    
    lazy var imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout).then {
        $0.backgroundColor = .clear
        $0.isPagingEnabled = true // 페이징
        $0.showsHorizontalScrollIndicator = false
    }
    
    let pageControl = UIPageControl().then {
        $0.numberOfPages = 5
    }
    
    let profileImage = UIImageView().then {
        $0.backgroundColor = UIColor(red: 0.935, green: 0.935, blue: 0.935, alpha: 1)
        $0.image = UIImage(named: "ic_default_profile")
        $0.layer.cornerRadius = 21
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    let nicknameLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        $0.text = "이름 님의 레시피"
    }
    
    let likeButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_like"), for: .normal)
    }
    
    private let dividerView1 = UIView().then {
        $0.backgroundColor = UIColor(red: 0.935, green: 0.935, blue: 0.935, alpha: 1)
    }
    
    let hashtagLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "#골뱅이무침 #새로 #맛의조합 #시너지", attributes: [NSAttributedString.Key.kern: -0.36, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let moreButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_more_content"), for: .normal)
        $0.tintColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1)
    }
    
    let titleLabel = UILabel().then {
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "골뱅이무침 & 새로", attributes: [NSAttributedString.Key.kern: -0.6, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let descriptionLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.textColor = UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        $0.attributedText = NSMutableAttributedString(string: "오늘은 특별한 맛의 소주 안주를 소개합니다! 골뱅이무침과 새로(소주)의 환상적인 조합으로 맛의 신세계를 경험해보세요.\n\n골뱅이무침의 신선하고 쫄깃한 식감이 새로의 부드럽고 깔끔한 맛과 어우러져, 입안에서 환상적인 맛의 축제가 펼쳐집니다️✨\n\n한 입에는 골뱅이무침의 매콤한 맛, 다음 순간에는 새로의 깔끔한 목넘김이 어우러져 색다른 향연을 즐길 수 있어요.\n\n이 두 가지의 맛이 만나면 소주 한 잔이 더욱 특별해지는 것을 느낄 수 있답니다. 혼자 마시거나 친구들과 함께 골뱅이무침과 새로로 특별한 순간을 만들어보세요!", attributes: [NSAttributedString.Key.kern: -0.42, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let dividerView2 = UIView().then {
        $0.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    }
    
    let commentNumLabel = UILabel().then{
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "댓글 ", attributes: [NSAttributedString.Key.kern: -0.42, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func addViews() {
        contentView.addSubviews([
            imageCollectionView,
            pageControl,
            profileImage,
            nicknameLabel,
            likeButton,
            dividerView1,
            hashtagLabel,
            moreButton,
            titleLabel,
            descriptionLabel,
            dividerView2,
            commentNumLabel
        ])
    }
    
    private func configureConstraints() {
        imageCollectionView.snp.makeConstraints { make in
            make.height.equalTo(375)
            make.top.leading.trailing.equalTo(contentView)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(imageCollectionView.snp.top).offset(331)
            make.centerX.equalTo(imageCollectionView)
        }
        
        profileImage.snp.makeConstraints { make in
            make.width.height.equalTo(42)
            make.top.equalTo(imageCollectionView.snp.bottom).offset(10)
            make.leading.equalTo(contentView).offset(16)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.top).inset(13)
            make.leading.equalTo(profileImage.snp.trailing).offset(12)
            make.bottom.equalTo(profileImage.snp.bottom).inset(12)
        }
        
        likeButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.trailing.equalTo(contentView).offset(-20)
            make.centerY.equalTo(nicknameLabel)
        }
        
        dividerView1.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(profileImage.snp.bottom).offset(8)
            make.leading.trailing.equalTo(contentView)
        }
        
        hashtagLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView1.snp.bottom).offset(24)
            make.leading.equalTo(contentView).offset(21)
            make.trailing.equalTo(contentView).offset(-21)
            make.height.equalTo(20)
        }
        
        moreButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerX.equalTo(likeButton)
            make.top.equalTo(likeButton.snp.bottom).offset(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(hashtagLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(hashtagLabel)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.trailing.equalTo(hashtagLabel)
        }
        
        dividerView2.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(8)
        }
        
        commentNumLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView2.snp.bottom).offset(16)
            make.leading.equalTo(contentView).inset(21)
            make.bottom.equalTo(contentView)
        }
    }
}

