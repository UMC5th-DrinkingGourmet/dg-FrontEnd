//
//  TodayCombinationDetailViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 1/18/24.
//

import UIKit

class TodayCombinationDetailViewController: UIViewController {
    
    private let todayCombinationDetailView = TodayCombinationDetailView()
    
    private var isLiked = false

    // MARK: - View 설정
    override func loadView() {
        view = todayCombinationDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupImageCollectionView()
        setupPageControl()
        configureLikeButton()
    }
    
    // MARK: - 이미지 컬렉션뷰 설정
    func setupImageCollectionView() {
        let imageCV = todayCombinationDetailView.imageCollectionView
        imageCV.delegate = self
        imageCV.dataSource = self
        imageCV.register(TodayCombinationDetailCell.self, forCellWithReuseIdentifier: "TodayCombinationDetailCell")
    }
    
    // MARK: - 페이지컨트롤 설정
    func setupPageControl() {
        let pc = todayCombinationDetailView.pageControl
        pc.numberOfPages = 5
    }
    
    // MARK: - 좋아요 버튼 설정
    func configureLikeButton() {
        todayCombinationDetailView.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        let imageName = isLiked ? "ic_like_selected" : "ic_like"
        todayCombinationDetailView.likeButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    @objc func likeButtonTapped() {
        isLiked.toggle()
        
        let imageName = isLiked ? "ic_like_selected" : "ic_like"
        todayCombinationDetailView.likeButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
}

extension TodayCombinationDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayCombinationDetailCell", for: indexPath) as! TodayCombinationDetailCell

        return cell
    }
}

extension TodayCombinationDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}

extension TodayCombinationDetailViewController: UICollectionViewDelegate {
    
}

// MARK: - 페이지컨트롤 업데이트
extension TodayCombinationDetailViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / todayCombinationDetailView.imageCollectionView.bounds.width)
        todayCombinationDetailView.pageControl.currentPage = index
    }
}
