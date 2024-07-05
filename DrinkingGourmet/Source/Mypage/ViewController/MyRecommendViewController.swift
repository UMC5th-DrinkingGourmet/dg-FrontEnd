//
//  MyRecommendViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/5/24.
//

import UIKit

class MyRecommendViewController: UIViewController {
    // MARK: - Properties
    private var myRecommends: [RecommendResultDTO] = []
    
    let myRecommendView = LikeView()
    
    // MARK: - View 설정
    override func loadView() {
        view = myRecommendView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        setupRefresh()
        setupCollectionView()
    }
    
    private func fetchData() {
        MyPageService.shared.getMyRecommend(page: 0, 
                                            size: 21) { result in
            switch result {
            case .success(let data):
                print("나의 주류 추천 조회 성공")
                self.myRecommends = data.result.recommendResponseDTOList
                DispatchQueue.main.async {
                    self.myRecommendView.collectionView.reloadData()
                }
            case .failure(let error):
                print("나의 주류 추천 조회 실패 - \(error.localizedDescription)")
            }
        }
    }
    
    private func setupRefresh() {
        let rc = myRecommendView.refreshControl
        rc.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        rc.tintColor = .customOrange
        
        myRecommendView.collectionView.refreshControl = rc
    }
    
    private func setupCollectionView() {
        let cv = myRecommendView.collectionView
        cv.dataSource = self
        cv.delegate = self
        
        cv.register(LikeCell.self, forCellWithReuseIdentifier: "LikeCell")
    }
    
}

// MARK: - Actions
extension MyRecommendViewController {
    // 새로고침
    @objc func refreshTable(refresh: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.fetchData()
            refresh.endRefreshing()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MyRecommendViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myRecommends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeCell", for: indexPath) as! LikeCell
        
        let data = self.myRecommends[indexPath.item]
        
        if let url = URL(string: data.imageUrl) {
            cell.thumbnailimage.kf.setImage(with: url)
        }
        
        cell.titleLabel.text = "\(data.foodName) & \(data.drinkName)"
        cell.heartIcon.isHidden = true
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MyRecommendViewController: UICollectionViewDelegateFlowLayout {
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
        let VC = RecommendResultViewController()
        VC.recommendResult = myRecommends[indexPath.row]
        VC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(VC, animated: true)
    }
}
