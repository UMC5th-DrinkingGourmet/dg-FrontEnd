//
//  RecipeBookDetailVC.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

final class RecipeBookDetailVC: UIViewController {
    
    // MARK: - Properties
    var selectedIndex: Int?
    var isLiked = false
    
    var recipeBookId: Int?
    var fetchingMore: Bool = false
    var totalPageNum: Int = 0
    var nowPageNum: Int = 0
    var commentsNum: Int = 0
    
    var recipeBookDetailData: RecipeBookDetailModel?
    var arrayRecipeBookComment: [RecipeBookCommentModel.CommentList] = []
    
    private let recipeBookDetailView = RecipeBookDetailView()

    // MARK: - View 설정
    override func loadView() {
        view = recipeBookDetailView
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepare()
        setupImageCollectionView()
        configureLikeIconButton()
        configureMoreButton()
        configureCommentMoreButton()
        setupCommentsInputView()
    }
    
    // 뒤로가기 할 때
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            guard let navigationController = navigationController,
                  let RecipeBookHomeVC = navigationController.viewControllers.last as? RecipeBookHomeVC,
                  let selectedIndex = selectedIndex else {
                return
            }
            RecipeBookHomeVC.arrayRecipeBookHome[selectedIndex].like = isLiked // 좋아요 상태 업데이트
            RecipeBookHomeVC.recipeBookHomeView.tableView.reloadRows(at: [IndexPath(row: selectedIndex, section: 0)], with: .none) // 해당 셀만 리로드
        }
    }
    
    func prepare() {
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
        
        recipeBookDetailView.scrollView.delegate = self
        
        if let recipeBookId = self.recipeBookId {
            RecipeBookDetailDataManager().fetchRecipeBookDetailData(recipeBookId, self) { [weak self] detailModel in
                guard let self = self else { return }
                self.recipeBookDetailData = detailModel
                
                let recipeBookCommentInput = RecipeBookCommentInput.fetchRecipeBookCommentDataInput(page: 0)
                RecipeBookDetailDataManager().fetchRecipeBookCommentData(recipeBookId, recipeBookCommentInput, self) { commentModel in
                    if let commentModel = commentModel {
                        self.totalPageNum = commentModel.result.totalPage
                        self.commentsNum = commentModel.result.totalElements
                        self.arrayRecipeBookComment = commentModel.result.commentList
                        DispatchQueue.main.async {
                            self.updateUIWithData()
                        }
                    }
                }
            }
        }
    }

    
    @objc func endEditing(){
        view.endEditing(true)
    }
    
    // MARK: - 네트워킹 후 UI 업데이트
    func updateUIWithData() {
        self.recipeBookDetailView.imageCollectionView.reloadData()
        
        guard let recipeBookDetailData = recipeBookDetailData else { return }
        
        if recipeBookDetailData.result.member.nickName == UserDefaultManager.shared.userNickname {
            self.recipeBookDetailView.moreButton.isHidden = false
        }

        if let urlString = recipeBookDetailData.result.member.profileImageUrl {
            let url = URL(string: urlString)
            self.recipeBookDetailView.profileImage.kf.setImage(with: url)
        }
        
        self.recipeBookDetailView.pageControl.numberOfPages = recipeBookDetailData.result.recipeImageList.count
        
        self.recipeBookDetailView.userNameLabel.text = "\(recipeBookDetailData.result.member.nickName) 님의 레시피"
        
        if recipeBookDetailData.result.like == true {
            self.isLiked = true
            self.recipeBookDetailView.likeIconButton.setImage(UIImage(named: "ic_like_selected"), for: .normal)
        }
        
        self.recipeBookDetailView.hashtagLabel.text = recipeBookDetailData.result.hashTagNameList.map { "\($0)" }.joined(separator: " ")
        
        self.recipeBookDetailView.titleLabel.text = recipeBookDetailData.result.title

        self.recipeBookDetailView.recipeBookDetailInfoView.timeNumLabel.text = recipeBookDetailData.result.cookingTime
        
        self.recipeBookDetailView.recipeBookDetailInfoView.kcalNumLabel.text = recipeBookDetailData.result.calorie
        
        self.recipeBookDetailView.recipeBookDetailInfoView.likeNumLabel.text = "\(recipeBookDetailData.result.likeCount)"
        
        self.recipeBookDetailView.ingredientListLabel.text = recipeBookDetailData.result.ingredient
        
        self.recipeBookDetailView.descriptionLabel.text = recipeBookDetailData.result.recipeInstruction
        
        self.recipeBookDetailView.commentAreaView.titleLabel.text = "댓글 \(commentsNum)"
        
        if !arrayRecipeBookComment.isEmpty {
            recipeBookDetailView.commentAreaView.commentsView.configureRecipeBookComments(arrayRecipeBookComment)
        }
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
    
    // MARK: - 좋아요 아이콘 버튼 설정
    func configureLikeIconButton() {
        let bt = recipeBookDetailView.likeIconButton
        bt.addTarget(self, action: #selector(likeIconButtonTapped), for: .touchUpInside)
    }
    
    @objc func likeIconButtonTapped() {
        isLiked.toggle()
        let imageName = isLiked ? "ic_like_selected" : "ic_like"
        recipeBookDetailView.likeIconButton.setImage(UIImage(named: imageName), for: .normal)
        if let recipeBookId = self.recipeBookId {
            RecipeBookDetailDataManager().postLike(recipeBookId)
            self.fetchRecipeBookDetail()
        }
    }
    
    func fetchRecipeBookDetail() { // 하트 아이콘 실시간 반영
        if let recipeBookId = self.recipeBookId {
            RecipeBookDetailDataManager().fetchRecipeBookDetailData(recipeBookId, self) { [weak self] detailModel in
                guard let self = self else { return }
                self.recipeBookDetailData = detailModel
                DispatchQueue.main.async {
                    self.updateUIWithData()
                }
            }
        }
    }
    
    // MARK: - 게시글 삭제/수정 버튼 설정
    func configureMoreButton() {
        let bt = recipeBookDetailView.moreButton
        bt.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }
    
    @objc func moreButtonTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let removeAction = UIAlertAction(title: "삭제하기", style: .destructive) { [weak self] _ in
            guard let self = self, let recipeBookId = self.recipeBookId else { return }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
                let alert = UIAlertController(title: nil, message: "게시글이 삭제되었습니다.", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)

                Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
            }
            RecipeBookDetailDataManager().deleteRecipeBook(recipeBookId){
                
            }
        }
        
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
        let cv = recipeBookDetailView.commentsInputView
        cv.textField.delegate = self
        cv.button.addTarget(self, action: #selector(commentsInputButtonTapped), for: .touchUpInside)
    }
    
    @objc func commentsInputButtonTapped() {
        guard let text = self.recipeBookDetailView.commentsInputView.textField.text, !text.isEmpty else { return }
        
        self.recipeBookDetailView.commentsInputView.textField.resignFirstResponder() // 키보드 숨기기
        
        let input = RecipeBookCommentInput.postCommentInput(content: text, parentId: "0")
        
        if let recipeBookId = self.recipeBookId {
            RecipeBookDetailDataManager().postComment(recipeBookId, input)
            prepare()
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: nil, message: "댓글이 작성되었습니다.", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)

                Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
                
                // 스크롤뷰를 맨 위로 이동
                self.recipeBookDetailView.scrollView.contentOffset = .zero
            }
            fetchingMore = false
            totalPageNum = 0
            nowPageNum = 0
            
            self.recipeBookDetailView.commentsInputView.textField.text = "" // 텍스트필드 초기화
        }
    }
    
}

