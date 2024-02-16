//
//  CombinationSearchVC.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/11/24.
//

import UIKit

class CombinationSearchVC: UIViewController {
    
    // MARK: - Properties
    var exampleArray = ["오늘의조합 검색화면 TEST", "오늘의조합 검색화면 TEST", "오늘의조합 검색화면 TEST", "오늘의조합 검색화면 TEST", "오늘의조합 검색화면 TEST", "오늘의조합 검색화면 TEST"]
    
    private let searchResultView = SearchResultView()
    
    // MARK: - View 설정
    override func loadView() {
        view = searchResultView
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupTextField()
        setupTableView()
        setupButton()
    }
    
    // MARK: - viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false) // 검색 화면에 진입할 때 네비게이션 바 숨기기
    }
    
    // MARK: - viewWillDisappear()
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false) // 검색 화면에서 빠져나올 때 네비게이션 바 보이기
    }
    
    // MARK: - 텍스트필드 설정
    func setupTextField() {
        let tf = searchResultView.searchBar.textField
        
        tf.delegate = self
        tf.becomeFirstResponder() // 키보드 자동 띄우기
        tf.attributedPlaceholder = NSAttributedString(
            string: "오늘의 조합 검색",
            attributes: [
                .foregroundColor: UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1),
                .font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!
            ]
        )
    }
    
    // MARK: - 테이블뷰 설정
    func setupTableView() {
        let tb = searchResultView.tableView
        
        tb.dataSource = self
        tb.rowHeight = 48
        tb.register(SearchResultCell.self, forCellReuseIdentifier: "SearchResultCell")
    }
    
    // MARK: - 버튼 설정
    func setupButton() {
        searchResultView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        searchResultView.deleteAllButton.addTarget(self, action: #selector(deleteAllButtonTapped), for: .touchUpInside)
    }
    
    @objc func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteAllButtonTapped() {
        exampleArray.removeAll()
        searchResultView.tableView.reloadData()
    }

}

// MARK: - UITableViewDataSource
extension CombinationSearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exampleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
        
        cell.searchLabel.text = exampleArray[indexPath.row]
        cell.delegate = self
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - SearchResultCellDelegate
extension CombinationSearchVC: SearchResultCellDelegate {
    func didTapDeleteButton(in cell: SearchResultCell) { // X 버튼 터치 시 행 삭제
        guard let indexPath = searchResultView.tableView.indexPath(for: cell) else { return }
        exampleArray.remove(at: indexPath.row)
        searchResultView.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

// MARK: - UITextFieldDelegate
extension CombinationSearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // 키보드 숨기기
        
        let input = CombinationHomeInput.fetchCombinationSearchDataInput(page: 0, keyword: searchResultView.searchBar.textField.text)
        
        CombinationHomeDataManager().fetchCombinationSearchData(input, self) { [weak self] model in
            if let model = model {
                self?.navigationController?.popViewController(animated: true)
                guard let todayCombinationViewController = self?.navigationController?.topViewController as? TodayCombinationViewController else {
                    return
                }
                
                todayCombinationViewController.totalPageNum = model.result.totalPage
                todayCombinationViewController.arrayCombinationHome = model.result.combinationList
                
                // 스크롤을 맨 위로 이동
                todayCombinationViewController.todayCombinationView.tableView.setContentOffset(CGPoint(x: 0, y: -todayCombinationViewController.todayCombinationView.tableView.contentInset.top), animated: false)
                
                todayCombinationViewController.todayCombinationView.tableView.reloadData()
            }
        }
        return true
    }
}