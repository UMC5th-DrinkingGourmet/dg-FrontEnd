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
    private let kakaoAuthVM: KakaoAuthViewModel = { KakaoAuthViewModel() } ()
    
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
        $0.backgroundColor = .clear
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
        $0.backgroundColor = .clear
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
        $0.backgroundColor = .clear
    }
    
    let newAlcoholBtn = UIButton().then {
        $0.trailingBtnConfiguration(title: "새로 출시된 주류", font: .boldSystemFont(ofSize: 20), foregroundColor: .black, padding: 8, image: UIImage(systemName: "chevron.right"), imageSize: CGSize(width: 10, height: 12))
    }
    
    let newAlcoholImage = UIImageView().then {
        $0.image = UIImage(named: "img_main_new_alcohol")
    }
    
    let mainAdImage = UIImageView().then {
        $0.image = UIImage(named: "img_main_ad")
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
    
    private let logoutBtn = UIButton().then {
        $0.logoutBtnConfig(title: "로그아웃", font: .systemFont(ofSize: 12), backgroundColor: .clear)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNaviBar()
        configHierarchy()
        layout()
        configButton()
    }
    
    func setupNaviBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // 불투명
        appearance.backgroundColor = .white
        
        // 네비게이션바 밑줄 삭제
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // 백버튼 커스텀
        let customBackImage = UIImage(named: "ic_back")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = customBackImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = customBackImage
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        do {
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            print("액세스 토큰: \(accessToken)")
            print("main menu providerid: \(UserDefaultManager.shared.providerId)")
        } catch {
            print("Failed to get access token")
        }
    }
    
    func configButton() {
        recipeBookBtn.addTarget(self, action: #selector(recipeBookBtnTapped), for: .touchUpInside)
        recommendView.goBtn.addTarget(self, action: #selector(recommendViewTapped), for: .touchUpInside)
        todayCombiBtn.addTarget(self, action: #selector(todayCombiBtnTapped), for: .touchUpInside)
        
        logoutBtn.addTarget(self, action: #selector(logoutBtnClicked), for: .touchUpInside)
    }

    @objc func recipeBookBtnTapped() {
        let recipeBookHomeVC = RecipeBookHomeVC()
        recipeBookHomeVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(recipeBookHomeVC, animated: true)
    }
    
    @objc func recommendViewTapped() {
        navigationController?.pushViewController(MyDrinkStyleViewController(), animated: true)
    }

    @objc func todayCombiBtnTapped() {
        let todayCombinationViewController = TodayCombinationViewController()
        todayCombinationViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(todayCombinationViewController, animated: true)
    }
    
    @objc func logoutBtnClicked() {
        let alert = UIAlertController(title: "로그아웃 하시겠습니까?", message: nil, preferredStyle: .alert)

        let btn1 = UIAlertAction(title: "취소", style: .cancel)
        let btn2 = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
//            do {
//                try Keychain.shared.deleteToken(kind: .accessToken)
//                print("Deleted Access Token")
//            } catch {
//                print("Failed to delete Access Token: \(error)")
//            }
//            
//            do {
//                try Keychain.shared.deleteToken(kind: .refreshToken)
//                print("Deleted refreshToken")
//            } catch {
//                print("Failed to delete refreshToken: \(error)")
//            }

            self?.kakaoAuthVM.kakaoLogut()
            
            let authVC = AuthenticationViewController()
            let navigationController = UINavigationController(rootViewController: authVC)
            navigationController.modalPresentationStyle = .fullScreen
            self?.present(navigationController, animated: true)
        }

        alert.addAction(btn1)
        alert.addAction(btn2)

        present(alert, animated: true)
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
            todayCombiCollectionView,
            newAlcoholBtn,
            newAlcoholImage,
            mainAdImage
//            logoutBtn
        ])
    }
    
    func layout() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(scrollView)
            $0.edges.equalTo(scrollView)
            $0.height.equalTo(1650)
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
            $0.leading.equalTo(contentView).inset(20)
            $0.trailing.equalTo(contentView)
            $0.height.equalTo(160)
        }
        
        /* 모이치 */
        newAlcoholBtn.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(todayCombiCollectionView.snp.bottom).offset(48)
            $0.height.equalTo(30)
        }
        
        newAlcoholImage.snp.makeConstraints { make in
            make.top.equalTo(newAlcoholBtn.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        mainAdImage.snp.makeConstraints { make in
            make.top.equalTo(newAlcoholImage.snp.bottom).offset(48)
            make.leading.trailing.equalToSuperview()
        }
        
//        logoutBtn.snp.makeConstraints {
//            $0.top.equalTo(todayCombiCollectionView.snp.bottom).offset(12)
//            $0.trailing.equalToSuperview().offset(-12)
//            $0.height.equalTo(20)
//        }
        
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
