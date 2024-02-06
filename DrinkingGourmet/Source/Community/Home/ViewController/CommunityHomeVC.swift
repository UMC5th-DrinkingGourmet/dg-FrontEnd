//
//  CommunityHomeVC.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

class CommunityHomeVC: UIViewController {
    
    private let communityView = CommunityHomeView()
    
    var communitiesArray: [CommunityHome] = []
    
    var DataManager = CommunityHomeDataManager()
    
    // MARK: - View 설정
    override func loadView() {
        view = communityView
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNaviBar()
        setupDatas()
        setupTableView()
    }
    
    // MARK: - 네비게이션바 설정
    func setupNaviBar() {
        title = "커뮤니티"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // 불투명
        appearance.backgroundColor = .white
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - 데이터 뷰컨 배열에 저장
    func setupDatas() {
        communitiesArray = DataManager.getCommunityData()
    }
    
    // MARK: - 테이블뷰 설정
    func setupTableView() {
        let tb = communityView.tableView
        
        tb.dataSource = self
        tb.delegate = self
        
        tb.rowHeight = 156
        tb.register(CommunityHomeCell.self, forCellReuseIdentifier: "CommunityHomeCell")
    }
    
}

extension CommunityHomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.communitiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityHomeCell", for: indexPath) as! CommunityHomeCell
        
        cell.mainImage.image = communitiesArray[indexPath.row].communityImage
        cell.selectionStyle = .none
        
        return cell
    }
}

extension CommunityHomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var detailVC: UIViewController?
        
        switch indexPath.row {
        case 0:
            detailVC = TodayCombinationViewController()
        case 1:
            detailVC = WeeklyBestVC()
        case 2:
            detailVC = RecipeBookHomeVC()
        default:
            break
        }
        
        if let detailViewController = detailVC {
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

extension CommunityHomeVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let searchResultsVC = SearchResultVC()
        searchResultsVC.navigationItem.hidesBackButton = true // 검색화면 백버튼 숨기기
        navigationController?.pushViewController(searchResultsVC, animated: true)
    }
    
}
