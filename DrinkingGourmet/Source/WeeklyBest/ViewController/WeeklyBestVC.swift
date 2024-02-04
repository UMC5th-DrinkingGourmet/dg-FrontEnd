//
//  WeeklyBestVC.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 1/6/24.
//

import UIKit

class WeeklyBestVC: UIViewController {
    
    private let weeklyBestView = WeeklyBestView()
    
    // MARK: - View 설정
    override func loadView() {
        view = weeklyBestView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNaviBar()
        setupTableView()
        setupCustomSearchBar()
    }
    
    // MARK: - 네비게이션바 설정
    func setupNaviBar() {
        title = "주간 베스트 조합"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // 불투명
        appearance.backgroundColor = .white
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

extension WeeklyBestVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeeklyBestCell", for: indexPath) as! WeeklyBestCell
        
        cell.selectionStyle = .none // cell 선택 시 시각효과 제거
        
        return cell
    }
}

extension WeeklyBestVC: UITableViewDelegate {
//    // 셀 선택시 Detail 화면으로
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let todayCombinationDetailVC = TodayCombinationDetailViewController()
//        navigationController?.pushViewController(todayCombinationDetailVC, animated: true)
//    }
}

extension WeeklyBestVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let searchResultsVC = SearchResultVC()
        searchResultsVC.navigationItem.hidesBackButton = true // 검색화면 백버튼 숨기기
        navigationController?.pushViewController(searchResultsVC, animated: true)
    }
    
}
