//
//  MainMenuViewController.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 2/4/24.
//

import UIKit
import SnapKit
import Then

class MainMenuViewController: UIViewController {
    
    // dummy
    var topCollectionViewImgList = ["img_home_banner", "HomeBanner01", "HomeBanner03", "HomeBanner04"]
    var topCollectionViewTitleList = ["넌 지금 어묵국물에\n소주가 땡긴다", "와인과 어울리는\n안주 페어링", "오늘 퇴근주는\n하이볼 당첨!", "위스키 하이볼 황금비율\n여기서만 공개할게요"]
    
    var imageList = ["img_home_recipebook", "img_community_weekly_detail", "img_home_review_02"]
    
    var imageList2 = ["img_mypage_thumbnail_01", "img_mypage_thumbnail_02", "img_mypage_thumbnail_03"]
    
    var recipetitleList = ["| 골뱅이무침", "| 피자", "| 육전"]
    var recipeIngrList = ["골뱅이 1캔 양파 1/2개\n당근1개 오이1개 깻잎 1묶음\n대파 1/2대 청양고추 2개\n양배추 1줌 소면","강력분 밀가루\n치즈 500g 올리브 1캔\n양파 1개 토마토소스 피망 1개\n옥수수콘 1캔","밀가루 계란\n소고기 대파 1대 소금\n초고추장 참기름"]
    
    var todayCombiTitleList = ["메론 하몽과\n버번 위스키 언더락", "육전과\n서울의 밤", "숯불치킨과\n맥주"]
    
    var hashtagList = ["#홈파티 #언더락 #버번위스키", "#한식주 #미식가 #커플 #저녁식사", "#야식 #불금"]
    
    // 여기까지 dummy
    
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.keyboardDismissMode = .onDrag
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    lazy var bannerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout()).then {
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(MainMenuBannerCollectionViewCell.self, forCellWithReuseIdentifier: "MainMenuBannerCollectionViewCell")
        $0.tag = 0
    }
    
    let recommendView = RecommendView()
    
    let recipeBookBtn = UIButton().then {
        $0.trailingBtnConfiguration(title: "레시피북", font: .boldSystemFont(ofSize: 20), foregroundColor: .black, padding: 8, image: UIImage(systemName: "chevron.right"), imageSize: CGSize(width: 10, height: 12))
    }
    
    lazy var recipeBookCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout2()).then {
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(RecipeBookCollectionViewCell.self, forCellWithReuseIdentifier: "RecipeBookCollectionViewCell")
        $0.tag = 1
    }
    
    let todayCombiBtn = UIButton().then {
        $0.trailingBtnConfiguration(title: "오늘의 조합", font: .boldSystemFont(ofSize: 20), foregroundColor: .black, padding: 8, image: UIImage(systemName: "chevron.right"), imageSize: CGSize(width: 10, height: 12))
    }
    
    lazy var todayCombiCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout3()).then {
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(TodayCombiCollectionViewCell.self, forCellWithReuseIdentifier: "TodayCombiCollectionViewCell")
        $0.tag = 2
    }
    
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 300)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
    
    func configureCollectionViewLayout2() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 160)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
    
    func configureCollectionViewLayout3() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 220, height: 160)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configHierarchy()
        layout()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func configHierarchy() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubviews([
            bannerCollectionView,
            recommendView,
            recipeBookBtn,
            recipeBookCollectionView,
            todayCombiBtn,
            todayCombiCollectionView
        ])
    }
    
    func layout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(scrollView)
            $0.edges.equalTo(scrollView)
            $0.height.equalTo(1500)
        }
        
        bannerCollectionView.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(contentView)
            $0.height.equalTo(300)
        }
        
        recommendView.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentView)
            $0.top.equalTo(bannerCollectionView.snp.bottom)
            $0.height.equalTo(120)
        }
        
        recipeBookBtn.snp.makeConstraints {
            $0.top.equalTo(recommendView.snp.bottom).offset(36)
            $0.leading.equalToSuperview()
            $0.height.equalTo(30)
            $0.width.equalTo(140)
        }
        
        recipeBookCollectionView.snp.makeConstraints {
            $0.top.equalTo(recipeBookBtn.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(contentView).inset(20)
            $0.height.equalTo(160)
        }
        
        todayCombiBtn.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(recipeBookCollectionView.snp.bottom).offset(48)
            $0.height.equalTo(30)
            $0.width.equalTo(140)
        }
        
        todayCombiCollectionView.snp.makeConstraints {
            $0.top.equalTo(todayCombiBtn.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(contentView).inset(20)
            $0.height.equalTo(160)
        }
        
    }
    
    func configView() {
        
    }
    
    @objc func backToPrevious() {
        navigationController?.popViewController(animated: true)
    }
}

extension MainMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return 4
        } else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainMenuBannerCollectionViewCell", for: indexPath) as! MainMenuBannerCollectionViewCell
            
            cell.bannerImageView.image = UIImage(named: topCollectionViewImgList[indexPath.item])
            cell.bannerTitleLabel.text = topCollectionViewTitleList[indexPath.item]
            
            return cell
        } else if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeBookCollectionViewCell", for: indexPath) as! RecipeBookCollectionViewCell
            
            cell.recipeBookImageView.image = UIImage(named: imageList[indexPath.item])
            cell.recipeBookTitleLabel.text = recipetitleList[indexPath.item]
            cell.ingredientLabel.text = recipeIngrList[indexPath.item]
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayCombiCollectionViewCell", for: indexPath) as! TodayCombiCollectionViewCell
            
            cell.combiImageView.image = UIImage(named: imageList2[indexPath.item])
            cell.titleLabel.text = todayCombiTitleList[indexPath.item]
            cell.hashTagLabel.text = hashtagList[indexPath.item]
            
            
            return cell
        }
    }
}
