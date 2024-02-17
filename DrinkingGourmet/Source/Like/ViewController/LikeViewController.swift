//
//  LikeViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/17/24.
//

import UIKit

class LikeViewController: UIViewController {
    // MARK: - Properties
    var totalPageNum: Int = 0
    
    var arrayLikeAllCombination: [LikeAllCombinationModel.CombinationList] = []
    var arrayLikeAllRecipeBook: [LikeAllRecipeBookModel.RecipeList] = []
    
    let likeView = LikeView()
    
    // MARK: - View 설정
    override func loadView() {
        view = likeView
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        prepare()
        setupNaviBar()
        setupCollectionView()
        setupButton()
    }
    
    // MARK: - 초기 설정
    func prepare() {
        let input = LikeInput(page: 0)
        LikeDataManager().fetchLikeAllCombinationData(input, self) { [weak self] model in
            guard let self = self else { return }
            
            if let model = model {
                self.totalPageNum = model.result.totalPage
                self.arrayLikeAllCombination = model.result.combinationList
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
        likeView.recipeBookLabel.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        likeView.combinationLabel.textColor = .black
        likeView.rightLine.backgroundColor = .clear
        likeView.leftLine.backgroundColor = .customOrange
        prepare()
    }
    
    @objc func recipeBookButtonTapped() {
        likeView.recipeBookLabel.textColor = .black
        likeView.combinationLabel.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        likeView.rightLine.backgroundColor = .customOrange
        likeView.leftLine.backgroundColor = .clear
    }
    
}

// MARK: - UICollectionViewDataSource
extension LikeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeCell", for: indexPath) as! LikeCell
        
        let combination = arrayLikeAllCombination[indexPath.item]
        if let url = URL(string: combination.combinationImageUrl) {
            cell.mainImage.kf.setImage(with: url)
        }
        
        cell.mainLabel.text = arrayLikeAllCombination[indexPath.item].title
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayLikeAllCombination.count
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
        let selectedItem = arrayLikeAllCombination[indexPath.row].combinationId
        
        let todayCombinationDetailVC = TodayCombinationDetailViewController()
        todayCombinationDetailVC.combinationId = selectedItem
        navigationController?.pushViewController(todayCombinationDetailVC, animated: true)
    }
}
