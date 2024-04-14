//
//  RecipeBookDetailView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

final class RecipeBookDetailView: UIView {
    
    // MARK: - View
    let scrollView = UIScrollView().then {
        $0.contentInsetAdjustmentBehavior = .never // 네비게이션바 뒤까지
        $0.showsVerticalScrollIndicator = false
        $0.keyboardDismissMode = .onDrag // 스크롤 시 키보드 숨김
    }
    
    private let contentView = UIView()
    
    private let flowlayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal // 가로 스크롤
    }
    
    lazy var imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout).then {
        $0.backgroundColor = .clear
        $0.isPagingEnabled = true // 페이징
        $0.showsHorizontalScrollIndicator = false
    }
    
    let pageControl = UIPageControl()
    
    let profileImage = UIImageView().then {
        $0.backgroundColor = UIColor(red: 0.935, green: 0.935, blue: 0.935, alpha: 1)
        $0.image = UIImage(named: "ic_default_profile")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    let userNameLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        $0.text = "이름 님의 레시피"
    }
    
    let likeIconButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_like"), for: .normal)
    }
    
    let grayLine = UIView().then {
        $0.backgroundColor = UIColor(red: 0.935, green: 0.935, blue: 0.935, alpha: 1)
    }
    
    let hashtagLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "#해시태그 #테스트 #입니다", attributes: [NSAttributedString.Key.kern: -0.36, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let moreButton = UIButton().then {
        $0.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        $0.tintColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1)
        $0.isHidden = true
    }
    
    let titleLabel = UILabel().then {
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "음주미식회 레시피북 테스트", attributes: [NSAttributedString.Key.kern: -0.6, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let recipeBookDetailInfoView = RecipeBookDetailInfoView()
    
    private let ingredientLabel = UILabel().then {
        $0.text = "재료"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
    }
    
    let ingredientListLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.text = "골뱅이1캔 양파 1/2개 당근 1개 오이 1개 깻잎 1묶음 대파 1/2대 청양고추 2개 양배추 1줌 소면"
        $0.textColor = UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
    }
    
    private let cookLabel = UILabel().then {
        $0.text = "조리방법"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
    }
    
    let descriptionLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.textColor = UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.attributedText = NSMutableAttributedString(string: "1. 골뱅이는 깨끗이 씻어 끓는 물에 살짝 데친 후 껍질을 제거하고 손질합니다.\n2. 물을 끌이고 삶는다\n3. 소스랑 비빈다.\n4. 맛있게 먹는다 ", attributes: [NSAttributedString.Key.kern: -0.42, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let dividerView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    }
    
//    let commentAreaView = CommentAreaView()
    
    let commentsInputView = CommentInputView()
    
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
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImage.layer.cornerRadius = profileImage.bounds.width / 2
    }
    
    func addViews() {
        self.addSubview(scrollView)
        self.addSubview(commentsInputView)
        
        scrollView.addSubview(contentView)
        contentView.addSubviews([imageCollectionView, pageControl, profileImage, userNameLabel,  likeIconButton, grayLine, hashtagLabel, moreButton, titleLabel, recipeBookDetailInfoView, ingredientLabel, ingredientListLabel, cookLabel, descriptionLabel, dividerView/*, commentAreaView*/])
    }
    
    func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(commentsInputView.snp.top).offset(-8)
        }
        
        commentsInputView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(96)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView)
            make.edges.equalTo(scrollView)
        }
        
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
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.top).inset(13)
            make.leading.equalTo(profileImage.snp.trailing).offset(12)
            make.bottom.equalTo(profileImage.snp.bottom).inset(12)
        }
        
        likeIconButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.trailing.equalTo(contentView).offset(-20)
            make.centerY.equalTo(userNameLabel)
        }
        
        grayLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(profileImage.snp.bottom).offset(8)
            make.leading.trailing.equalTo(contentView)
        }
        
        hashtagLabel.snp.makeConstraints { make in
            make.top.equalTo(grayLine.snp.bottom).offset(24)
            make.leading.equalTo(contentView).offset(21)
            make.trailing.equalTo(contentView).offset(-21)
        }
        
        moreButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerX.equalTo(likeIconButton)
            make.top.equalTo(likeIconButton.snp.bottom).offset(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(hashtagLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(hashtagLabel)
        }
        
        recipeBookDetailInfoView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(contentView).offset(20)
            make.trailing.equalTo(contentView).offset(-20)
        }
        
        ingredientLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeBookDetailInfoView.snp.bottom).offset(24)
            make.leading.equalTo(titleLabel)
        }
        
        ingredientListLabel.snp.makeConstraints { make in
            make.top.equalTo(ingredientLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(contentView).inset(35)
        }
        
        cookLabel.snp.makeConstraints { make in
            make.top.equalTo(ingredientListLabel.snp.bottom).offset(30)
            make.leading.equalTo(hashtagLabel)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(cookLabel.snp.bottom).offset(8)
            make.leading.equalTo(contentView).inset(23)
            make.trailing.equalTo(contentView).inset(23)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(8)
        }
        
//        commentAreaView.snp.makeConstraints { make in
//            make.top.equalTo(dividerView.snp.bottom).offset(16)
//            make.leading.trailing.bottom.equalToSuperview()
//        }
    }
}
