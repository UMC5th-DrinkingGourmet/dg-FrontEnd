//
//  SearchResultVC.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

class SearchResultVC: UIViewController {
    
    var exampleArray = ["골뱅이무침", "김치찌개", "국밥", "파스타", "피자", "샐러드"]
    
    private let searchResultView = SearchResultView()
    
    // MARK: - View 설정
    override func loadView() {
        view = searchResultView
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        prepare()
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
    
    // MARK: - 기초 설정
    func prepare() {
        // 키보드 자동 띄우기
        searchResultView.searchBar.textField.becomeFirstResponder()
    }
    
    // MARK: - 테이블뷰 설정
    func setupTableView() {
        let tb = searchResultView.tableView
        
        tb.dataSource = self
        tb.delegate = self
        
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

extension SearchResultVC: UITableViewDataSource {
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

extension SearchResultVC: UITableViewDelegate {
    
}

// MARK: - 검색 결과 화면 X 버튼 터치 시 행 삭제
extension SearchResultVC: SearchResultCellDelegate {
    func didTapDeleteButton(in cell: SearchResultCell) {
        guard let indexPath = searchResultView.tableView.indexPath(for: cell) else { return }
        exampleArray.remove(at: indexPath.row)
        searchResultView.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

