//
//  CombinationDetailViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 1/18/24.
//

import UIKit

final class CombinationDetailViewController: UIViewController, UIScrollViewDelegate {
    // MARK: - Properties
    var combinationId: Int?
    
    var isWeeklyBest = false
    var selectedIndex: Int?
    var isLiked = false
    
    private var totalPageNum: Int = 0
    private var pageNum: Int = 0
    private var isLastPage: Bool = false
    
    var combinationDetailData: CombinationDetailResponseDto?
    var arrayCombinationComment: [CombinationCommentDto] = []
    
    let combinationDetailView = CombinationDetailView()
    
    private var headerView: CombinationDetailHeaderView?
    
    // MARK: - View 설정
    override func loadView() {
        view = combinationDetailView
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        
        if isMovingFromParent {
            if isWeeklyBest { // 주간 베스트 조합에서 PUSH 했을 때
                guard let navigationController = navigationController,
                      let WeeklyBestVC = navigationController.viewControllers.last as? WeeklyBestViewController,
                      let selectedIndex = selectedIndex else {
                    return
                }
                WeeklyBestVC.combinations[selectedIndex].isLike = isLiked // 좋아요 상태 업데이트
                WeeklyBestVC.weeklyBestView.tableView.reloadRows(at: [IndexPath(row: selectedIndex, section: 0)], with: .none) // 해당 셀만 리로드
            }
            
            guard let navigationController = navigationController,
                  let todayCombinationViewController = navigationController.viewControllers.last as? CombiationHomeViewController,
                  let selectedIndex = selectedIndex else {
                return
            }
            todayCombinationViewController.combinations[selectedIndex].isLike = isLiked // 좋아요 상태 업데이트
            todayCombinationViewController.combinationHomeView.tableView.reloadRows(at: [IndexPath(row: selectedIndex, section: 0)], with: .none) // 해당 셀만 리로드
        }
    }
    
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func fetchData() {
        guard let combinationId = self.combinationId else { return }
        
        self.pageNum = 0
        
        CombinationService.shared.getDetail(combinationId: combinationId) { result in
            switch result {
            case .success(let data):
                print("오늘의 조합 상세 조회 성공")
                self.combinationDetailData = data
                
                CombinationService.shared.getAllComment(combinationId: combinationId, 
                                                        page: 0) { result in
                    switch result {
                    case .success(let data):
                        print("오늘의 조합 댓글 조회 성공")
                        self.totalPageNum = data.result.totalPage
                        self.isLastPage = data.result.isLast
                        self.arrayCombinationComment = data.result.combinationCommentList
                        DispatchQueue.main.async {
                            self.combinationDetailView.tabelView.reloadData()
                        }
                    case .failure(let error):
                        print("오늘의 조합 댓글 조회 실패 - \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                print("오늘의 조합 상세 조회 실패 - \(error.localizedDescription)")
            }
        }
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupTableView() {
        let tb = combinationDetailView.tabelView
        tb.dataSource = self
        tb.delegate = self
        tb.prefetchDataSource = self
        tb.rowHeight = 69
        tb.register(CombinationDetailCommentCell.self, forCellReuseIdentifier: "CombinationDetailCommentCell")
        
        tb.sectionHeaderHeight = UITableView.automaticDimension
        tb.register(CombinationDetailHeaderView.self, forHeaderFooterViewReuseIdentifier: "CombinationDetailHeaderView")
        tb.sectionFooterHeight = .leastNonzeroMagnitude
    }
    
    private func setupTextField() {
        combinationDetailView.commentInputView.textField.delegate = self
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
        
        combinationDetailView.commentInputView.uploadCommentButton.addTarget(
            self,
            action: #selector(uploadCommentButtonTapped),
            for: .touchUpInside
        )
    }
}

// MARK: - Actions
extension CombinationDetailViewController {
    // 좋아요
    @objc func likeButtonTapped() {
        guard let combinationId = self.combinationId else { return }
        
        self.isLiked.toggle()
        let imageName = self.isLiked ? "ic_like_selected" : "ic_like"
        
        CombinationService.shared.postLike(combinationId: combinationId) { error in
            if let error = error {
                print("오늘의 조합 좋아요 실패 - \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.headerView?.likeButton.setImage(UIImage(named: imageName), for: .normal)
                }
                if self.isLiked {
                    print("오늘의 조합 좋아요 성공")
                } else {
                    print("오늘의 조합 좋아요 취소 성공")
                }
            }
        }
    }
    
    @objc func moreButtonTapped() {
        // 내가 작성한 글인지 확인 ** memberId로 수정 필요 **
        let isCurrentUser = combinationDetailData?.result.memberResult.nickName == UserDefaultManager.shared.userNickname
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if isCurrentUser { // 내가 작성한 글 일 때
            let deleteAction = UIAlertAction(title: "삭제하기", style: .destructive) { _ in
                guard let combinationId = self.combinationId else { return }
                CombinationService.shared.deleteCombination(combinationId: combinationId) { error in
                    if let error = error {
                        print("오늘의 조합 삭제 실패 - \(error.localizedDescription)")
                    } else {
                        print("오늘의 조합 삭제 성공")
                        self.navigationController?.popViewController(animated: true)
                        
                        let alert = UIAlertController(title: nil, message: "게시글이 삭제되었습니다.", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                            alert.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
            
            let modifyAction = UIAlertAction(title: "수정하기", style: .default, handler: nil)
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            [deleteAction, modifyAction, cancelAction].forEach { alert.addAction($0) }
            
        } else { // 내가 작성한 글 아닐 때
            let reportAction = UIAlertAction(title: "신고하기", style: .destructive) { [self] _ in
                let VC = ReportViewController()
                VC.resourceId = combinationDetailData?.result.combinationResult.combinationId
                VC.reportTarget = "COMBINATION"
                VC.reportContent = combinationDetailData?.result.combinationResult.content
                navigationController?.pushViewController(VC, animated: true)
            }
            
            let blockingAction = UIAlertAction(title: "차단하기", style: .default, handler: nil)
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            [reportAction, blockingAction, cancelAction].forEach { alert.addAction($0) }
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    // 댓글 작성
    @objc func uploadCommentButtonTapped() {
        guard let combinationId = self.combinationId,
              let content = self.combinationDetailView.commentInputView.textField.text, !content.isEmpty else { return }
        
        view.endEditing(true) // 키보드 내리기
        self.combinationDetailView.commentInputView.textField.text = ""
        
        
        CombinationService.shared.postComment(combinationId: combinationId, 
                                              content: content,
                                              parentId: "0") { error in
            if let error = error {
                print("오늘의 조합 댓글 작성 실패 - \(error.localizedDescription)")
            } else {
                print("오늘의 조합 댓글 작성 성공")
                self.combinationDetailView.tabelView.setContentOffset(.zero, animated: true) // 맨 위로 스크롤
                self.fetchData()
                
                let alert = UIAlertController(title: nil, message: "댓글이 작성되었습니다.", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                    alert.dismiss(animated: true, completion: nil)
                }
            }
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
                self.combinationDetailView.tabelView.contentInset.bottom = keyboardHeight
            }
        }
    }
    
    @objc func keyboardDown() {
        UIView.animate(withDuration: 0.3) {
            // 키보드가 사라질 때는 다시 원래 위치로 복원
            self.view.transform = .identity
            // 텍스트 필드가 있는 테이블 뷰의 contentInset을 초기화
            self.combinationDetailView.tabelView.contentInset.bottom = 0
        }
    }
}

// MARK: - UITableViewDataSource
extension CombinationDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCombinationComment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CombinationDetailCommentCell", for: indexPath) as! CombinationDetailCommentCell
        
        cell.delegate = self
        
        let data = arrayCombinationComment[indexPath.row]
        
        cell.combinationCommentList = data
        
        if let imageUrlString = data.memberProfile {
            if let imageUrl = URL(string: imageUrlString) {
                cell.profileImage.kf.setImage(with: imageUrl)
            }
        }
        
        cell.nicknameLabel.text = data.memberNickName
        cell.dateLabel.text = data.createdAt
        
        if data.state == "REPORTED" { // 신고된 댓글 처리
            cell.commentLabel.text = "해당 댓글은 신고 되었습니다."
        } else {
            cell.commentLabel.text = data.content
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CombinationDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CombinationDetailHeaderView") as! CombinationDetailHeaderView
        
        self.headerView = header
        setupButton()
        
        guard let data = combinationDetailData else { return UIView() }
        
        header.imageCollectionView.delegate = self
        header.imageCollectionView.dataSource = self
        header.imageCollectionView.register(CombinationDetailImageCell.self, forCellWithReuseIdentifier: "CombinationDetailImageCell")
        
        // 헤더뷰 UI 세팅
        header.pageControl.numberOfPages = data.result.combinationResult.combinationImageList.count
        
        if let imageUrlString = data.result.memberResult.profileImageUrl {
            if let imageUrl = URL(string: imageUrlString) {
                header.profileImage.kf.setImage(with: imageUrl)
            }
        }
        
        header.nicknameLabel.text = data.result.memberResult.nickName
        
        if data.result.combinationResult.isCombinationLike == true {
            self.isLiked = true
            header.likeButton.setImage(UIImage(named: "ic_like_selected"), for: .normal)
        }
        
        header.hashtagLabel.text = data.result.combinationResult.hashTagList.map { "\($0)" }.joined(separator: " ")
        header.titleLabel.text = data.result.combinationResult.title
        header.descriptionLabel.text = data.result.combinationResult.content
        DispatchQueue.main.async {
            header.commentNumLabel.text = "댓글 \(data.result.combinationCommentResult.totalElements)"
        }
        
        return header
    }
}

// MARK: - UITableViewDataSourcePrefetching
extension CombinationDetailViewController: UITableViewDataSourcePrefetching { // 댓글 페이징
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            guard let combinationId = self.combinationId else { return }
            if arrayCombinationComment.count - 1 == indexPath.row && pageNum < totalPageNum && !isLastPage {
                
                self.pageNum += 1
                
                CombinationService.shared.getAllComment(combinationId: combinationId,
                                                        page: self.pageNum) { result in
                    switch result {
                    case .success(let data):
                        print("오늘의 조합 댓글 페이징 조회 성공")
                        self.isLastPage = data.result.isLast
                        self.arrayCombinationComment += data.result.combinationCommentList
                        DispatchQueue.main.async {
                            self.combinationDetailView.tabelView.reloadData()
                        }
                    case .failure(let error):
                        print("오늘의 조합 댓글 페이징 조회 실패 - \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CombinationDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return combinationDetailData?.result.combinationResult.combinationImageList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CombinationDetailImageCell", for: indexPath) as! CombinationDetailImageCell
        
        if let imageUrlString = combinationDetailData?.result.combinationResult.combinationImageList[indexPath.item] {
            if let imageUrl = URL(string: imageUrlString) {
                cell.mainImage.kf.setImage(with: imageUrl)
            }
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CombinationDetailViewController: UICollectionViewDelegateFlowLayout {
    
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

// MARK: - ComponentProductCellDelegate
extension CombinationDetailViewController: ComponentProductCellDelegate {
    func selectedInfoBtn(data: CombinationCommentDto) {
        
        // 내가 작성한 댓글인지 확인 ** memberId로 수정 필요 **
        let isCurrentUser = data.memberNickName != UserDefaultManager.shared.userNickname
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if isCurrentUser { // 내가 작성한 댓글 일 때
            let deleteAction = UIAlertAction(title: "삭제하기", style: .destructive) { _ in
                
                CombinationService.shared.deleteComment(commentId: data.id) { error in
                    if let error = error {
                        print("오늘의 조합 댓글 삭제 실패 - \(error.localizedDescription)")
                    } else {
                        print("오늘의 조합 댓글 삭제 성공")
                        self.combinationDetailView.tabelView.setContentOffset(.zero, animated: true) // 맨 위로 스크롤
                        self.fetchData()
                        
                        let alert = UIAlertController(title: nil, message: "댓글이 삭제되었습니다.", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                            alert.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
            
            let modifyAction = UIAlertAction(title: "수정하기", style: .default, handler: nil)
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            [deleteAction, modifyAction, cancelAction].forEach { alert.addAction($0) }
            
        } else { // 내가 작성한 댓글 아닐 때
            let reportAction = UIAlertAction(title: "신고하기", style: .destructive) { [self] _ in
                let VC = ReportViewController()
                VC.resourceId = data.id
                VC.reportTarget = "COMBINATION_COMMENT"
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
extension CombinationDetailViewController: UITextFieldDelegate {
    // 리턴 클릭 시 키보드 내림
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
