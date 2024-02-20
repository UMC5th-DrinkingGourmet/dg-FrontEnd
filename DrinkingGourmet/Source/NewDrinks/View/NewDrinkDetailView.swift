////
////  NewDrinkDetailView.swift
////  DrinkingGourmet
////
////  Created by hee on 2/20/24.
////
//
//import UIKit
//import SnapKit
//import Then
//
//class NewDrinkDetailView: UIView {
//
//    let scrollView = UIScrollView().then {
//        $0.showsVerticalScrollIndicator = true
//        //$0.contentInsetAdjustmentBehavior = .never // 네비게이션바 뒤까지
//        //$0.showsVerticalScrollIndicator
//        //$0.keyboardDismissMode = .onDrag // 스크롤 시 키보드 숨김
//    }
//
//    private let contentView = UIView()
//
//    let imageView = UIImageView().then {
//        $0.image = UIImage(named: "img_welcome")
//        $0.frame = CGRect(x: 0, y: 0, width: 333, height: 333)
//        $0.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
//        $0.layer.cornerRadius = 8
//        $0.layer.masksToBounds = true
//    }
//
//    let titleLabel = UILabel().then {
//        $0.frame = CGRect(x: 0, y: 0, width: 35, height: 30)
//        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
//        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
//        $0.numberOfLines = 0
//        $0.lineBreakMode = .byWordWrapping
//        var paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1.25
//        $0.attributedText = NSMutableAttributedString(string: "여울", attributes: [NSAttributedString.Key.kern: -0.6, NSAttributedString.Key.paragraphStyle: paragraphStyle])
//    }
//
//    let subTitleLabel = UILabel().then {
//        $0.textColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
//        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
//        $0.numberOfLines = 0
//        $0.lineBreakMode = .byWordWrapping
//        var paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1.25
//        $0.attributedText = NSMutableAttributedString(string: "입안에 흐르는 향긋한 여운", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
//    }
//
//    let detailLabel = UILabel().then {
//        $0.textColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
//        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
//        $0.numberOfLines = 0
//        $0.lineBreakMode = .byWordWrapping
//        var paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1.25
//        $0.attributedText = NSMutableAttributedString(string: "상온에서 단기간 2단 발효를 통해 은은한 풍미를 살린 제품입니다. 감압증류법을 적용하여 섬세하고 깊은 맛을 완성했습니다. 병입 전 0°C 냉동 여과를 통해 더욱 부드럽고 깨끗한 맛을 구현했습니다.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
//    }
//
//    let dividerView = UIView().then {
//        $0.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
//    }
//
//    //  술 상세 정보
//    let newDrinkDetailInfoView = NewDrinkDetailInfoView()
//
//    let anotherDrinksView = AnotherDrinksView()
//
//    private let flowlayout = UICollectionViewFlowLayout().then {
//        $0.scrollDirection = .horizontal
//    }
//
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addViews()
//        configureConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func addViews() {
//        self.addSubview(scrollView)
//        self.addSubview(newDrinkDetailInfoView)
//        self.addSubview(dividerView)
//        self.addSubview(anotherDrinksView)
//
//        scrollView.addSubview(contentView)
//        contentView.addSubviews([imageView, titleLabel, subTitleLabel, detailLabel, dividerView])
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        //        profileImage.layer.cornerRadius = profileImage.bounds.width / 2
//    }//
//
//    func configureConstraints() {
//        scrollView.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(newDrinkDetailInfoView.snp.top).offset(-8)
//        }
//
//        newDrinkDetailInfoView.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(anotherDrinksView.snp.top).offset(-8)
//            //make.height.equalTo(233)
//        }
//
//        anotherDrinksView.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.bottom.equalToSuperview()
//            //make.height.equalTo(330)
//        }
//        
//        contentView.snp.makeConstraints { make in
//            make.width.equalTo(scrollView)
//            make.edges.equalTo(scrollView)
//        }
//        
//        imageView.snp.makeConstraints { make in
//            make.width.height.equalTo(333)
//            make.leading.trailing.equalTo(contentView).inset(21)
//            make.top.equalTo(contentView).offset(30)
//        }
//
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalTo(imageView.snp.bottom).offset(16)
//            make.leading.equalTo(imageView)
//        }
//        subTitleLabel.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(4)
//            make.leading.equalTo(imageView)
//        }
//        detailLabel.snp.makeConstraints { make in
//            make.top.equalTo(subTitleLabel.snp.bottom).offset(30)
//            make.leading.equalTo(imageView)
//            make.trailing.equalTo(imageView)
//        }
//        dividerView.snp.makeConstraints { make in
//            make.top.equalTo(detailLabel.snp.bottom).offset(24)
//            make.height.equalTo(8)
//            make.leading.trailing.equalTo(contentView)
//        }
//        newDrinkDetailInfoView.snp.makeConstraints { make in
//            make.top.equalTo(dividerView.snp.bottom)
//            make.leading.trailing.equalTo(contentView)
//            make.height.equalTo(400)
//        }
//        dividerView.snp.makeConstraints { make in
//            make.top.equalTo(newDrinkDetailInfoView.snp.bottom)
//            make.height.equalTo(8)
//            make.leading.trailing.equalTo(contentView)
//        }
//        anotherDrinksView.snp.makeConstraints { make in
//            make.top.equalTo(dividerView.snp.bottom)
//            make.height.equalTo(400)
//        }
//
//    }
//}
