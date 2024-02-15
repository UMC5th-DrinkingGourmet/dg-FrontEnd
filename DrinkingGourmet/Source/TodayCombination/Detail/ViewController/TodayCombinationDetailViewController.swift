//
//  TodayCombinationDetailViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 1/18/24.
//

import UIKit

class TodayCombinationDetailViewController: UIViewController {
    
    // MARK: - Properties
    var combinationId: Int?
    var fetchingMore: Bool = false
    var totalPageNum: Int = 0
    var nowPageNum: Int = 0
    
    var combinationDetailData: CombinationDetailModel?
    var arrayCombinationComment: [CombinationCommentModel.CombinationCommentList] = []
    
    private let todayCombinationDetailView = TodayCombinationDetailView()
    
    private var isLiked = false

    // MARK: - View 설정
    override func loadView() {
        view = todayCombinationDetailView
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepare()
        setupImageCollectionView()
        configureLikeIconButton()
        configureMoreButton()
        configureCommentMoreButton()
        setupCommentsInputView()
    }
    
    func prepare() {
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
        
        todayCombinationDetailView.scrollView.delegate = self
        
        if let combinationID = self.combinationId {
            CombinationDetailDataManager().fetchCombinationDetailData(combinationID, self) { [weak self] detailModel in
                guard let self = self else { return }
                self.combinationDetailData = detailModel
                
                let combinationCommentInput = CombinationCommentInput.fetchCombinatiCommentDataInput(page: 0)
                CombinationDetailDataManager().fetchCombinatiCommentData(combinationID, combinationCommentInput, self) { commentModel in
                    if let commentModel = commentModel {
                        self.totalPageNum = commentModel.result.totalPage
                        self.arrayCombinationComment = commentModel.result.combinationCommentList
                        DispatchQueue.main.async {
                            self.updateUIWithData()
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - 네트워킹 후 UI 업데이트
    func updateUIWithData() {
        self.todayCombinationDetailView.imageCollectionView.reloadData()
        
        self.todayCombinationDetailView.pageControl.numberOfPages =  combinationDetailData?.result.combinationResult.combinationImageList.count ?? 0
        
        self.todayCombinationDetailView.userNameLabel.text = "\(combinationDetailData?.result.memberResult.name ?? "이름") 님의 레시피"
        
        if combinationDetailData?.result.combinationResult.isCombinationLike == true {
            self.isLiked = true
            self.todayCombinationDetailView.likeIconButton.setImage(UIImage(named: "ic_like_selected"), for: .normal)
        }
        
        self.todayCombinationDetailView.hashtagLabel.text = combinationDetailData?.result.combinationResult.hashTagList.map { "#\($0)" }.joined(separator: " ")
        
        self.todayCombinationDetailView.titleLabel.text = combinationDetailData?.result.combinationResult.title
        
        self.todayCombinationDetailView.descriptionLabel.text = combinationDetailData?.result.combinationResult.content
        
        self.todayCombinationDetailView.commentAreaView.titleLabel.text = "댓글 \(combinationDetailData?.result.combinationCommentResult.totalElements ?? 0)"
        
        if !arrayCombinationComment.isEmpty {
            todayCombinationDetailView.commentAreaView.commentsView.configureComments(arrayCombinationComment)
        }
        
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
    
    // MARK: - 좋아요 아이콘 버튼 설정
    func configureLikeIconButton() {
        let bt = todayCombinationDetailView.likeIconButton
        bt.addTarget(self, action: #selector(likeIconButtonTapped), for: .touchUpInside)
    }
    
    @objc func likeIconButtonTapped() {
        isLiked.toggle()
        let imageName = isLiked ? "ic_like_selected" : "ic_like"
        todayCombinationDetailView.likeIconButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    // MARK: - 게시글 삭제/수정 버튼 설정
    func configureMoreButton() {
        let bt = todayCombinationDetailView.moreButton
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
        for commentView in todayCombinationDetailView.commentAreaView.commentsView.arrangedSubviews.compactMap({ $0 as? CommentView }) {
            commentView.moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        }
    }
    
    // MARK: - 댓글입력창 설정
    func setupCommentsInputView() {
        let cv = todayCombinationDetailView.commentsInputView
        cv.textField.delegate = self
        cv.button.addTarget(self, action: #selector(commentsInputButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - 댓글 입력 버튼 클릭
    @objc func commentsInputButtonTapped() {
        guard let text = todayCombinationDetailView.commentsInputView.textField.text, !text.isEmpty else { return }
        
        todayCombinationDetailView.commentsInputView.textField.resignFirstResponder() // 키보드 숨기기

        let input = CombinationCommentInput.postCommentInput(content: text, parentId: "0")

        if let combinationId = self.combinationId {
            CombinationDetailDataManager().postComment(combinationId, input)
            prepare()

            DispatchQueue.main.async {
                let alert = UIAlertController(title: nil, message: "댓글이 작성되었습니다.", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)

                Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
                
                // 스크롤뷰를 맨 위로 이동
                self.todayCombinationDetailView.scrollView.contentOffset = .zero
            }

            fetchingMore = false
            totalPageNum = 0
            nowPageNum = 0
            
            todayCombinationDetailView.commentsInputView.textField.text = "" // 텍스트필드 초기화
        }
    }
    
    // MARK: - 답글쓰기
    func setupReplyButton() {
        
    }
    
}

// MARK: - UICollectionViewDataSource
extension TodayCombinationDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return combinationDetailData?.result.combinationResult.combinationImageList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayCombinationDetailCell", for: indexPath) as! TodayCombinationDetailCell
        
        if let imageUrlString = combinationDetailData?.result.combinationResult.combinationImageList[indexPath.item] {
            if let imageUrl = URL(string: imageUrlString) {
                cell.mainImage.kf.setImage(with: imageUrl)
            }
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
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

// MARK: - UICollectionViewDelegate
extension TodayCombinationDetailViewController: UICollectionViewDelegate {
    
}

// MARK: - UIScrollViewDelegate
extension TodayCombinationDetailViewController: UIScrollViewDelegate {
    
    // 이미지 컬렉션뷰 스크롤 시 키보드 내림
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    // 페이징
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == todayCombinationDetailView.imageCollectionView {
            // 페이지 컨트롤 업데이트
            let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
            todayCombinationDetailView.pageControl.currentPage = index
        } else if scrollView == todayCombinationDetailView.scrollView {
            // 페이징 처리
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let height = scrollView.bounds.size.height
            
            if offsetY > contentHeight - height {
                if !fetchingMore && totalPageNum > 1 && nowPageNum != totalPageNum {
//                    print("if문통과")
                    fetchingMore = true
                    fetchNextPage()
                }
            }
        }
    }
    
    func fetchNextPage() {
        nowPageNum = nowPageNum + 1
        let nextPage = nowPageNum
//        print("nextPage - \(nextPage)")
        let input = CombinationCommentInput.fetchCombinatiCommentDataInput(page: nextPage)
        
        if let combinationID = self.combinationId {
            CombinationDetailDataManager().fetchCombinatiCommentData(combinationID, input, self) { [weak self] commentModel in
                if let commentModel = commentModel{
                    self?.arrayCombinationComment += commentModel.result.combinationCommentList
                    self?.fetchingMore = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self?.todayCombinationDetailView.commentAreaView.commentsView.configureComments(self?.arrayCombinationComment ?? [])
                    }
                }
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension TodayCombinationDetailViewController: UITextFieldDelegate {
    
    // 리턴 클릭 시 키보드 내림
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - 댓글입력창 눌렀을 때 텍스트필드 가려짐 해결
extension TodayCombinationDetailViewController {
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
