//
//  LikeViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/17/24.
//

import UIKit

enum LikeType {
    case todayCombination
    case recipeBook
}

final class LikeViewController: UIViewController {
    // MARK: - Properties
    private var likeType: LikeType = .todayCombination
    private var arrayLikeAllCombination: [LikeCombinationDTO] = []
    private var arrayLikeAllRecipeBook: [LikeRecipeBookDTO] = []
    
    private let likeView = LikeView()
    
    // MARK: - View 설정
    override func loadView() {
        view = likeView
    }
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNaviBar()
        setupRefresh()
        setupCollectionView()
        setupButton()
    }
    
    // MARK: - 초기 설정
    private func updateUI() {
        switch likeType {
        case .todayCombination:
            loadCombinationData()
        case .recipeBook:
            loadRecipeBookData()
        }
    }
    
    // 오늘의 조합 데이터 로딩
    private func loadCombinationData() {
        LikeService.shared.getCombination(page: 0) { result in
            switch result {
            case .success(let data):
                print("좋아요한 오늘의 조합 조회 성공")
                self.arrayLikeAllCombination = data.result.combinationList
                DispatchQueue.main.async {
                    self.likeView.collectionView.reloadData()
                }
            case .failure(let error):
                print("좋아요한 오늘의 조합 조회 실패 - \(error.localizedDescription)")
            }
        }
    }
    
    // 레시피북 데이터 로딩
    private func loadRecipeBookData() {
        LikeService.shared.getRecipeBook(page: 0) { result in
            switch result {
            case .success(let data):
                print("좋아요한 레시피북 조회 성공")
                self.arrayLikeAllRecipeBook = data.result.recipeList
                DispatchQueue.main.async {
                    self.likeView.collectionView.reloadData()
                }
            case .failure(let error):
                print("좋아요한 레시피북 조회 실패 - \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - 네비게이션바 설정
    func setupNaviBar() {
        title = "좋아요"
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let customBackImage = UIImage(named: "ic_back")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = customBackImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = customBackImage
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupRefresh() {
        let rc = likeView.refreshControl
        rc.addTarget(self, action: #selector(refreshCollectionView(refresh:)), for: .valueChanged)
        rc.tintColor = .customOrange
        
        likeView.collectionView.refreshControl = rc
    }
    
    // MARK: - 컬렌션뷰 설정
    func setupCollectionView() {
        let cv = likeView.collectionView
        cv.dataSource = self
        cv.delegate = self
        
        cv.register(LikeCell.self, forCellWithReuseIdentifier: "LikeCell")
    }
    
    // MARK: - 버튼 설정
    func setupButton() {
        likeView.combinationButton.addTarget(self, action: #selector(combinationButtonTapped), for: .touchUpInside)
        likeView.recipeBookButton.addTarget(self, action: #selector(recipeBookButtonTapped), for: .touchUpInside)
    }
    
    @objc func combinationButtonTapped() {
        likeType = .todayCombination
        arrayLikeAllCombination = []
        
        likeView.recipeBookLabel.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        likeView.combinationLabel.textColor = .black
        likeView.rightLine.backgroundColor = .clear
        likeView.leftLine.backgroundColor = .customOrange
        
        self.loadCombinationData()
    }
    
    @objc func recipeBookButtonTapped() {
        likeType = .recipeBook
        arrayLikeAllRecipeBook = []
        
        likeView.recipeBookLabel.textColor = .black
        likeView.combinationLabel.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        likeView.rightLine.backgroundColor = .customOrange
        likeView.leftLine.backgroundColor = .clear
        
        self.loadRecipeBookData()
    }
    
    // 새로고침
    @objc func refreshCollectionView(refresh: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.updateUI()
            refresh.endRefreshing()
        }
    }
    
}

// MARK: - UICollectionViewDataSource
extension LikeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch likeType {
        case .todayCombination:
            return arrayLikeAllCombination.count
        case .recipeBook:
            return arrayLikeAllRecipeBook.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeCell", for: indexPath) as! LikeCell
        
        switch likeType {
        case .todayCombination:
            let combination = arrayLikeAllCombination[indexPath.item]
            if let url = URL(string: combination.combinationImageUrl ?? "defualtImage") {
                cell.mainImage.kf.setImage(with: url)
            }
            cell.mainLabel.text = combination.title
        case .recipeBook:
            let recipeBook = arrayLikeAllRecipeBook[indexPath.item]
            if let url = URL(string: recipeBook.recipeImageUrl ?? "defualtImage") {
                cell.mainImage.kf.setImage(with: url)
            }
            cell.mainLabel.text = recipeBook.name
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LikeViewController: UICollectionViewDelegateFlowLayout {
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
        switch likeType {
        case .todayCombination: // 오늘의 조합
            let selectedItem = arrayLikeAllCombination[indexPath.row].combinationId
            let todayCombinationDetailVC = CombinationDetailViewController()
            todayCombinationDetailVC.combinationId = selectedItem
            todayCombinationDetailVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(todayCombinationDetailVC, animated: true)
            
        case .recipeBook: // 레시피북
            let selectedItem = arrayLikeAllRecipeBook[indexPath.row].id
            let recipeBookDetailVC = RecipeBookDetailViewController()
            recipeBookDetailVC.recipeBookId = selectedItem
            recipeBookDetailVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(recipeBookDetailVC, animated: true)
        }
    }
}
