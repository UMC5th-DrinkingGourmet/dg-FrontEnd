//
//  RecipeBookHomeVC.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

final class RecipeBookHomeVC: UIViewController {
    
    // MARK: - Properties
    var arrayRecipeBookHome: [RecipeBookHomeModel.RecipeList] = []
    var totalPageNum: Int = 0
    var pageNum: Int = 0
    var isLastPage: Bool = false
    
    let recipeBookHomeView = RecipeBookHomeView()
    
    // MARK: - View 설정
    override func loadView() {
        view = recipeBookHomeView
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        fetchData()
        setupRefresh()
        setupNaviBar()
        setupTableView()
        setupButton()
    }
    
    // MARK: - 데이터 가져오기
    private func fetchData() {
        let input = RecipeBookHomeInput.fetchRecipeBookHomeDataInput(page: 0)
        pageNum = 0
        
        RecipeBookHomeDataManager().fetchRecipeBookHomeData(input, self) { [weak self] model in
            guard let self = self else { return }
            
            if let model = model {
                self.totalPageNum = model.result.totalPage
                self.isLastPage = model.result.isLast
                self.arrayRecipeBookHome = model.result.recipeList
                DispatchQueue.main.async {
                    self.recipeBookHomeView.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - 새로고침
    private func setupRefresh() {
        let rc = recipeBookHomeView.refreshControl
        rc.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        rc.tintColor = .customOrange
        
        recipeBookHomeView.tableView.refreshControl = rc
    }
    
    // MARK: - 네비게이션바 설정
    private func setupNaviBar() {
        title = "음주미식회 레시피북"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // 불투명
        appearance.backgroundColor = .white
        
        // 네비게이션바 밑줄 삭제
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // 백버튼 커스텀
        let customBackImage = UIImage(named: "ic_back")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = customBackImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = customBackImage
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - 테이블뷰 설정
    private func setupTableView() {
        let tb = recipeBookHomeView.tableView
        
        tb.dataSource = self
        tb.delegate = self
        tb.prefetchDataSource = self
        
        tb.rowHeight = 232 // 셀 높이 고정
        tb.register(RecipeBookHomeCell.self, forCellReuseIdentifier: "RecipeBookHomeCell")
    }
    
    // MARK: - 버튼 설정
    private func setupButton() {
        recipeBookHomeView.customSearchBar.searchBarButton.addTarget(self, action: #selector(searchBarButtonTapped), for: .touchUpInside)
        recipeBookHomeView.floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
    }
}

// MARK: - @objc
extension RecipeBookHomeVC {
    @objc func refreshTable(refresh: UIRefreshControl) {
        print("새로고침 시작")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.fetchData()
            refresh.endRefreshing()
        }
    }
    
    @objc func searchBarButtonTapped() {
        let recipeBookSearchVC = RecipeBookSearchVC()
        recipeBookSearchVC.navigationItem.hidesBackButton = true // 검색화면 백버튼 숨기기
        navigationController?.pushViewController(recipeBookSearchVC, animated: true)
    }
    
    @objc func floatingButtonTapped() {
        let vc = RecipeBookUploadViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension RecipeBookHomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRecipeBookHome.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeBookHomeCell", for: indexPath) as! RecipeBookHomeCell
        
        let recipeBook = arrayRecipeBookHome[indexPath.row]
        
        cell.likeSelectedIcon.isHidden = !recipeBook.like
        
        if !recipeBook.recipeImageList.isEmpty {
            if let url = URL(string: recipeBook.recipeImageList[0]) {
                cell.thumnailImage.kf.setImage(with: url)
            }
        } else {
            // 이미지 리스트가 비어 있을 경우의 처리
            // 예: 기본 이미지 설정 또는 이미지 뷰 숨기기
            cell.thumnailImage.image = UIImage(named: "defaultImage") // "defaultImage"는 기본 이미지의 이름
        }

        
        cell.titleLabel.text = recipeBook.title
        
        cell.hashtagLabel.text = recipeBook.hashTagNameList.map { "#\($0)" }.joined(separator: " ")
        
        cell.commentNumLabel.text = "\(recipeBook.commentCount)"
        
        cell.likeNumLabel.text = "\(recipeBook.likeCount)"
        
        cell.selectionStyle = .none // cell 선택 시 시각효과 제거
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension RecipeBookHomeVC: UITableViewDelegate {
    // 셀 선택시 Detail 화면으로
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = arrayRecipeBookHome[indexPath.row].id
        
        let recipeBookDetailVC = RecipeBookDetailVC()
        recipeBookDetailVC.recipeBookId = selectedItem
        navigationController?.pushViewController(recipeBookDetailVC, animated: true)
    }
}

// MARK: - UITableViewDataSourcePrefetching
extension RecipeBookHomeVC: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            
            if arrayRecipeBookHome.count - 1 == indexPath.row && pageNum < totalPageNum &&  !isLastPage {
                
                pageNum += 1
                
                let input = RecipeBookHomeInput.fetchRecipeBookHomeDataInput(page: pageNum)
                
                RecipeBookHomeDataManager().fetchRecipeBookHomeData(input, self) { [weak self] model in
                    if let model = model {
                        guard let self = self else { return }
                        self.arrayRecipeBookHome += model.result.recipeList
                        self.isLastPage = model.result.isLast
                        DispatchQueue.main.async {
                            self.recipeBookHomeView.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
}
