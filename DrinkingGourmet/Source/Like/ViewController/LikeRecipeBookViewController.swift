//
//  LikeRecipeBookViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/5/24.
//

import UIKit

class LikeRecipeBookViewController: UIViewController {
    // MARK: - Properties
    private var likeRecipeBooks: [LikeRecipeBookDTO] = []
    
    let likeView = LikeView()
    
    // MARK: - View 설정
    override func loadView() {
        view = likeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        setupRefresh()
        setupCollectionView()
    }
    
    func fetchData() {
        LikeService.shared.getRecipeBook(page: 0) { result in
            switch result {
            case .success(let data):
                print("좋아요한 레시피북 조회 성공")
                self.likeRecipeBooks = data.result.recipeList
                DispatchQueue.main.async {
                    self.likeView.collectionView.reloadData()
                }
            case .failure(let error):
                print("좋아요한 레시피북 조회 실패 - \(error.localizedDescription)")
            }
        }
    }
    
    private func setupRefresh() {
        let rc = likeView.refreshControl
        rc.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        rc.tintColor = .customOrange
        
        likeView.collectionView.refreshControl = rc
    }
    
    private func setupCollectionView() {
        let cv = likeView.collectionView
        cv.dataSource = self
        cv.delegate = self
        
        cv.register(LikeCell.self, forCellWithReuseIdentifier: "LikeCell")
    }
    
}

// MARK: - Actions
extension LikeRecipeBookViewController {
    // 새로고침
    @objc func refreshTable(refresh: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.fetchData()
            refresh.endRefreshing()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension LikeRecipeBookViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.likeRecipeBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeCell", for: indexPath) as! LikeCell
        
        let data = self.likeRecipeBooks[indexPath.item]
        
        if let url = URL(string: data.recipeImageUrl) {
            cell.thumbnailimage.kf.setImage(with: url)
        }
        
        cell.titleLabel.text = data.name
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LikeRecipeBookViewController: UICollectionViewDelegateFlowLayout {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedRecipebBookId = likeRecipeBooks[indexPath.row].id
        let VC = RecipeBookDetailViewController()
        VC.recipeBookId = selectedRecipebBookId
        VC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(VC, animated: true)
    }
}
