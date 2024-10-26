//
//  RecipeBookDetailViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit
import Toast

final class RecipeBookDetailViewController: UIViewController {
    // MARK: - Properties
    var recipeBookId: Int?
    
    var selectedIndex: Int?
    var isLiked = false
    
    private var totalPageNum: Int = 0
    private var pageNum: Int = 0
    private var isLastPage: Bool = false
    
    var recipeBookDetailData: RecipeBookDetailResponseDTO?
    var arrayRecipeBookComment: [RecipeBookCommentDTO] = []
    
    let recipeBookDetailView = CombinationDetailView()
    
    private var headerView: RecipeBookDetailHeaderView?
    
    // MARK: - View 설정
    override func loadView() {
        view = recipeBookDetailView
    }
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardUp),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDown),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        // 페이지 컨트롤 초기화
        headerView?.pageControl.currentPage = 0
        
        // 이미지 컬렉션 뷰를 첫 번째 아이템으로 스크롤
        headerView?.imageCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0),
                                                     at: .centeredHorizontally,
                                                     animated: false)
    }
    
    // 뒤로가기 할 때
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            guard let navigationController = navigationController,
                  let RecipeBookHomeVC = navigationController.viewControllers.last as? RecipeBookHomeViewController,
                  let selectedIndex = selectedIndex else {
                return
            }
            RecipeBookHomeVC.recipeBooks[selectedIndex].like = isLiked // 좋아요 상태 업데이트
            RecipeBookHomeVC.recipeBookHomeView.tableView.reloadRows(at: [IndexPath(row: selectedIndex, section: 0)], with: .none) // 해당 셀만 리로드
        }
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage() // 그림자 제거
    }
    
    func fetchData() {
        guard let recipeBookId = self.recipeBookId else { return }
        
        self.pageNum = 0
        
        RecipeBookService.shared.getDetail(recipeBookId: recipeBookId) { result in
            switch result {
            case .success(let data):
                print("레시피북 상세 조회 성공")
                self.recipeBookDetailData = data
                
                RecipeBookService.shared.getAllComment(recipeBookId: recipeBookId, 
                                                       page: 0) { result in
                    switch result {
                    case .success(let data):
                        print("레시피북 댓글 조회 성공")
                        self.totalPageNum = data.result.totalPage
                        self.isLastPage = data.result.isLast
                        self.arrayRecipeBookComment = data.result.commentList
                        DispatchQueue.main.async {
                            self.headerView?.imageCollectionView.reloadData()
                            self.recipeBookDetailView.tabelView.reloadData()
                        }
                    case .failure(let error):
                        print("레시피북 조합 댓글 조회 실패 - \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                print("레시피북 상세 조회 실패 - \(error.localizedDescription)")
                let alertVC = RemovedAlertViewController()
                alertVC.delegate = self
                alertVC.appear(sender: self)
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
        headerView?.likeButton.addTarget(self,
                                         action: #selector(likeButtonTapped),
                                         for: .touchUpInside)
        
        headerView?.moreButton.addTarget(self, 
                                         action: #selector(moreButtonTapped),
                                         for: .touchUpInside)
        
        recipeBookDetailView.commentInputView.uploadCommentButton.addTarget(self,
                                                                            action: #selector(postButtonTapped),
                                                                            for: .touchUpInside)
    }
}

// MARK: - Actions
extension RecipeBookDetailViewController {
    // 좋아요
    @objc func likeButtonTapped() {
        guard let recipeBookId = self.recipeBookId else { return }
        
        isLiked.toggle()
        let imageName = isLiked ? "ic_like_selected" : "ic_like"
        
        RecipeBookService.shared.postLike(recipeBookId: recipeBookId) { error in
            if let error = error {
                print("레시피북 좋아요 실패 - \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.headerView?.likeButton.setImage(UIImage(named: imageName), for: .normal)
                    self.fetchData()
                }
                if self.isLiked {
                    print("레시피북 좋아요 성공")
                } else {
                    print("레시피북 좋아요 취소 성공")
                }
            }
        }
    }
    
    @objc func moreButtonTapped() {
        // 내가 작성한 글인지 확인 ** memberId로 수정 필요 **
        let isCurrentUser = recipeBookDetailData?.result.member.memberId == Int(UserDefaultManager.shared.userId)
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if isCurrentUser { // 내가 작성한 글 일 때
            let deleteAction = UIAlertAction(title: "삭제하기", style: .destructive) { _ in
                guard let recipeBookId = self.recipeBookId else { return }
                RecipeBookService.shared.deleteRecipeBook(recipeBookId: recipeBookId) { error in
                    if let error = error {
                        print("레시피북 삭제 실패 - \(error.localizedDescription)")
                    } else {
                        print("레시피북 삭제 성공")
                        self.navigationController?.popViewController(animated: true)
                        
                        let alert = UIAlertController(title: nil, message: "게시글이 삭제되었습니다.", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                            alert.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
            
            let modifyAction = UIAlertAction(title: "수정하기", style: .default) { _ in
                guard let recipeBookDetailData = self.recipeBookDetailData else { return }
                let VC = RecipeBookUploadViewController()
                VC.recipeBookDetailData = recipeBookDetailData
                VC.isModify = true
                self.navigationController?.pushViewController(VC, animated: true)
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            [deleteAction, modifyAction, cancelAction].forEach { alert.addAction($0) }
            
        } else { // 내가 작성한 글 아닐 때
            let reportAction = UIAlertAction(title: "신고하기", style: .destructive) { [self] _ in
                let VC = ReportViewController()
                VC.resourceId = recipeBookDetailData?.result.id
                VC.reportTarget = "RECIPE"
                VC.reportContent = recipeBookDetailData?.result.recipeInstruction
                VC.reportedMemberId = recipeBookDetailData?.result.member.memberId
                navigationController?.pushViewController(VC, animated: true)
            }
            
            let blockingAction = UIAlertAction(title: "차단하기", style: .default) { _ in
                // 차단 확인을 위한 Alert 생성
                let confirmationAlert = UIAlertController(title: nil, message: "이 작성자의 게시물과 댓글이\n더 이상 노출되지 않습니다.", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                let confirmAction = UIAlertAction(title: "확인", style: .destructive) { _ in
                    guard let blockedMemberId = self.recipeBookDetailData?.result.member.memberId else { return }
                    
                    // 댓글 창 숨기기
                    DispatchQueue.main.async {
                        self.recipeBookDetailView.commentInputView.isHidden = true
                    }
                    
                    AdministrationService.shared.postBlock(blockedMemberId: blockedMemberId) { error in
                        if let error = error {
                            print("\(blockedMemberId)번 멤버 차단 실패 - \(error.localizedDescription)")
                        } else {
                            print("\(blockedMemberId)번 멤버 차단 성공")
                            
                            let popUpView = ReportCompletePopUpView()
                            popUpView.label.text = "차단되었습니다"
                            ToastManager.shared.style.fadeDuration = 0.7
                            self.view.showToast(popUpView, duration: 0.7, position: .bottom, completion: { _ in
                                if let viewControllers = self.navigationController?.viewControllers {
                                    for vc in viewControllers {
                                        if let recipeBookHomeVC = vc as? RecipeBookHomeViewController {
                                            recipeBookHomeVC.recipeBookHomeView.tableView.setContentOffset(.zero, animated: true)
                                            recipeBookHomeVC.fetchData()
                                            self.navigationController?.popViewController(animated: true)
                                            break
                                        }
                                        if let likeTapmanVC = vc as? LikeTapmanViewController {
                                            likeTapmanVC.likeRecipeBookViewController.likeView.collectionView.setContentOffset(.zero, animated: true)
                                            likeTapmanVC.likeRecipeBookViewController.fetchData()
                                            self.navigationController?.popViewController(animated: true)
                                            break
                                        }
                                    }
                                }
                            })
                        }
                    }
                }
                
                confirmationAlert.addAction(cancelAction)
                confirmationAlert.addAction(confirmAction)
                
                self.present(confirmationAlert, animated: true, completion: nil)
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            [reportAction, blockingAction, cancelAction].forEach { alert.addAction($0) }
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    // 댓글 작성
    @objc func postButtonTapped() {
        guard let recipeBookId = self.recipeBookId,
              let content = self.recipeBookDetailView.commentInputView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !content.isEmpty else {
            let alert = UIAlertController(title: nil, message: "댓글 내용을 입력해주세요.", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                alert.dismiss(animated: true, completion: nil)
            }
            return
        }
        
        RecipeBookService.shared.postComment(recipeBookId: recipeBookId,
                                             content: content,
                                             parentId: 0) { error in
            if let error = error {
                print("레시피북 댓글 작성 실패 - \(error.localizedDescription)")
            } else {
                print("레시피북 댓글 작성 성공")
                self.view.endEditing(true) // 키보드 내리기
                self.recipeBookDetailView.commentInputView.textField.text = ""
                
                self.recipeBookDetailView.tabelView.setContentOffset(.zero, animated: true) // 맨 위로 스크롤
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
extension RecipeBookDetailViewController: UITableViewDataSource {
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
            } else {
                cell.profileImage.image = UIImage(named: "ic_default_profile")
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
            cell.moreButton.isHidden = true
        } else {
            cell.commentLabel.text = data.content
            cell.moreButton.isHidden = false
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension RecipeBookDetailViewController: UITableViewDelegate {
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
        header.recipeBookDetailInfoView.timeNumLabel.text = "\(data.result.cookingTime)분"
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
extension RecipeBookDetailViewController: UITableViewDataSourcePrefetching { // 댓글 페이징
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            guard let recipeBookId = self.recipeBookId else { return }
            if arrayRecipeBookComment.count - 1 == indexPath.row && pageNum < totalPageNum && !isLastPage {
                
                self.pageNum += 1
                
                RecipeBookService.shared.getAllComment(recipeBookId: recipeBookId,
                                                       page: self.pageNum) { result in
                    switch result {
                    case .success(let data):
                        print("레시피북 댓글 페이징 조회 성공")
                        self.isLastPage = data.result.isLast
                        self.arrayRecipeBookComment += data.result.commentList
                        DispatchQueue.main.async {
                            self.recipeBookDetailView.tabelView.reloadData()
                        }
                    case .failure(let error):
                        print("레시피북 조합 댓글 페이징 조회 실패 - \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
    
// MARK: - UICollectionViewDataSource
extension RecipeBookDetailViewController: UICollectionViewDataSource {
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
extension RecipeBookDetailViewController: UICollectionViewDelegateFlowLayout {
    
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

// MARK: - RecipeBookCommentCellDelegate
extension RecipeBookDetailViewController: RecipeBookCommentCellDelegate { // 댓글
    func selectedInfoBtn(data: RecipeBookCommentDTO) {
        
        let isCurrentUser = data.member.memberId == Int(UserDefaultManager.shared.userId)
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if isCurrentUser { // 내가 작성한 댓글 일 때
            let deleteAction = UIAlertAction(title: "삭제하기", style: .destructive) { _ in
                
                RecipeBookService.shared.deleteComment(recipeCommentId: data.id) { error in
                    if let error = error {
                        print("레시피북 댓글 삭제 실패 - \(error.localizedDescription)")
                    } else {
                        print("레시피북 댓글 삭제 성공")
                        self.recipeBookDetailView.tabelView.setContentOffset(.zero, animated: true) // 맨 위로 스크롤
                        self.fetchData()
                        
                        let alert = UIAlertController(title: nil, message: "댓글이 삭제되었습니다.", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                            alert.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            [deleteAction, cancelAction].forEach { alert.addAction($0) }
            
        } else { // 내가 작성한 댓글 아닐 때
            let reportAction = UIAlertAction(title: "신고하기", style: .destructive) { [self] _ in
                let VC = ReportViewController()
                VC.resourceId = data.id
                VC.reportTarget = "RECIPE_COMMENT"
                VC.reportContent = data.content
                VC.reportedMemberId = data.id
                navigationController?.pushViewController(VC, animated: true)
            }
            
            let blockingAction = UIAlertAction(title: "차단하기", style: .default) { _ in
                
                // 차단 확인을 위한 Alert 생성
                let confirmationAlert = UIAlertController(title: nil, message: "이 작성자의 게시물과 댓글이\n더 이상 노출되지 않습니다.", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                let confirmAction = UIAlertAction(title: "확인", style: .destructive) { _ in
                    
                    // 댓글 창 숨기기
                    DispatchQueue.main.async {
                        self.recipeBookDetailView.commentInputView.isHidden = true
                    }
                    
                    
                    AdministrationService.shared.postBlock(blockedMemberId: data.member.memberId) { error in
                        if let error = error {
                            print("\(data.member.memberId)번 멤버 차단 실패 - \(error.localizedDescription)")
                            
                            
                        } else {
                            print("\(data.member.memberId)번 멤버 차단 성공")
                            
                            // 차단 성공 토스트 메시지
                            let popUpView = ReportCompletePopUpView()
                            popUpView.label.text = "차단되었습니다"
                            ToastManager.shared.style.fadeDuration = 0.7
                            self.view.showToast(popUpView, duration: 0.7, position: .bottom, completion: { _ in
                                if let viewControllers = self.navigationController?.viewControllers {
                                    for vc in viewControllers {
                                        if let recipeBookHomeVC = vc as? RecipeBookHomeViewController {
                                            recipeBookHomeVC.recipeBookHomeView.tableView.setContentOffset(.zero, animated: true)
                                            recipeBookHomeVC.fetchData()
                                            self.navigationController?.popViewController(animated: true)
                                            break
                                        }
                                        if let likeTapmanVC = vc as? LikeTapmanViewController {
                                            likeTapmanVC.likeRecipeBookViewController.likeView.collectionView.setContentOffset(.zero, animated: true)
                                            likeTapmanVC.likeRecipeBookViewController.fetchData()
                                            self.navigationController?.popViewController(animated: true)
                                            break
                                        }
                                    }
                                }
                            })
                        }
                    }
                }
                confirmationAlert.addAction(cancelAction)
                confirmationAlert.addAction(confirmAction)
                
                self.present(confirmationAlert, animated: true, completion: nil)
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            [reportAction, blockingAction, cancelAction].forEach { alert.addAction($0) }
        }
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension RecipeBookDetailViewController: UITextFieldDelegate {
    // 리턴 클릭 시 키보드 내림
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - RemovedAlertViewControllerDelegate
extension RecipeBookDetailViewController: RemovedAlertViewControllerDelegate {
    func removedAlertViewControllerDidTapClose(_ controller: RemovedAlertViewController) {
        navigationController?.popViewController(animated: true)
    }
}