// MARK: - UICollectionViewDataSource
extension RecipeBookDetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeBookDetailData?.result.recipeImageList.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeBookDetailCell", for: indexPath) as! RecipeBookDetailCell

        if let imageUrlString = recipeBookDetailData?.result.recipeImageList[indexPath.item] {
            if let imageUrl = URL(string: imageUrlString) {
                cell.mainImage.kf.setImage(with: imageUrl)
            }
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
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

// MARK: - UICollectionViewDelegate
extension RecipeBookDetailVC: UICollectionViewDelegate {
    
}

// MARK: - UIScrollViewDelegate
extension RecipeBookDetailVC: UIScrollViewDelegate {
    
    // 이미지 컬렉션뷰 스크롤 시 키보드 내림
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    // 페이지컨트롤 업데이트
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.recipeBookDetailView.imageCollectionView {
            let index = Int(scrollView.contentOffset.x / recipeBookDetailView.imageCollectionView.bounds.width)
            recipeBookDetailView.pageControl.currentPage = index
        } else if scrollView == self.recipeBookDetailView.scrollView {
            // 페이징 처리
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let height = scrollView.bounds.size.height
            
            if offsetY > contentHeight - height {
                if !fetchingMore && totalPageNum > 1 && nowPageNum != totalPageNum {
                    
                    fetchingMore = true
                    fetchNextPage()
                }
            }
        }
    }
    
    func fetchNextPage() {
        nowPageNum = nowPageNum + 1
        
        let nextPage = nowPageNum
        let input = RecipeBookCommentInput.fetchRecipeBookCommentDataInput(page: nextPage)
        
        if let recipeBookId = self.recipeBookId {
            RecipeBookDetailDataManager().fetchRecipeBookCommentData(recipeBookId, input, self) { [weak self] commentModel in
                guard let self = self else { return }
                if let commentModel = commentModel {
                    self.arrayRecipeBookComment += commentModel.result.commentList
                    self.fetchingMore = false
                    DispatchQueue.main.async {
                        self.recipeBookDetailView.commentAreaView.commentsView.configureRecipeBookComments(self.arrayRecipeBookComment)
                    }
                }
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension RecipeBookDetailVC: UITextFieldDelegate {
    
    // 댓글 입력창 리턴 클릭 시 키보드 내림
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
