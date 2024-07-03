//
//  MyPageViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/20/24.
//

import UIKit

enum MyPageTab {
    case recommend
    case combination
    case recipeBook
}

class MyPageViewController: UIViewController {
    
    // MARK: - Properties
    var currentTab: MyPageTab = .recommend
    var totalPageNum: Int = 0
    var pageNum: Int = 0
    var isLastPage: Bool = false
    
    var userData: MyPageUserModel?
    var arrayRecommendData: [MyPageRecommendModel.RecommendResponseDTOList] = []
    var arrayCombinationData: [MyPageCombinationModel.CombinationList] = []
    var arrayRecipeBookData: [MyPageRecipeBookModel.RecipeList] = []
    
    private let settingViewController = SettingViewController()
    private let myPageView = MyPageView()
    
    // MARK: - View 설정
    override func loadView() {
        view = myPageView
    }
    
    // MARK: - viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNaviBar()
        setupCollectionView()
        setupButton()
    }
    
    // MARK: - 초기 설정
    private func updateUI() {
        loadUserData()
        
        if currentTab == .recommend { // 추천
            loadRecommendData()
        } else if currentTab == .combination { // 오늘의 조합
            loadCombinationData()
        } else { // 레시피북
            //            loadRecipeBookData()
        }
    }
    
    // 유저 데이터 로딩 후 업데이트 & 설정창에 프로필이미지, 닉네임 넘겨주기
    private func loadUserData() {
        MyPageDataManager().fetchUserData(self) { [weak self] model in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let urlString = model?.result.profileImageUrl {
                    self.settingViewController.profileImageUrl = urlString
                    let url = URL(string: urlString)
                    self.myPageView.profileImage.kf.setImage(with: url)
                }
                
                self.myPageView.nameLabel.text = model?.result.nickName
                self.settingViewController.nickName = model?.result.nickName
            }
        }
    }
    
    // 추천 받은 조합 데이터 로딩
    private func loadRecommendData() {
        let input = MyPageInput.fetchRecommendListDataInput(page: 0, size: 30)
        MyPageDataManager().fetchRecommendListData(input, self) { [weak self] model in
            guard let self = self else { return }
            
            if let model = model {
                self.arrayRecommendData = model.result.recommendResponseDTOList
                DispatchQueue.main.async {
                    self.myPageView.myPageLowerView.collectionView.reloadData()
                }
            }
            
        }
    }
    
    // 내가 작성한 오늘의 조합 데이터 로딩
    private func loadCombinationData() {
        let input = MyPageInput.fetchCombinationDataInput(page: 0)
        MyPageDataManager().fetchCombinationData(input, self) { [weak self] model in
            guard let self = self else { return }
            
            if let model = model {
                self.arrayCombinationData = model.result.combinationList
                DispatchQueue.main.async {
                    self.myPageView.myPageLowerView.collectionView.reloadData()
                }
            }
        }
    }
    
    // 내가 작성한 레시피북 데이터 로딩
    private func loadRecipeBookData() {
        let input = MyPageInput.fetchRecipeBookDataInput(page: 0)
        MyPageDataManager().fetchRecipeBookData(input, self) { [weak self] model in
            guard let self = self else { return }
            
            if let model = model {
                self.arrayRecipeBookData = model.result.recipeList
                DispatchQueue.main.async {
                    self.myPageView.myPageLowerView.collectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: - 네비게이션바 설정
    func setupNaviBar() {
        title = "마이페이지"
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let customBackImage = UIImage(named: "ic_back")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = customBackImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = customBackImage
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // 설정 버튼 생성
        let settingButton = UIBarButtonItem (image: UIImage(named: "ic_setting")?.withRenderingMode(.alwaysOriginal),
                                             style: .plain,
                                             target: self,
                                             action: #selector(settingButtonTapped))
        
        // 네비게이션 바 오른쪽 아이템으로 설정 버튼 추가
        navigationItem.rightBarButtonItem = settingButton
    }
    
    @objc func settingButtonTapped() {
        let VC = settingViewController
        navigationController?.pushViewController(VC, animated: true)
    }
    
    // MARK: - 컬렌션뷰 설정
    func setupCollectionView() {
        let cv = myPageView.myPageLowerView.collectionView
        cv.dataSource = self
        cv.delegate = self
        
        cv.register(MyPageCell.self, forCellWithReuseIdentifier: "MyPageCell")
    }
    
    // MARK: - 버튼 설정
    func setupButton() {
        myPageView.myPageLowerView.recommendButton.addTarget(self, action: #selector(recommendButtonTapped), for: .touchUpInside)
        myPageView.myPageLowerView.combinationButton.addTarget(self, action: #selector(combinationButtonTapped), for: .touchUpInside)
        myPageView.myPageLowerView.recipeBookButton.addTarget(self, action: #selector(recipeBookButtonTapped), for: .touchUpInside)
    }
    
    @objc func recommendButtonTapped() { // 추천
        currentTab = .recommend
        
        myPageView.myPageLowerView.recommendLabel.textColor = .black
        myPageView.myPageLowerView.leftLine.backgroundColor = .orange
        
        myPageView.myPageLowerView.combinationLabel.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        myPageView.myPageLowerView.recipeBookLabel.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        
        myPageView.myPageLowerView.centerLine.backgroundColor = .clear
        myPageView.myPageLowerView.rightLine.backgroundColor = .clear
        
        loadRecommendData()
        
    }
    
    @objc func combinationButtonTapped() { // 오늘의 조합
        currentTab = .combination
        
        myPageView.myPageLowerView.combinationLabel.textColor = .black
        myPageView.myPageLowerView.centerLine.backgroundColor = .orange
        
        myPageView.myPageLowerView.recommendLabel.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        myPageView.myPageLowerView.recipeBookLabel.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        
        myPageView.myPageLowerView.leftLine.backgroundColor = .clear
        myPageView.myPageLowerView.rightLine.backgroundColor = .clear
        
        loadCombinationData()
        
    }
    
    @objc func recipeBookButtonTapped() { // 레시피북
        currentTab = .recipeBook
        
        myPageView.myPageLowerView.recipeBookLabel.textColor = .black
        myPageView.myPageLowerView.rightLine.backgroundColor = .orange
        
        myPageView.myPageLowerView.recommendLabel.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        myPageView.myPageLowerView.combinationLabel.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        
        myPageView.myPageLowerView.leftLine.backgroundColor = .clear
        myPageView.myPageLowerView.centerLine.backgroundColor = .clear
        
        loadRecipeBookData()
        
    }
    
}

// MARK: - UICollectionViewDataSource
extension MyPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch currentTab {
        case .recommend:
            return arrayRecommendData.count
        case .combination:
            return arrayCombinationData.count
        case .recipeBook:
            return arrayRecipeBookData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPageCell", for: indexPath) as! MyPageCell
        
        switch currentTab {
        case .recommend: // 추천
            let recommend = arrayRecommendData[indexPath.item]
            if let url = URL(string: recommend.imageUrl) {
                cell.mainImage.kf.setImage(with: url)
            }
            cell.mainLabel.text = "\(recommend.foodName) & \(recommend.drinkName)"
            
        case .combination: // 오늘의 조합
            let combination = arrayCombinationData[indexPath.item]
            if let url = URL(string: combination.combinationImageUrl) {
                cell.mainImage.kf.setImage(with: url)
            }
            cell.mainLabel.text = "\(combination.title)"
            
        case .recipeBook: // 레시피북
            let recipeBook = arrayRecipeBookData[indexPath.item]
            if let url = URL(string: recipeBook.recipeImageUrl) {
                cell.mainImage.kf.setImage(with: url)
            }
            cell.mainLabel.text = "\(recipeBook.name)"
        }
        return cell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 3
        let paddingWidth = itemsPerRow - 1
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    // 셀 선택
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if currentTab == .combination { // 오늘의 조합
            let selectedItem = arrayCombinationData[indexPath.row].combinationId
            let todayCombinationDetailVC = CombinationDetailViewController()
            todayCombinationDetailVC.combinationId = selectedItem
            todayCombinationDetailVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(todayCombinationDetailVC, animated: true)
        } else if currentTab == .recipeBook { // 레시피북
            let selectedItem = arrayRecipeBookData[indexPath.row].id
            let recipeBookDetailVC = RecipeBookDetailViewController()
            recipeBookDetailVC.recipeBookId = selectedItem
            recipeBookDetailVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(recipeBookDetailVC, animated: true)
        } else if currentTab == .recommend { // 추천
            let selectedItem = arrayRecommendData[indexPath.row].recommendID
            MyPageDataManager().fetchRecommendDetailData(selectedItem, self) { model in
                guard let model = model else { return }
                
//                let getDrinkingRecommendVC = GetDrinkingRecommendViewController()
//                
//                if let url = URL(string: model.result.imageUrl) {
//                    getDrinkingRecommendVC.mainImage.kf.setImage(with: url)
//                }
//                getDrinkingRecommendVC.drinkNameLabel.text = model.result.drinkName
//                getDrinkingRecommendVC.descriptionLabel.text = model.result.recommendReason
//                self.navigationController?.pushViewController(getDrinkingRecommendVC, animated: true)
            }
            
        }
    }
    
}
