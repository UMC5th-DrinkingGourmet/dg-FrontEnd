//
//  TodayCombinationViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 1/17/24.
//

import UIKit

final class TodayCombinationViewController: UIViewController {
    
    // MARK: - Properties
    var arrayCombinationHome: [CombinationHomeModel.CombinationHomeList] = []
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
    private func fetchData() {
        let input = CombinationHomeInput.fetchCombinationHomeDataInput(page: 0)
        pageNum = 0
        
        CombinationHomeDataManager().fetchCombinationHomeData(input, self) { [weak self] model in
            guard let self = self else { return }
            
            if let model = model {
                self.totalPageNum = model.result.totalPage
                self.isLastPage = model.result.isLast
                self.arrayCombinationHome = model.result.combinationList
                DispatchQueue.main.async {
                    self.todayCombinationView.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - 새로고침
    private func setupRefresh() {
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
        todayCombinationView.customSearchBar.searchBarButton.addTarget(self, action: #selector(searchBarButtonTapped), for: .touchUpInside)
        todayCombinationView.floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
    }
    
}

// MARK: - @objc
extension TodayCombinationViewController {
    @objc func refreshTable(refresh: UIRefreshControl) {
        print("새로고침 시작")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.fetchData()
            refresh.endRefreshing()
        }
    }
    
    @objc func searchBarButtonTapped() {
        let combinationSearchVC = CombinationSearchVC()
        combinationSearchVC.navigationItem.hidesBackButton = true // 검색화면 백버튼 숨기기
        navigationController?.pushViewController(combinationSearchVC, animated: true)
    }
    
    @objc func floatingButtonTapped() {
        let vc = CombinationUploadVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension TodayCombinationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCombinationHome.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodayCombinationCell", for: indexPath) as! TodayCombinationCell
        
        let combination = arrayCombinationHome[indexPath.row]
        
        cell.likeSelectedIcon.isHidden = !combination.isLike
        
        if let url = URL(string: combination.combinationImageUrl ?? "defaultImage") {
                    cell.thumnailImage.kf.setImage(with: url)
        }
        
        cell.titleLabel.text = combination.title
        
        cell.hashtagLabel.text = combination.hashTageList.map { "\($0)" }.joined(separator: " ")
        
        cell.commentNumLabel.text = "\(combination.commentCount)"
        
        cell.likeNumLabel.text = "\(combination.likeCount)"
        
        cell.selectionStyle = .none // cell 선택 시 시각효과 제거
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TodayCombinationViewController: UITableViewDelegate {func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = arrayCombinationHome[indexPath.row].combinationId
        
        let todayCombinationDetailVC = TodayCombinationDetailViewController()
        todayCombinationDetailVC.combinationId = selectedItem
        todayCombinationDetailVC.selectedIndex = indexPath.row
        todayCombinationDetailVC.isLiked = arrayCombinationHome[indexPath.row].isLike
        navigationController?.pushViewController(todayCombinationDetailVC, animated: true)
    }
}

// MARK: - UITableViewDataSourcePrefetching
extension TodayCombinationViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            
            if arrayCombinationHome.count - 1 == indexPath.row && pageNum < totalPageNum &&  !isLastPage {
                
                pageNum += 1
                
                let input = CombinationHomeInput.fetchCombinationHomeDataInput(page: pageNum)
                
                CombinationHomeDataManager().fetchCombinationHomeData(input, self) { [weak self] model in
                    if let model = model {
                        guard let self = self else { return }
                        self.arrayCombinationHome += model.result.combinationList
                        self.isLastPage = model.result.isLast
                        DispatchQueue.main.async {
                            self.todayCombinationView.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
}
