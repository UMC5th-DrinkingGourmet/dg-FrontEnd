//
//  RecipeBookHomeVC.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

final class RecipeBookHomeVC: UIViewController {
    // MARK: - Properties
    var isSearch = false
    var keyword = ""
    
    var recipeBooks: [RecipeBookHomeDTO] = []
    var totalPageNum: Int = 0
    var pageNum: Int = 0
    var isLastPage: Bool = false
    
    let recipeBookHomeView = CombinationHomeView()
    
    // MARK: - View 설정
    override func loadView() {
        view = recipeBookHomeView
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        setupRefresh()
        setupNaviBar()
        setupTableView()
        setupButton()
    }
    
    // MARK: - 데이터 가져오기
    func fetchData() {
        self.pageNum = 0
        
        if isSearch { // 검색일 때
            RecipeBookService.shared.getSearch(page: 0, 
                                               keyword: self.keyword) { result in
                switch result {
                case .success(let data):
                    print("레시피북 검색 성공")
                    self.totalPageNum = data.result.totalPage
                    self.isLastPage = data.result.isLast
                    self.recipeBooks = data.result.recipeList
                    DispatchQueue.main.async {
                        self.recipeBookHomeView.tableView.reloadData()
                    }
                case .failure(let error):
                    print("레시피북 실패 - \(error.localizedDescription)")
                }
            }
        } else {
            RecipeBookService.shared.getAll(page: 0) { result in
                switch result {
                case .success(let data):
                    print("레시피북 홈 조회 성공")
                    self.totalPageNum = data.result.totalPage
                    self.isLastPage = data.result.isLast
                    self.recipeBooks = data.result.recipeList
                    DispatchQueue.main.async {
                        self.recipeBookHomeView.tableView.reloadData()
                    }
                case .failure(let error):
                    print("레시피북 홈 조회 실패 - \(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: - 새로고침
    func setupRefresh() {
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
        tb.register(CombinationHomeCell.self, forCellReuseIdentifier: "CombinationHomeCell")
    }
    
    // MARK: - 버튼 설정
    private func setupButton() {
        recipeBookHomeView.customSearchBar.searchBarButton.addTarget(self,
                                                                     action: #selector(searchBarButtonTapped),
                                                                     for: .touchUpInside)
        
        recipeBookHomeView.uploadButton.addTarget(self,
                                                  action: #selector(uploadButtonTapped),
                                                  for: .touchUpInside)
    }
}

// MARK: - Actions
extension RecipeBookHomeVC {
    // 새로고침
    @objc func refreshTable(refresh: UIRefreshControl) {
        self.isSearch = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.fetchData()
            refresh.endRefreshing()
        }
    }
    
    // 검색
    @objc func searchBarButtonTapped() {
        let recipeBookSearchVC = RecipeBookSearchVC()
        recipeBookSearchVC.navigationItem.hidesBackButton = true // 검색화면 백버튼 숨기기
        navigationController?.pushViewController(recipeBookSearchVC, animated: true)
    }
    
    // 업로드
    @objc func uploadButtonTapped() {
        let vc = RecipeBookUploadViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension RecipeBookHomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CombinationHomeCell", for: indexPath) as! CombinationHomeCell
        
        let recipeBook = recipeBooks[indexPath.row]
        
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
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension RecipeBookHomeVC: UITableViewDelegate {
    // 셀 선택시 Detail 화면으로
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = recipeBooks[indexPath.row].id
        
        let recipeBookDetailVC = RecipeBookDetailVC()
        recipeBookDetailVC.recipeBookId = selectedItem
        recipeBookDetailVC.selectedIndex = indexPath.row
        recipeBookDetailVC.isLiked = recipeBooks[indexPath.row].like
        navigationController?.pushViewController(recipeBookDetailVC, animated: true)
    }
}

// MARK: - UITableViewDataSourcePrefetching
extension RecipeBookHomeVC: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            
            if isSearch { // 검색일 때
                if recipeBooks.count - 1 == indexPath.row && pageNum < totalPageNum && !isLastPage {
                    
                    self.pageNum += 1
                    
                    RecipeBookService.shared.getSearch(page: self.pageNum,
                                                       keyword: self.keyword) { result in
                        switch result {
                        case .success(let data):
                            print("레시피북 검색 페이징 성공")
                            self.isLastPage = data.result.isLast
                            self.recipeBooks += data.result.recipeList
                            DispatchQueue.main.async {
                                self.recipeBookHomeView.tableView.reloadData()
                            }
                        case .failure(let error):
                            print("레시피북 검색 페이징 실패 - \(error.localizedDescription)")
                        }
                    }
                }
            } else {
                if recipeBooks.count - 1 == indexPath.row && pageNum < totalPageNum && !isLastPage {
                    
                    self.pageNum += 1
                    
                    RecipeBookService.shared.getAll(page: self.pageNum) { result in
                        switch result {
                        case .success(let data):
                            print("레시피북 홈 조회 페이징 성공")
                            self.isLastPage = data.result.isLast
                            self.recipeBooks += data.result.recipeList
                            DispatchQueue.main.async {
                                self.recipeBookHomeView.tableView.reloadData()
                            }
                            
                        case .failure(let error):
                            print("레시피북 홈 조회 페이징 실패 - \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
}
