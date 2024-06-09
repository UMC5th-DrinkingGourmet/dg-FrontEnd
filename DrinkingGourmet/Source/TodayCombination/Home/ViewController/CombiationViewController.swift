//
//  CombiationViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 1/17/24.
//

import UIKit

final class CombiationViewController: UIViewController {
    // MARK: - Properties
    var isSearch = false
    var keyword = ""
    
    var combinations: [CombinationHomeDto] = []
    var totalPageNum: Int = 0
    var pageNum: Int = 0
    var isLastPage: Bool = false
    
    let todayCombinationView = TodayCombinationView()
    
    // MARK: - View 설정
    override func loadView() {
        view = todayCombinationView
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
    func fetchData() {
        if isSearch { // 검색일 때
            self.pageNum = 0
            CombinationService.shared.getSearch(page: 0, 
                                                keyword: self.keyword) { result in
                switch result {
                case .success(let data):
                    print("오늘의 조합 검색 성공")
                    self.totalPageNum = data.result.totalPage
                    self.isLastPage = data.result.isLast
                    self.combinations = data.result.combinationList
                    DispatchQueue.main.async {
                        self.todayCombinationView.tableView.reloadData()
                    }
                case .failure(let error):
                    print("오늘의 조합 검색 실패 - \(error.localizedDescription)")
                }
            }
        } else {
            self.pageNum = 0
            CombinationService.shared.getAll(page: 0) { result in
                switch result {
                case .success(let data):
                    print("오늘의 조합 홈 조회 성공")
                    self.totalPageNum = data.result.totalPage
                    self.isLastPage = data.result.isLast
                    self.combinations = data.result.combinationList
                    DispatchQueue.main.async {
                        self.todayCombinationView.tableView.reloadData()
                    }
                    
                case .failure(let error):
                    print("오늘의 조합 홈 조회 실패 - \(error.localizedDescription)")
                }
            }
        }
    }

    // MARK: - 새로고침
    private func setupRefresh() {
        self.isSearch = false
        self.pageNum = 0
        
        let rc = todayCombinationView.refreshControl
        rc.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        rc.tintColor = .customOrange
        
        todayCombinationView.tableView.refreshControl = rc
    }
    
    // MARK: - 네비게이션바 설정
    private func setupNaviBar() {
        title = "오늘의 조합"
        
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
        let tb = todayCombinationView.tableView
        
        tb.dataSource = self
        tb.delegate = self
        tb.prefetchDataSource = self
        
        tb.rowHeight = 232 // 셀 높이 고정
        tb.register(TodayCombinationCell.self, forCellReuseIdentifier: "TodayCombinationCell")
    }
    
    // MARK: - 버튼 설정
    private func setupButton() {
        todayCombinationView.customSearchBar.searchBarButton.addTarget(
            self,
            action: #selector(searchBarButtonTapped),
            for: .touchUpInside
        )
        
        todayCombinationView.uploadButton.addTarget(
            self,
            action: #selector(uploadButtonTapped),
            for: .touchUpInside
        )
    }
}

// MARK: - Actions
extension CombiationViewController {
    // 새로고침
    @objc func refreshTable(refresh: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.fetchData()
            refresh.endRefreshing()
        }
    }
    
    // 검색
    @objc func searchBarButtonTapped() {
        let VC = CombinationSearchVC()
        VC.navigationItem.hidesBackButton = true // 검색화면 백버튼 숨기기
        navigationController?.pushViewController(VC, animated: true)
    }
    
    // 업로드
    @objc func uploadButtonTapped() {
        let VC = CombinationUploadVC()
        navigationController?.pushViewController(VC, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension CombiationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return combinations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodayCombinationCell", for: indexPath) as! TodayCombinationCell
        
        let combination = combinations[indexPath.row]
        
        cell.likeSelectedIcon.isHidden = !combination.isLike
        
        if let url = URL(string: combination.combinationImageUrl ?? "defaultImage") {
                    cell.thumnailImage.kf.setImage(with: url)
        }
        
        cell.titleLabel.text = combination.title
        
        cell.hashtagLabel.text = combination.hashTageList.map { "\($0)" }.joined(separator: " ")
        
        cell.commentNumLabel.text = "\(combination.commentCount)"
        
        cell.likeNumLabel.text = "\(combination.likeCount)"
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CombiationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = combinations[indexPath.row].combinationId
        
        let todayCombinationDetailVC = CombinationDetailViewController()
        todayCombinationDetailVC.combinationId = selectedItem
        todayCombinationDetailVC.selectedIndex = indexPath.row
        todayCombinationDetailVC.isLiked = combinations[indexPath.row].isLike
        navigationController?.pushViewController(todayCombinationDetailVC, animated: true)
    }
}

// MARK: - UITableViewDataSourcePrefetching
extension CombiationViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            
            if isSearch { // 검색일 때
                if combinations.count - 1 == indexPath.row && pageNum < totalPageNum && !isLastPage {
                    
                    self.pageNum += 1
                    
                    CombinationService.shared.getSearch(page: self.pageNum, 
                                                        keyword: self.keyword) { result in
                        switch result {
                        case .success(let data):
                            print("오늘의 조합 검색 페이징 성공")
                            self.isLastPage = data.result.isLast
                            self.combinations += data.result.combinationList
                            DispatchQueue.main.async {
                                self.todayCombinationView.tableView.reloadData()
                            }
                        case .failure(let error):
                            print("오늘의 조합 검색 페이징 실패 - \(error.localizedDescription)")
                        }
                    }
                }
            } else {
                if combinations.count - 1 == indexPath.row && pageNum < totalPageNum && !isLastPage {
                    
                    self.pageNum += 1
                    
                    CombinationService.shared.getAll(page: self.pageNum) { result in
                        switch result {
                        case .success(let data):
                            print("오늘의 조합 홈 페이징 성공")
                            self.isLastPage = data.result.isLast
                            self.combinations += data.result.combinationList
                            DispatchQueue.main.async {
                                self.todayCombinationView.tableView.reloadData()
                            }
                            
                        case .failure(let error):
                            print("오늘의 조합 홈 페이징 실패 - \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
}
