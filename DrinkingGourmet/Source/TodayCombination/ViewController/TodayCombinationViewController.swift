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
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNaviBar()
        setupTableView()
        addViews()
        configureConstraints()
    }
    
    // MARK: - 네비게이션바 설정
    func setupNaviBar() {
        title = "오늘의 조합"
        
        navigationItem.searchController = UISearchController()
        navigationItem.searchController?.searchBar.placeholder = "~~를 입력하세요"
        navigationItem.searchController?.searchBar.setValue("취소", forKey: "cancelButtonText")
        navigationItem.hidesSearchBarWhenScrolling = false
        
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
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.showsVerticalScrollIndicator = false // 스크롤바 숨기기
        tableView.keyboardDismissMode = .onDrag // 스크롤 할 때 키보드 내리기
        tableView.separatorStyle = .none // 테이블뷰 구분선 없애기
        tableView.rowHeight = 232 // 셀 높이 고정
        tableView.register(TodayCombinationCell.self, forCellReuseIdentifier: "TodayCombinationCell")
    }
    
    func addViews() {
        self.view.addSubview(tableView)
    }
    
    func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
    }
}

extension TodayCombinationViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodayCombinationCell", for: indexPath) as! TodayCombinationCell
        
        cell.selectionStyle = .none // cell 선택 시 시각효과 제거
        
        return cell
    }
}

extension TodayCombinationViewController: UITableViewDelegate {
    
}
