//
//  MyCombinationViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/5/24.
//

import UIKit

class MyCombinationViewController: UIViewController {
    // MARK: - Properties
    private var myCombinations: [MyCombinationDTO] = []
    
    let myCombinationView = LikeView()
    
    // MARK: - View 설정
    override func loadView() {
        view = myCombinationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        setupRefresh()
        setupCollectionView()
    }
    
    private func fetchData() {
        MyPageService.shared.getMyCombination(page: 0) { result in
            switch result {
            case .success(let data):
                print("나의 오늘의 조합 조회 성공")
                self.myCombinations = data.result.combinationList
                DispatchQueue.main.async {
                    self.myCombinationView.collectionView.reloadData()
                }
            case .failure(let error):
                print("나의 오늘의 조합 조회 실패 - \(error.localizedDescription)")
            }
        }
    }
    
    private func setupRefresh() {
        let rc = myCombinationView.refreshControl
        rc.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        rc.tintColor = .customOrange
        
        myCombinationView.collectionView.refreshControl = rc
    }
    
    private func setupCollectionView() {
        let cv = myCombinationView.collectionView
        cv.dataSource = self
        cv.delegate = self
        
        cv.register(LikeCell.self, forCellWithReuseIdentifier: "LikeCell")
    }
    
}

// MARK: - Actions
extension MyCombinationViewController {
    // 새로고침
    @objc func refreshTable(refresh: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.fetchData()
            refresh.endRefreshing()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MyCombinationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myCombinations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeCell", for: indexPath) as! LikeCell
        
        let data = self.myCombinations[indexPath.item]
        
        if let url = URL(string: data.combinationImageUrl) {
            cell.thumbnailimage.kf.setImage(with: url)
        }
        
        cell.titleLabel.text = data.title
        cell.heartIcon.isHidden = true
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MyCombinationViewController: UICollectionViewDelegateFlowLayout {
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
        let selectedCombinationId = myCombinations[indexPath.row].combinationId
        let VC = CombinationDetailViewController()
        VC.combinationId = selectedCombinationId
        VC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(VC, animated: true)
    }
}
