//
//  MyPageViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/20/24.
//

import UIKit

enum MyPageTab {
    case recommend
    case combination
    case recipeBook
}

class MyPageViewController: UIViewController {
    
    // MARK: - Properties
    var currentTab: MyPageTab = .recommend
    
    private let myPageView = MyPageView()
    
    // MARK: - View 설정
    override func loadView() {
        view = myPageView
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNaviBar()
        setupCollectionView()
        setupButton()
    }
    
    // MARK: - 네비게이션바 설정
    func setupNaviBar() {
        title = "마이페이지"
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let customBackImage = UIImage(named: "ic_back")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = customBackImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = customBackImage
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // 설정 버튼 생성
        let settingButton = UIBarButtonItem (image: UIImage(named: "ic_setting")?.withRenderingMode(.alwaysOriginal),
                                             style: .plain,
                                             target: self,
                                             action: #selector(settingButtonTapped))
        
        // 네비게이션 바 오른쪽 아이템으로 설정 버튼 추가
        navigationItem.rightBarButtonItem = settingButton
    }
    
    @objc func settingButtonTapped() {
        print("설정 버튼이 탭되었습니다.")
    }
    
    // MARK: - 컬렌션뷰 설정
    func setupCollectionView() {
        let cv = myPageView.myPageLowerView.collectionView
        cv.dataSource = self
        cv.delegate = self
        
        cv.register(MyPageCell.self, forCellWithReuseIdentifier: "MyPageCell")
    }
    
    // MARK: - 버튼 설정
    func setupButton() {
        myPageView.myPageLowerView.recommendButton.addTarget(self, action: #selector(recommendButtonTapped), for: .touchUpInside)
        myPageView.myPageLowerView.combinationButton.addTarget(self, action: #selector(combinationButtonTapped), for: .touchUpInside)
        myPageView.myPageLowerView.recipeBookButton.addTarget(self, action: #selector(recipeBookButtonTapped), for: .touchUpInside)
    }
    
    @objc func recommendButtonTapped() { // 추천
        currentTab = .recommend
        
        myPageView.myPageLowerView.recommendLabel.textColor = .black
        myPageView.myPageLowerView.leftLine.backgroundColor = .orange
        
        myPageView.myPageLowerView.combinationLabel.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        myPageView.myPageLowerView.recipeBookLabel.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        
        myPageView.myPageLowerView.centerLine.backgroundColor = .clear
        myPageView.myPageLowerView.rightLine.backgroundColor = .clear
        
    }
    
    @objc func combinationButtonTapped() { // 오늘의 조합
        currentTab = .combination
        
        myPageView.myPageLowerView.combinationLabel.textColor = .black
        myPageView.myPageLowerView.centerLine.backgroundColor = .orange
        
        myPageView.myPageLowerView.recommendLabel.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        myPageView.myPageLowerView.recipeBookLabel.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        
        myPageView.myPageLowerView.leftLine.backgroundColor = .clear
        myPageView.myPageLowerView.rightLine.backgroundColor = .clear
        
    }
    
    @objc func recipeBookButtonTapped() { // 레시피북
        currentTab = .recipeBook
        
        myPageView.myPageLowerView.recipeBookLabel.textColor = .black
        myPageView.myPageLowerView.rightLine.backgroundColor = .orange
        
        myPageView.myPageLowerView.recommendLabel.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        myPageView.myPageLowerView.combinationLabel.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        
        myPageView.myPageLowerView.leftLine.backgroundColor = .clear
        myPageView.myPageLowerView.centerLine.backgroundColor = .clear
        
    }

}

// MARK: - UICollectionViewDataSource
extension MyPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch currentTab {
//        case .recommend:
//            // 추천 탭 아이템 선택 처리
//        case .combination:
//            // 조합 탭 아이템 선택 처리
//        case .recipeBook:
//            // 레시피북 탭 아이템 선택 처리
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPageCell", for: indexPath) as! MyPageCell
        
//        switch currentTab {
//        case .recommend:
//            // 추천 탭 아이템 선택 처리
//        case .combination:
//            // 조합 탭 아이템 선택 처리
//        case .recipeBook:
//            // 레시피북 탭 아이템 선택 처리
        
        cell.backgroundColor = .green
        
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MyPageViewController: UICollectionViewDelegateFlowLayout {
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
    
    // 셀 선택
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        if isleftButton { // 오늘의 조합
//            let selectedItem = arrayLikeAllCombination[indexPath.row].combinationId
//            let todayCombinationDetailVC = TodayCombinationDetailViewController()
//            todayCombinationDetailVC.combinationId = selectedItem
//            navigationController?.pushViewController(todayCombinationDetailVC, animated: true)
//        } else { // 레시피북
//            let selectedItem = arrayLikeAllRecipeBook[indexPath.row].id
//            let recipeBookDetailVC = RecipeBookDetailVC()
//            recipeBookDetailVC.recipeBookId = selectedItem
//            navigationController?.pushViewController(recipeBookDetailVC, animated: true)
//        }
        
    }
}
