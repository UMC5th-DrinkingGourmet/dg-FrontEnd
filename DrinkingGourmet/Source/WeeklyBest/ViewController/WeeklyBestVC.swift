//
//  WeeklyBestVC.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 1/6/24.
//

import UIKit

class WeeklyBestVC: UIViewController {
    
    // MARK: - Properties
    var arrayWeeklyBest: [WeeklyBestModel.CombinationList] = []
    var fetchingMore: Bool = false
    var totalPageNum: Int = 0
    var nowPageNum: Int = 0
    
    let weeklyBestView = WeeklyBestView()
    
    // MARK: - View 설정
    override func loadView() {
        view = weeklyBestView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        prepare()
        setupNaviBar()
        setupTableView()
        setupCustomSearchBar()
    }
    
    func prepare() {
        weeklyBestView.customSearchBar.textField.delegate = self
        
        weeklyBestView.customSearchBar.textField.attributedPlaceholder = NSAttributedString(
            string: "주간 베스트 조합 검색",
            attributes: [
                .foregroundColor: UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1),
                .font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!
            ]
        )
        
        let input = WeeklyBestInput(page: 0)
        WeeklyBestDataManager().fetchWeeklyBestData(input, self) { [weak self] model in
            guard let self = self else { return }
            
            if let model = model {
                self.totalPageNum = model.result.totalPage
                self.arrayWeeklyBest = model.result.combinationList
                DispatchQueue.main.async {
                    self.weeklyBestView.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - 네비게이션바 설정
    func setupNaviBar() {
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
    
    // MARK: - 테이블뷰 설정
    func setupTableView() {
        let tb = weeklyBestView.tableView
        
        tb.dataSource = self
        tb.delegate = self
        
        tb.rowHeight = 232 // 셀 높이 고정
        tb.register(WeeklyBestCell.self, forCellReuseIdentifier: "WeeklyBestCell")
    }
    
    func setupCustomSearchBar() {
        weeklyBestView.customSearchBar.textField.delegate = self
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
        
        if let url = URL(string: weeklyBest.combinationImageUrl) {
            cell.mainImage.kf.setImage(with: url)
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
    
    // MARK: - 페이징
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.bounds.size.height
        
        if offsetY > contentHeight - height {
            if !fetchingMore && totalPageNum > 1 && nowPageNum != totalPageNum {
                fetchingMore = true
                fetchNextPage()
            }
        }
    }
    
    func fetchNextPage() {
        nowPageNum = nowPageNum + 1
        let nextPage = nowPageNum
        let input = WeeklyBestInput(page: nextPage)
        
        WeeklyBestDataManager().fetchWeeklyBestData(input, self) { [weak self] model in
            if let model = model {
                guard let self = self else { return }
                
                self.arrayWeeklyBest += model.result.combinationList
                self.fetchingMore = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.weeklyBestView.tableView.reloadData()
                }
            }
        }
    }
}

extension WeeklyBestVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let weeklyBestSearchVC = WeeklyBestSearchVC()
        weeklyBestSearchVC.navigationItem.hidesBackButton = true // 검색화면 백버튼 숨기기
        navigationController?.pushViewController(weeklyBestSearchVC, animated: true)
    }
}
