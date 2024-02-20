//
//  LikeViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/17/24.
//

import UIKit

class LikeViewController: UIViewController {
    // MARK: - Properties
    var isleftButton: Bool = true
    
    var arrayLikeAllCombination: [LikeAllCombinationModel.CombinationList] = []
    var arrayLikeAllRecipeBook: [LikeAllRecipeBookModel.RecipeList] = []
    
    let likeView = LikeView()
    
    // MARK: - View 설정
    override func loadView() {
        view = likeView
    }
    
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
        if isleftButton { // 오늘의 조합
            loadCombinationData()
        } else { // 레시피북
            loadRecipeBookData()
        }
    }
    
    // 오늘의 조합 데이터 로딩
    private func loadCombinationData() {
        let input = LikeInput(page: 0)
        LikeDataManager().fetchLikeAllCombinationData(input, self) { [weak self] model in
            guard let self = self else { return }
            
            if let model = model {
                self.arrayLikeAllCombination = model.result.combinationList
                DispatchQueue.main.async {
                    self.likeView.collectionView.reloadData()
                }
            }
        }
    }
    
    // 레시피북 데이터 로딩
    private func loadRecipeBookData() {
        let input = LikeInput(page: 0)
        LikeDataManager().fetchLikeAllRecipeBookData(input, self) { [weak self] model in
            guard let self = self else { return }
            
            if let model = model {
                self.arrayLikeAllRecipeBook = model.result.recipeList
                DispatchQueue.main.async {
                    self.likeView.collectionView.reloadData()
                }
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
        isleftButton = true
        arrayLikeAllCombination = []
        
        likeView.recipeBookLabel.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        likeView.combinationLabel.textColor = .black
        likeView.rightLine.backgroundColor = .clear
        likeView.leftLine.backgroundColor = .customOrange
        
        self.loadCombinationData()
    }
    
    @objc func recipeBookButtonTapped() {
        isleftButton = false
        arrayLikeAllRecipeBook = []
        
        likeView.recipeBookLabel.textColor = .black
        likeView.combinationLabel.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        likeView.rightLine.backgroundColor = .customOrange
        likeView.leftLine.backgroundColor = .clear
        
        self.loadRecipeBookData()
    }
    
}

// MARK: - UICollectionViewDataSource
extension LikeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isleftButton { // 오늘의 조합
            return arrayLikeAllCombination.count
        } else { // 레시피북
            return arrayLikeAllRecipeBook.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeCell", for: indexPath) as! LikeCell
        
        if isleftButton { // 오늘의 조합
            let combination = arrayLikeAllCombination[indexPath.item]
            if let url = URL(string: combination.combinationImageUrl ?? "defualtImage") {
                cell.mainImage.kf.setImage(with: url)
            } // 레시피북
            cell.mainLabel.text = arrayLikeAllCombination[indexPath.item].title
        } else {
            let recipeBook = arrayLikeAllRecipeBook[indexPath.item]
            if let url = URL(string: recipeBook.recipeImageUrl ?? "defualtImage") {
                cell.mainImage.kf.setImage(with: url)
            }
            cell.mainLabel.text = arrayLikeAllRecipeBook[indexPath.item].name
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
        
        if isleftButton { // 오늘의 조합
            let selectedItem = arrayLikeAllCombination[indexPath.row].combinationId
            let todayCombinationDetailVC = TodayCombinationDetailViewController()
            todayCombinationDetailVC.combinationId = selectedItem
            todayCombinationDetailVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(todayCombinationDetailVC, animated: true)
        } else { // 레시피북
            let selectedItem = arrayLikeAllRecipeBook[indexPath.row].id
            let recipeBookDetailVC = RecipeBookDetailVC()
            recipeBookDetailVC.recipeBookId = selectedItem
            recipeBookDetailVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(recipeBookDetailVC, animated: true)
        }
        
    }
}
