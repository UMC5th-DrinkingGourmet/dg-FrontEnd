//
//  RecipeBookDetailVC.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

final class RecipeBookDetailVC: UIViewController {
    
    // MARK: - Properties
    private let recipeBookDetailView = RecipeBookDetailView()
    
    private var isLiked = false

    // MARK: - View 설정
    override func loadView() {
        view = recipeBookDetailView
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepare()
        setupImageCollectionView()
        setupPageControl()
        configureLikeIconButton()
        configureMoreButton()
        configureCommentMoreButton()
        setupCommentsInputView()
    }
    
    func prepare() {
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    @objc func endEditing(){
        view.endEditing(true)
    }
    
    // MARK: - 이미지 컬렉션뷰 설정
    func setupImageCollectionView() {
        let imageCV = recipeBookDetailView.imageCollectionView
        imageCV.delegate = self
        imageCV.dataSource = self
        imageCV.register(RecipeBookDetailCell.self, forCellWithReuseIdentifier: "RecipeBookDetailCell")
        
        // 이미지 컬렌션뷰 터치 시 키보드 내림
        imageCV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    // MARK: - 페이지컨트롤 설정
    func setupPageControl() {
        let pc = recipeBookDetailView.pageControl
        pc.numberOfPages = 3
    }
    
    // MARK: - 좋아요 아이콘 버튼 설정
    func configureLikeIconButton() {
        let bt = recipeBookDetailView.likeIconButton
        bt.addTarget(self, action: #selector(likeIconButtonTapped), for: .touchUpInside)
    }
    
    @objc func likeIconButtonTapped() {
        isLiked.toggle()
        let imageName = isLiked ? "ic_like_selected" : "ic_like"
        recipeBookDetailView.likeIconButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    // MARK: - 게시글 삭제/수정 버튼 설정
    func configureMoreButton() {
        let bt = recipeBookDetailView.moreButton
        bt.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }
    
    @objc func moreButtonTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let removeAction = UIAlertAction(title: "삭제하기", style: .destructive, handler: nil)
        let modifyAction = UIAlertAction(title: "수정하기", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(removeAction)
        alert.addAction(modifyAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - 댓글 삭제/수정 버튼 설정
    func configureCommentMoreButton() {
        for commentView in recipeBookDetailView.commentAreaView.commentsView.arrangedSubviews.compactMap({ $0 as? CommentView }) {
                commentView.moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
            }
    }
    
    // MARK: - 댓글입력창 설정
    func setupCommentsInputView() {
        let commentsInputView = recipeBookDetailView.commentsInputView
        commentsInputView.textField.delegate = self
        commentsInputView.button.addTarget(self, action: #selector(commentsInputButtonTapped), for: .touchUpInside)
    }
    
    @objc func commentsInputButtonTapped() {
        print("레시피북 댓글입력창 버튼 눌림")
    }
    
}

extension RecipeBookDetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeBookDetailCell", for: indexPath) as! RecipeBookDetailCell

        return cell
    }
}

extension RecipeBookDetailVC: UICollectionViewDelegateFlowLayout {
    
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

extension RecipeBookDetailVC: UICollectionViewDelegate {
    
}

extension RecipeBookDetailVC: UIScrollViewDelegate {
    
    // 이미지 컬렉션뷰 스크롤 시 키보드 내림
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    // 페이지컨트롤 업데이트
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / recipeBookDetailView.imageCollectionView.bounds.width)
        recipeBookDetailView.pageControl.currentPage = index
    }
}

// MARK: - 댓글입력창
extension RecipeBookDetailVC: UITextFieldDelegate {
    
    // 리턴 클릭 시 키보드 내림
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - 댓글입력창 눌렀을 때 텍스트필드 가려짐 해결
extension RecipeBookDetailVC {
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardUp(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            let safeAreaBottomInset = view.safeAreaInsets.bottom
            let distanceToMove = keyboardHeight - safeAreaBottomInset // 키보드가 뷰를 가리는 거리

            UIView.animate(withDuration: 0.3) {
                // Safe Area를 고려하여 뷰의 위치를 조정
                self.view.transform = CGAffineTransform(translationX: 0, y: -distanceToMove)
            }
        }
    }

    @objc func keyboardDown() {
        UIView.animate(withDuration: 0.3) {
            // 키보드가 사라질 때는 다시 원래 위치로 복원
            self.view.transform = .identity
        }
    }

}
