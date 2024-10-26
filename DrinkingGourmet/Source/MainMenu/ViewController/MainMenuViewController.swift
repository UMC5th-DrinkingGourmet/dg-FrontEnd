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
    
    var topCollectionViewImgList = ["img_home_banner", "HomeBanner01", "HomeBanner02"]
    var topCollectionViewTitleList = ["넌 지금 어묵국물에\n소주가 땡긴다", "와인과 어울리는\n안주 페어링", "위스키 하이볼 황금비율\n여기서만 공개할게요"]
    
    var recipes: [RecipeModel] = []
    var combinations: [CombinationModel] = []
    
    private let refreshControl = UIRefreshControl()
    
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
    
    let recipeBookLabel = UILabel().then {
        $0.text = "레시피북"
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
    let recipeBookIcon = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .base0600
    }
    
    let recipeBookBtn = UIButton().then {
        $0.backgroundColor = .clear
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
    
    let todayCombiLabel = UILabel().then {
        $0.text = "오늘의 조합"
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
    let todayCombiIcon = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .base0600
    }
    
    let todayCombiBtn = UIButton().then {
        $0.backgroundColor = .clear
    }
    
    lazy var todayCombiCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout3()).then {
        $0.isPagingEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(TodayCombiCollectionViewCell.self, forCellWithReuseIdentifier: "TodayCombiCollectionViewCell")
        $0.tag = 2
        $0.backgroundColor = .clear
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    let newAlcoholBtn = UIButton().then {
        $0.isHidden = true
        $0.trailingBtnConfiguration(title: "새로 출시된 주류", font: .boldSystemFont(ofSize: 20), foregroundColor: .black, padding: 8, image: UIImage(systemName: "chevron.right"), imageSize: CGSize(width: 10, height: 12))
    }
    
    let newAlcoholImage = UIImageView().then {
        $0.isHidden = true
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
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.55, height: 160)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return layout
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNaviBar()
        configHierarchy()
        layout()
        configButton()
        fetchPostsData()
        configureRefreshControl()
    }
    
    func setupNaviBar() {
        // 백버튼 커스텀
        let customBackImage = UIImage(named: "ic_back")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = customBackImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = customBackImage
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        do {
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            let refreshToken = try Keychain.shared.getToken(kind: .refreshToken)
            print("액세스 토큰: \(accessToken)")
            print("리프레시 토큰: \(refreshToken)")
            print("main menu providerid: \(UserDefaultManager.shared.providerId)")
        } catch {
            print("Failed to get access token")
        }
    }
    
    private func configureRefreshControl() {
        scrollView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc private func refreshData() {
        fetchPostsData()
    }
    
    func configButton() {
        recipeBookBtn.addTarget(self, action: #selector(recipeBookBtnTapped), for: .touchUpInside)
        recommendView.goBtn.addTarget(self, action: #selector(recommendViewTapped), for: .touchUpInside)
        todayCombiBtn.addTarget(self, action: #selector(todayCombiBtnTapped), for: .touchUpInside)
        newAlcoholBtn.addTarget(self, action: #selector(newAlcoholBtnTapped), for: .touchUpInside)
        
        
    }

    @objc func recipeBookBtnTapped() {
        let recipeBookHomeVC = RecipeBookHomeViewController()
        recipeBookHomeVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(recipeBookHomeVC, animated: true)
    }
    
    @objc func recommendViewTapped() {
        if let tabBarVC = self.tabBarController as? TabBarViewController {
            // '주류추천' 탭을 선택
            tabBarVC.selectedIndex = 0
            
            // '주류추천' 탭의 네비게이션 컨트롤러를 가져옴
            if let myPageNavController = tabBarVC.viewControllers?[0] as? UINavigationController {
                // 네비게이션 컨트롤러의 스택을 루트 뷰 컨트롤러로 초기화
                myPageNavController.popToRootViewController(animated: true)
            }
        }
    }

    @objc func todayCombiBtnTapped() {
        let todayCombinationViewController = CombinationHomeViewController()
        todayCombinationViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(todayCombinationViewController, animated: true)
    }
    
    /* 모이치 */
    @objc func newAlcoholBtnTapped() {
        let newAlcoholViewController = NewAlcoholViewController()
        newAlcoholViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(newAlcoholViewController, animated: true)
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
            recipeBookLabel,
            recipeBookIcon,
            recipeBookBtn,
            recipeBookCollectionView,
            todayCombiLabel,
            todayCombiIcon,
            todayCombiBtn,
            todayCombiCollectionView,
            newAlcoholBtn,
            newAlcoholImage,
            mainAdImage
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
            $0.height.equalTo(1132)
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
        
        recipeBookLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(recommendView.snp.bottom).offset(28)
        }
        
        recipeBookIcon.snp.makeConstraints {
            $0.leading.equalTo(recipeBookLabel.snp.trailing).offset(12)
            $0.height.equalTo(14)
            $0.width.equalTo(10)
            $0.centerY.equalTo(recipeBookLabel)
        }
        
        recipeBookBtn.snp.makeConstraints {
            $0.top.leading.bottom.equalTo(recipeBookLabel)
            $0.trailing.equalTo(recipeBookIcon)
        }
        
        recipeBookCollectionView.snp.makeConstraints {
            $0.top.equalTo(recipeBookBtn.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(contentView).inset(20)
            $0.height.equalTo(160)
        }
        
        todayCombiLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(recipeBookCollectionView.snp.bottom).offset(28)
        }
        
        todayCombiIcon.snp.makeConstraints {
            $0.leading.equalTo(todayCombiLabel.snp.trailing).offset(12)
            $0.height.equalTo(14)
            $0.width.equalTo(10)
            $0.centerY.equalTo(todayCombiLabel)
        }
        
        todayCombiBtn.snp.makeConstraints {
            $0.top.leading.bottom.equalTo(todayCombiLabel)
            $0.trailing.equalTo(todayCombiIcon)
        }
        
        todayCombiCollectionView.snp.makeConstraints {
            $0.top.equalTo(todayCombiBtn.snp.bottom).offset(8)
            $0.leading.equalTo(contentView)
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
            make.bottom.equalTo(contentView)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
    }
    
    @objc func backToPrevious() {
        navigationController?.popViewController(animated: true)
    }
}

extension MainMenuViewController {
    func fetchPostsData() {
        MainMenuService.shared.fetchRecipes { [weak self] recipeList in
            self?.recipes = recipeList
            print("레피시북 success")
            DispatchQueue.main.async {
                self?.recipeBookCollectionView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
        
        MainMenuService.shared.fetchWeeklyBestCombinations { [weak self] (combinationList: [CombinationModel]) in
            self?.combinations = combinationList
            print("오늘의조합 success")
            DispatchQueue.main.async {
                self?.todayCombiCollectionView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }
}

extension MainMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return topCollectionViewImgList.count
        } else if collectionView.tag == 1 {
            return recipes.count
        } else {
            return combinations.count
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
            
            let recipe = recipes[indexPath.item]
            cell.recipeBookTitleLabel.text = "|  \(recipe.name)"
            cell.timeLabel.text = recipe.cookingTime
            cell.ingredientLabel.text = recipe.ingredient
            if let url = URL(string: recipe.imageUrl ?? "") {
                cell.recipeBookImageView.kf.setImage(with: url)
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayCombiCollectionViewCell", for: indexPath) as! TodayCombiCollectionViewCell
            
            let combination = combinations[indexPath.item]
            cell.titleLabel.text = combination.title
            cell.setTitleLabelText(combination.title)
            cell.hashTagLabel.text = combination.hashTags
            if let url = URL(string: combination.imageUrl) {
                cell.combiImageView.kf.setImage(with: url)
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            let combinationHomeVC = CombinationHomeViewController()
            combinationHomeVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(combinationHomeVC, animated: true)
        } else if collectionView.tag == 1 {
            let recipe = recipes[indexPath.item]
            
            let recipeDetailVC = RecipeBookDetailViewController()
            recipeDetailVC.recipeBookId = recipe.id
            recipeDetailVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(recipeDetailVC, animated: true)
        } else if collectionView.tag == 2 {
            let combination = combinations[indexPath.item]
            
            let combinationVC = CombinationDetailViewController()
            combinationVC.combinationId = combination.id
            combinationVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(combinationVC, animated: true)
        }
    }
}

extension TodayCombiCollectionViewCell {
    func setTitleLabelText(_ text: String) {
        let maxLineLength = 11 // 첫 줄 최대 글자 수 기준
        
        if text.count > maxLineLength {
            var splitIndex = text.startIndex
            var currentLength = 0
            
            // 단어 단위로 최대 글자 수 초과 시 줄바꿈 위치 탐색
            for (index, char) in text.enumerated() {
                currentLength += 1
                
                // 공백을 기준으로 마지막으로 넘었는지 확인
                if currentLength > maxLineLength, char == " " {
                    splitIndex = text.index(text.startIndex, offsetBy: index)
                    break
                }
            }
            
            // 줄바꿈 삽입
            let firstLine = text[..<splitIndex]
            let secondLine = text[splitIndex...].trimmingCharacters(in: .whitespaces)
            titleLabel.text = "\(firstLine)\n\(secondLine)"
        } else {
            titleLabel.text = text
        }
    }
}

