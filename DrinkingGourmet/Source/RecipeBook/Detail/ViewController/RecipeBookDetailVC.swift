//
//  RecipeBookDetailVC.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

final class RecipeBookDetailVC: UIViewController, UIScrollViewDelegate {
    // MARK: - Properties
    var recipeBookId: Int?
    
    var isWeeklyBest = false
    var selectedIndex: Int?
    var isLiked = false
    
    private var totalPageNum: Int = 0
    private var pageNum: Int = 0
    private var isLastPage: Bool = false
    
    var recipeBookDetailData: RecipeBookDetailModel?
    var arrayRecipeBookComment: [RecipeBookCommentModel.CommentList] = []
    
    let recipeBookDetailView = CombinationDetailView()
    
    private var headerView: RecipeBookDetailHeaderView?
    
    // MARK: - View 설정
    override func loadView() {
        view = recipeBookDetailView
    }
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardUp),
            name: UIResponder.keyboardWillShowNotification, object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDown),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
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
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNaviBar()
        fetchData()
        addTapGesture()
        setupTableView()
        setupTextField()
        setupButton()
    }
    
    private func setupNaviBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
    }
    
    func fetchData() {
        if let recipeBookId = self.recipeBookId {
            RecipeBookDetailDataManager().fetchRecipeBookDetailData(recipeBookId, self) { [weak self] detailModel in
                guard let self = self else { return }
                self.recipeBookDetailData = detailModel
                print("좋아요 : \(isLiked)")
                
                let recipeBookCommentInput = RecipeBookCommentInput.fetchRecipeBookCommentDataInput(page: 0)
                RecipeBookDetailDataManager().fetchRecipeBookCommentData(recipeBookId, recipeBookCommentInput, self) { commentModel in
                    if let commentModel = commentModel {
                        self.totalPageNum = commentModel.result.totalPage
                        self.isLastPage = commentModel.result.isLast
                        self.arrayRecipeBookComment = commentModel.result.commentList
                        DispatchQueue.main.async {
                            self.recipeBookDetailView.tabelView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupTableView() {
        let tb = recipeBookDetailView.tabelView
        tb.dataSource = self
        tb.delegate = self
        tb.prefetchDataSource = self
        tb.rowHeight = 69
        tb.register(CombinationDetailCommentCell.self, forCellReuseIdentifier: "CombinationDetailCommentCell")
        
        tb.sectionHeaderHeight = UITableView.automaticDimension
        tb.register(RecipeBookDetailHeaderView.self, forHeaderFooterViewReuseIdentifier: "RecipeBookDetailHeaderView")
        tb.sectionFooterHeight = .leastNonzeroMagnitude
    }
    
    private func setupTextField() {
        recipeBookDetailView.commentInputView.textField.delegate = self
    }
    
    private func setupButton() {
        headerView?.likeButton.addTarget(
            self,
            action: #selector(likeButtonTapped),
            for: .touchUpInside)
        headerView?.moreButton.addTarget(
            self,
            action: #selector(moreButtonTapped),
            for: .touchUpInside
        )
        recipeBookDetailView.commentInputView.uploadCommentButton.addTarget(
            self,
            action: #selector(postButtonTapped),
            for: .touchUpInside
        )
    }
}

// MARK: - @objc
extension RecipeBookDetailVC {
    // 좋아요
    @objc func likeButtonTapped() {
        isLiked.toggle()
        let imageName = isLiked ? "ic_like_selected" : "ic_like"
        headerView?.likeButton.setImage(UIImage(named: imageName), for: .normal)
        if let recipeBookId = self.recipeBookId {
            RecipeBookDetailDataManager().postLike(recipeBookId)
        }
        fetchData()
    }
    
    @objc func moreButtonTapped() {
        // 내가 작성한 글인지 확인 ** memberId로 수정 필요 **
        let isCurrentUser = recipeBookDetailData?.result.member.nickName == UserDefaultManager.shared.userNickname
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if isCurrentUser { // 내가 작성한 글 일 때
            let removeAction = UIAlertAction(title: "삭제하기", style: .destructive) { [weak self] _ in
                guard let self = self, let recipeBookId = self.recipeBookId else { return }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                    
                    if let navigationController = self.navigationController,
                       let recipeBookHomeVC = navigationController.viewControllers.last as? RecipeBookHomeVC {
                        recipeBookHomeVC.recipeBookHomeView.tableView.setContentOffset(CGPoint.zero, animated: true)
                        recipeBookHomeVC.fetchData()
                    }
                    
                    let alert = UIAlertController(title: nil, message: "게시글이 삭제되었습니다.", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    
                    Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
                }
                RecipeBookDetailDataManager().deleteRecipeBook(recipeBookId)
            }
            
            let modifyAction = UIAlertAction(title: "수정하기", style: .default, handler: nil)
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            [removeAction, modifyAction, cancelAction].forEach { alert.addAction($0) }
            
        } else { // 내가 작성한 글 아닐 때
            let reportAction = UIAlertAction(title: "신고하기", style: .destructive) { [self] _ in
                let VC = ReportViewController()
                VC.resourceId = recipeBookDetailData?.result.id
                VC.reportTarget = "RECIPE"
                VC.reportContent = recipeBookDetailData?.result.recipeInstruction
                navigationController?.pushViewController(VC, animated: true)
            }
            
            let blockingAction = UIAlertAction(title: "차단하기", style: .default, handler: nil)
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            [reportAction, blockingAction, cancelAction].forEach { alert.addAction($0) }
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func postButtonTapped() {
        guard let inputText = self.recipeBookDetailView.commentInputView.textField.text, !inputText.isEmpty else { return }
        guard let recipeBookId = self.recipeBookId else { return }
        view.endEditing(true)
        self.recipeBookDetailView.commentInputView.textField.text = ""
        
        let input = RecipeBookCommentInput.postCommentInput(content: inputText, parentId: "0")
        RecipeBookDetailDataManager().postComment(recipeBookId, input)
        
        self.fetchData()
        
        self.recipeBookDetailView.tabelView.setContentOffset(.zero, animated: true) // 맨 위로 스크롤
        let alert = UIAlertController(title: nil, message: "댓글이 작성되었습니다.", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func hideKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    @objc func keyboardUp(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            let safeAreaBottomInset = view.safeAreaInsets.bottom
            let distanceToMove = keyboardHeight - safeAreaBottomInset // 키보드가 뷰를 가리는 거리
            
            UIView.animate(withDuration: 0.3) {
                // Safe Area를 고려하여 뷰의 위치를 조정
                self.view.transform = CGAffineTransform(translationX: 0, y: -distanceToMove)
                // 텍스트 필드가 있는 테이블 뷰의 contentInset을 조정
                self.recipeBookDetailView.tabelView.contentInset.bottom = keyboardHeight
            }
        }
    }
    
    @objc func keyboardDown() {
        UIView.animate(withDuration: 0.3) {
            // 키보드가 사라질 때는 다시 원래 위치로 복원
            self.view.transform = .identity
            // 텍스트 필드가 있는 테이블 뷰의 contentInset을 초기화
            self.recipeBookDetailView.tabelView.contentInset.bottom = 0
        }
    }
}

// MARK: - UITableViewDataSource
extension RecipeBookDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRecipeBookComment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CombinationDetailCommentCell", for: indexPath) as! CombinationDetailCommentCell
        
        cell.recipeBookCommentDelegate = self
        
        let data = arrayRecipeBookComment[indexPath.row]
        
        cell.recipeBookCommentList = data
        
        if let imageUrlString = data.member.profileImageUrl {
            if let imageUrl = URL(string: imageUrlString) {
                cell.profileImage.kf.setImage(with: imageUrl)
            }
        }
        
        cell.nicknameLabel.text = data.member.nickName
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        if let date = formatter.date(from: data.createdDate) {
            formatter.dateFormat = "yyyy.MM.dd HH:mm"
            let formattedDate = formatter.string(from: date)
            cell.dateLabel.text = formattedDate
        } else {
            cell.dateLabel.text = data.createdDate
        }
        
        if data.state == "REPORTED" { // 신고된 댓글 처리
            cell.commentLabel.text = "해당 댓글은 신고 되었습니다."
        } else {
            cell.commentLabel.text = data.content
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension RecipeBookDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RecipeBookDetailHeaderView") as! RecipeBookDetailHeaderView
        
        self.headerView = header
        setupButton()
        
        guard let data = recipeBookDetailData else { return UIView() }
        
        header.imageCollectionView.delegate = self
        header.imageCollectionView.dataSource = self
        header.imageCollectionView.register(CombinationDetailImageCell.self, forCellWithReuseIdentifier: "CombinationDetailImageCell")
        
        // 헤더뷰 UI 세팅
        header.pageControl.numberOfPages = data.result.recipeImageList.count
        
        if let imageUrlString = data.result.member.profileImageUrl {
            if let imageUrl = URL(string: imageUrlString) {
                header.profileImage.kf.setImage(with: imageUrl)
            }
        }
        
        header.nicknameLabel.text = data.result.member.nickName
        
        if data.result.like == true {
            self.isLiked = true
            header.likeButton.setImage(UIImage(named: "ic_like_selected"), for: .normal)
        }
        
        header.hashtagLabel.text = data.result.hashTagNameList.map { "\($0)" }.joined(separator: " ")
        header.titleLabel.text = data.result.title
        header.recipeBookDetailInfoView.timeNumLabel.text = "\(data.result.cookingTime)"
        header.recipeBookDetailInfoView.kcalNumLabel.text = "\(data.result.calorie)"
        header.recipeBookDetailInfoView.likeNumLabel.text = "\(data.result.likeCount)"
        header.ingredientListLabel.text = data.result.ingredient
        header.cookingMetohdListLabel.text = data.result.recipeInstruction
        DispatchQueue.main.async {
            header.commentNumLabel.text = "댓글 \(data.result.commentCount)"
        }
        
        return header
    }
}
    
// MARK: - UITableViewDataSourcePrefetching
extension RecipeBookDetailVC: UITableViewDataSourcePrefetching { // 댓글 페이징
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if let recipeBookId = self.recipeBookId {
                if arrayRecipeBookComment.count - 1 == indexPath.row && pageNum < totalPageNum && !isLastPage {
                    pageNum += 1
                    let input = RecipeBookCommentInput.fetchRecipeBookCommentDataInput(page: pageNum)
                    
                    RecipeBookDetailDataManager().fetchRecipeBookCommentData(recipeBookId, input, self) { [weak self] model in
                        if let model = model {
                            guard let self = self else { return }
                            self.arrayRecipeBookComment += model.result.commentList
                            self.isLastPage = model.result.isLast
                            DispatchQueue.main.async {
                                self.recipeBookDetailView.tabelView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
}
    
// MARK: - UICollectionViewDataSource
extension RecipeBookDetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeBookDetailData?.result.recipeImageList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CombinationDetailImageCell", for: indexPath) as! CombinationDetailImageCell
        
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = headerView else { return }
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        header.pageControl.currentPage = index
    }
}
    
extension RecipeBookDetailVC: RecipeBookCommentCellDelegate { // 댓글
    func selectedInfoBtn(data: RecipeBookCommentModel.CommentList) {
        
        // 내가 작성한 댓글인지 확인 ** memberId로 수정 필요 **
        let isCurrentUser = data.member.nickName == UserDefaultManager.shared.userNickname
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if isCurrentUser { // 내가 작성한 댓글 일 때
            let deleteAction = UIAlertAction(title: "삭제하기", style: .destructive) { [weak self] _ in
                guard let self = self else { return }
                
                RecipeBookDetailDataManager().deleteComment(recipeCommentId: data.id)
                
                self.fetchData()
                
                self.recipeBookDetailView.tabelView.setContentOffset(.zero, animated: true) // 맨 위로 스크롤
                let alert = UIAlertController(title: nil, message: "댓글이 삭제되었습니다.", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                    alert.dismiss(animated: true, completion: nil)
                }
            }
            
            let modifyAction = UIAlertAction(title: "수정하기", style: .default, handler: nil)
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            [deleteAction, modifyAction, cancelAction].forEach { alert.addAction($0) }
            
        } else { // 내가 작성한 댓글 아닐 때
            let reportAction = UIAlertAction(title: "신고하기", style: .destructive) { [self] _ in
                let VC = ReportViewController()
                VC.resourceId = data.id
                VC.reportTarget = "RECIPE_COMMENT"
                VC.reportContent = data.content
                navigationController?.pushViewController(VC, animated: true)
            }
            
            let blockingAction = UIAlertAction(title: "차단하기", style: .default, handler: nil)
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            [reportAction, blockingAction, cancelAction].forEach { alert.addAction($0) }
        }
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension RecipeBookDetailVC: UITextFieldDelegate {
    // 리턴 클릭 시 키보드 내림
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
