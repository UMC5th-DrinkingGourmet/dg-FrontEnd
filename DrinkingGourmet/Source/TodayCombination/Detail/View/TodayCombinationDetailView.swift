//
//  TodayCombinationDetailView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 1/18/24.
//

import UIKit
import SnapKit
import Then

class TodayCombinationDetailView: UIView {
    
    private let scrollView = UIScrollView().then {
        $0.contentInsetAdjustmentBehavior = .never // 네비게이션바 뒤까지
        $0.showsVerticalScrollIndicator = false
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
    
    let testLabel = UILabel().then {
        $0.text = "오늘은 특별한 맛의 소주 안주를 소개합니다! 골뱅이무침과 새로(소주)의 환상적인 조합으로 맛의 신세계를 경험해보세요. 골뱅이무침의 신선하고 쫄깃한 식감이 새로의 부드럽고 깔끔한 맛과 어우러져, 입안에서 환상적인 맛의 축제가 펼쳐집니다 ️✨ 한 입에는 골뱅이무침의 매콤한 맛, 다음 순간에는 새로의 깔끔한 목넘김이 어우러져 색다른 향연을 즐길 수 있어요. 이 두 가지의 맛이 만나면 소주 한 잔이 더욱 특별해지는 것을 느낄 수 있답니다. 혼자 마시거나 친구들과 함께 골뱅이무침과 새로로 특별한 순간을 만들어보세요!"
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 30)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        addSubviews(toContainer: contentView, [imageCollectionView, pageControl, testLabel])
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        configureConstraints()
    }
    
    func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.edges.equalTo(scrollView.contentLayoutGuide)
        }
        
        imageCollectionView.snp.makeConstraints { make in
            make.height.equalTo(375)
            make.top.leading.trailing.equalTo(contentView)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(imageCollectionView.snp.top).offset(331)
            make.centerX.equalTo(imageCollectionView)
        }
        
        testLabel.snp.makeConstraints { make in
            make.top.equalTo(imageCollectionView.snp.bottom).offset(50)
            make.leading.equalTo(contentView).offset(20)
            make.trailing.equalTo(contentView).offset(-20)
            make.bottom.equalTo(contentView).offset(-10)
        }

    }
}
