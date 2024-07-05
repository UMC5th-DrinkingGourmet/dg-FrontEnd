//
//  MyRecipeBookViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/5/24.
//

import UIKit

class MyRecipeBookViewController: UIViewController {
    // MARK: - Properties
    private var myRecipeBooks: [MyRecipeBookDTO] = []
    
    let myRecipeBookView = LikeView()
    
    // MARK: - View 설정
    override func loadView() {
        view = myRecipeBookView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        setupRefresh()
        setupCollectionView()
    }
    
    private func fetchData() {
        MyPageService.shared.getMyRecipeBook(page: 0) { result in
            switch result {
            case .success(let data):
                print("나의 레시피북 조회 성공")
                self.myRecipeBooks = data.result.recipeList
                DispatchQueue.main.async {
                    self.myRecipeBookView.collectionView.reloadData()
                }
            case .failure(let error):
                print("나의 레시피북 조회 실패 - \(error.localizedDescription)")
            }
        }
    }
    
    private func setupRefresh() {
        let rc = myRecipeBookView.refreshControl
        rc.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        rc.tintColor = .customOrange
        
        myRecipeBookView.collectionView.refreshControl = rc
    }
    
    private func setupCollectionView() {
        let cv = myRecipeBookView.collectionView
        cv.dataSource = self
        cv.delegate = self
        
        cv.register(LikeCell.self, forCellWithReuseIdentifier: "LikeCell")
    }
    
}

// MARK: - Actions
extension MyRecipeBookViewController {
    // 새로고침
    @objc func refreshTable(refresh: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.fetchData()
            refresh.endRefreshing()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MyRecipeBookViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myRecipeBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeCell", for: indexPath) as! LikeCell
        
        let data = self.myRecipeBooks[indexPath.item]
        
        if let url = URL(string: data.recipeImageUrl) {
            cell.thumbnailimage.kf.setImage(with: url)
        }
        
        cell.titleLabel.text = data.name
        cell.heartIcon.isHidden = true
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MyRecipeBookViewController: UICollectionViewDelegateFlowLayout {
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
        let selectedRecipeBookId = myRecipeBooks[indexPath.row].id
        let VC = RecipeBookDetailViewController()
        VC.recipeBookId = selectedRecipeBookId
        VC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(VC, animated: true)
    }
}
