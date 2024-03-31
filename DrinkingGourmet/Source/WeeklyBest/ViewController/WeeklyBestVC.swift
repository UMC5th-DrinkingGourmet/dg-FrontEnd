//
//  WeeklyBestVC.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 1/6/24.
//

import UIKit

final class WeeklyBestVC: UIViewController {
    
    // MARK: - Properties
    var arrayWeeklyBest: [WeeklyBestModel.CombinationList] = []
    var totalPageNum: Int = 0
    var pageNum: Int = 0
    var isLastPage: Bool = false
    
    let weeklyBestView = WeeklyBestView()
    
    // MARK: - View 설정
    override func loadView() {
        view = weeklyBestView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        setupRefresh()
        setupNaviBar()
        setupTextField()
        setupTableView()
    }
    
    // MARK: - 데이터 가져오기
    private func fetchData() {
        let input = WeeklyBestInput(page: 0)
        pageNum = 0
        
        WeeklyBestDataManager().fetchWeeklyBestData(input, self) { [weak self] model in
            guard let self = self else { return }
            
            if let model = model {
                self.totalPageNum = model.result.totalPage
                self.isLastPage = model.result.isLast
                self.arrayWeeklyBest = model.result.combinationList
                DispatchQueue.main.async {
                    self.weeklyBestView.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - 새로고침
    private func setupRefresh() {
        let rc = weeklyBestView.refreshControl
        rc.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        rc.tintColor = .customOrange
        
        weeklyBestView.tableView.refreshControl = rc
    }
    
    // MARK: - 네비게이션바 설정
    private func setupNaviBar() {
        title = "주간 베스트 조합"
        
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
    
    // MARK: - 텍스트필드 설정
    private func setupTextField() {
        let tf = weeklyBestView.customSearchBar.textField
        
        tf.delegate = self
        tf.attributedPlaceholder = NSAttributedString(
            string: "오늘의 조합 검색",
            attributes: [
                .foregroundColor: UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1),
                .font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!
            ]
        )
    }
    
    // MARK: - 테이블뷰 설정
    private func setupTableView() {
        let tb = weeklyBestView.tableView
        
        tb.dataSource = self
        tb.delegate = self
        tb.prefetchDataSource = self
        
        tb.rowHeight = 232 // 셀 높이 고정
        tb.register(WeeklyBestCell.self, forCellReuseIdentifier: "WeeklyBestCell")
    }
}

// MARK: - @objc
extension WeeklyBestVC {
    @objc func refreshTable(refresh: UIRefreshControl) {
        print("새로고침 시작")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.fetchData()
            refresh.endRefreshing()
        }
    }
}

// MARK: - UITextFieldDelegate
extension WeeklyBestVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let weeklyBestSearchVC = WeeklyBestSearchVC()
        weeklyBestSearchVC.navigationItem.hidesBackButton = true // 검색화면 백버튼 숨기기
        navigationController?.pushViewController(weeklyBestSearchVC, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension WeeklyBestVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayWeeklyBest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeeklyBestCell", for: indexPath) as! WeeklyBestCell
        
        let weeklyBest = arrayWeeklyBest[indexPath.row]
        
        cell.likeSelectedIcon.isHidden = !weeklyBest.isLike
        
        if let url = URL(string: weeklyBest.combinationImageUrl) {
            cell.thumnailImage.kf.setImage(with: url)
        }
        
        cell.titleLabel.text = weeklyBest.title
        
        let hashtags = weeklyBest.hashTageList.map { "#\($0)" }.joined(separator: " ")
        cell.hashtagLabel.text = hashtags
        
        cell.commentNumLabel.text = "\(weeklyBest.commentCount)"
        
        cell.likeNumLabel.text = "\(weeklyBest.likeCount)"
        
        cell.selectionStyle = .none // cell 선택 시 시각효과 제거
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension WeeklyBestVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = arrayWeeklyBest[indexPath.row].combinationId
        
        let todayCombinationDetailVC = TodayCombinationDetailViewController()
        todayCombinationDetailVC.combinationId = selectedItem
        navigationController?.pushViewController(todayCombinationDetailVC, animated: true)
    }
}

// MARK: - UITableViewDataSourcePrefetching
extension WeeklyBestVC: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            
            if arrayWeeklyBest.count - 1 == indexPath.row && pageNum < totalPageNum &&  !isLastPage {
                
                pageNum += 1
                
                let inputt = WeeklyBestInput(page: pageNum)
                
                WeeklyBestDataManager().fetchWeeklyBestData(inputt, self) { [weak self] model in
                    if let model = model {
                        guard let self = self else { return }
                        self.arrayWeeklyBest += model.result.combinationList
                        self.isLastPage = model.result.isLast
                        DispatchQueue.main.async {
                            self.weeklyBestView.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
}
