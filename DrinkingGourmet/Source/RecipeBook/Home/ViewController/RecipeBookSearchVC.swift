//
//  RecipeBookSearchVC.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

import UIKit

class RecipeBookSearchVC: UIViewController {
    
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
        
        searchResultView.searchBar.textField.attributedPlaceholder = NSAttributedString(
            string: "레시피북 검색",
            attributes: [
                .foregroundColor: UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1),
                .font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!
            ]
        )
        searchResultView.searchBar.textField.delegate = self
    }
    
    // MARK: - 테이블뷰 설정
    func setupTableView() {
        let tb = searchResultView.tableView
        
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
        searchResultView.tableView.reloadData()
    }

}

// MARK: - UITextFieldDelegate
extension RecipeBookSearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // 키보드 숨기기
        
        let input = RecipeBookHomeInput.fetchRecipeBookDataForSearchInput(page: 0, keyword: searchResultView.searchBar.textField.text)
        
        RecipeBookHomeDataManager().fetchRecipeBookDataForSearch(input, self) { [weak self] model in
            if let model = model {
                self?.navigationController?.popViewController(animated: true)
                guard let recipeBookHomeVC = self?.navigationController?.topViewController as? RecipeBookHomeVC else {
                    return
                }
                
//                todayCombinationViewController.totalPageNum = model.result.totalPage
                recipeBookHomeVC.arrayRecipeBookHome = model.result.recipeList
                
                // 스크롤을 맨 위로 이동
                recipeBookHomeVC.recipeBookHomeView.tableView.setContentOffset(CGPoint(x: 0, y: -recipeBookHomeVC.recipeBookHomeView.tableView.contentInset.top), animated: false)
                
                recipeBookHomeVC.recipeBookHomeView.tableView.reloadData()
            }
        }
        return true
    }
}
