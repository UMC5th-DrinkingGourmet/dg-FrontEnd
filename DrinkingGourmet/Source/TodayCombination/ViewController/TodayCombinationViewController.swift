//
//  TodayCombinationViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 1/17/24.
//

import UIKit
import SnapKit
import Then

class TodayCombinationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNaviBar()
    }
    
    // MARK: - 네비게이션바 설정
    private func setupNaviBar() {
        title = "오늘의 조합"
        
        navigationItem.searchController = UISearchController()
        navigationItem.searchController?.searchBar.placeholder = "~~를 입력하세요"
        navigationItem.searchController?.searchBar.setValue("취소", forKey: "cancelButtonText")
        
        // 돋보기 색상 변경
        let textField = navigationItem.searchController?.searchBar.value(forKey: "searchField") as! UITextField
        let magnifierView = textField.leftView as! UIImageView
        magnifierView.tintColor = UIColor(red: 0.0863, green: 0.0863, blue: 0.0863, alpha: 1)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // 불투명으로
        appearance.backgroundColor = .white
        
        navigationController?.navigationBar.tintColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        // 네비게이션바 밑줄 없애기
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        // 백버튼 아이템 타이틀 없애기
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
    }

}
