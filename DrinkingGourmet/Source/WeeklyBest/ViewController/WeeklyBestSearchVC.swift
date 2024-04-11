//
//  WeeklyBestSearchVC.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

import UIKit

class WeeklyBestSearchVC: UIViewController {
    // MARK: - Properties
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
        tf.placeholder = "레시피북 검색"
    }

    // MARK: - 버튼 설정
    func setupButton() {
        searchResultView.cancelButton.addTarget(
            self,
            action: #selector(cancelButtonTapped),
            for: .touchUpInside
        )
    }
}

// MARK: - @objc
extension WeeklyBestSearchVC {
    @objc func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension WeeklyBestSearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // 키보드 숨기기
        
        if let weeklyBestVC = navigationController?.viewControllers.first(where: { $0 is WeeklyBestVC }) as? WeeklyBestVC {
            
            weeklyBestVC.isReturningFromSearch = true
            weeklyBestVC.searchKeyword = searchResultView.searchBar.textField.text ?? ""
            weeklyBestVC.fetchData()
            weeklyBestVC.weeklyBestView.tableView.setContentOffset(CGPoint.zero, animated: true)
            navigationController?.popViewController(animated: true)
        }
        return true
    }
}
