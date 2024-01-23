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
        
        setup()
        setupImageCollectionView()
        setupPageControl()
        configureCommetButton()
        configureLikeButton()
        setupCommentsInputView()
    }
    
    func setup() {
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    @objc func endEditing(){
        view.endEditing(true)
    }
    
    // MARK: - 이미지 컬렉션뷰 설정
    func setupImageCollectionView() {
        let imageCV = todayCombinationDetailView.imageCollectionView
        imageCV.delegate = self
        imageCV.dataSource = self
        imageCV.register(TodayCombinationDetailCell.self, forCellWithReuseIdentifier: "TodayCombinationDetailCell")
        
        // 이미지 컬렌션뷰 터치 시 키보드 내림
        imageCV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    // MARK: - 페이지컨트롤 설정
    func setupPageControl() {
        let pc = todayCombinationDetailView.pageControl
        pc.numberOfPages = 5
    }
    
    // MARK: - 댓글 버튼 설정
    func configureCommetButton() {
        let bt = todayCombinationDetailView.commentButton
        bt.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
    }
    
    @objc func commentButtonTapped() {
        print("댓글창으로 이동")
    }
    
    // MARK: - 좋아요 버튼 설정
    func configureLikeButton() {
        let bt = todayCombinationDetailView.likeButton
        bt.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    @objc func likeButtonTapped() {
        isLiked.toggle()
        let imageName = isLiked ? "ic_like_selected" : "ic_like"
        todayCombinationDetailView.likeButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    // MARK: - 댓글입력창 설정
    func setupCommentsInputView() {
        let commentsInputView = todayCombinationDetailView.commentsInputView
        commentsInputView.textField.delegate = self
        commentsInputView.button.addTarget(self, action: #selector(commentsInputButtonTapped), for: .touchUpInside)
    }
    
    @objc func commentsInputButtonTapped() {
        print("댓글입력창 버튼 눌림")
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

extension TodayCombinationDetailViewController: UIScrollViewDelegate {
    
    // 이미지 컬렉션뷰 스크롤 시 키보드 내림
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    // 페이지컨트롤 업데이트
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / todayCombinationDetailView.imageCollectionView.bounds.width)
        todayCombinationDetailView.pageControl.currentPage = index
    }
}

// MARK: - 댓글입력창
extension TodayCombinationDetailViewController: UITextFieldDelegate {
    
    // 리턴 클릭 시 키보드 내림
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
