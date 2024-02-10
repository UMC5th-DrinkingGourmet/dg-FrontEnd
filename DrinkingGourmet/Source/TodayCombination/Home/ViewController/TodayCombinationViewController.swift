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
    
    var arrayCombinationHome: [CombinationHomeList] = []
    var fetchingMore: Bool = false
    var totalPageNum: Int = 0
    var nowPageNum: Int = 0
    
    private let todayCombinationView = TodayCombinationView()
    
    // MARK: - View 설정
    override func loadView() {
        view = todayCombinationView
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        prepare()
        setupNaviBar()
        setupTableView()
        setupFloatingButton()
    }
    
    func prepare() {
        todayCombinationView.customSearchBar.textField.delegate = self
        
        let input = CombinationHomeInput(page: 0)
        CombinationHomeDataManager().combinationHomeDataManager(input, self) { [weak self] model in
            if let model = model {
                self?.totalPageNum = model.result.totalPage
                self?.arrayCombinationHome = model.result.combinationList
                DispatchQueue.main.async {
                    self?.todayCombinationView.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - 네비게이션바 설정
    func setupNaviBar() {
        title = "오늘의 조합"
        
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
        let tb = todayCombinationView.tableView
        
        tb.dataSource = self
        tb.delegate = self
        
        tb.rowHeight = 232 // 셀 높이 고정
        tb.register(TodayCombinationCell.self, forCellReuseIdentifier: "TodayCombinationCell")
    }
    
    // MARK: - 플로팅버튼 설정
    func setupFloatingButton() {
        todayCombinationView.floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
    }
    
    @objc func floatingButtonTapped() {
        let vc = UploadViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TodayCombinationViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let searchResultsVC = SearchResultVC()
        searchResultsVC.navigationItem.hidesBackButton = true // 검색화면 백버튼 숨기기
        navigationController?.pushViewController(searchResultsVC, animated: true)
    }
}

extension TodayCombinationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCombinationHome.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodayCombinationCell", for: indexPath) as! TodayCombinationCell
        
        let combination = arrayCombinationHome[indexPath.row]
        
        if let url = URL(string: combination.combinationImageURL) {
            cell.mainImage.kf.setImage(with: url)
        }
        
        cell.titleLabel.text = combination.title
        
        let hashtags = combination.hashTageList.map { "#\($0)" }.joined(separator: " ")
        cell.hashtagLabel.text = hashtags
        
        cell.commentNumLabel.text = "\(combination.commentCount)"
        
        cell.likeNumLabel.text = "\(combination.likeCount)"
        
        cell.selectionStyle = .none // cell 선택 시 시각효과 제거
        
        return cell
    }
    
    func fetchNextPage() {
//        print(#function)
//        print("nowPageNum - \(nowPageNum)") // 현재 페이지
        nowPageNum = nowPageNum + 1
        let nextPage = nowPageNum
//        print("nextPage : \(nextPage)") // 다음 요청할 페이지
        let input = CombinationHomeInput(page: nextPage)
        
        CombinationHomeDataManager().combinationHomeDataManager(input, self) { [weak self] model in
//            print(input)
//            print("테스트")
            if let model = model {
                self?.arrayCombinationHome += model.result.combinationList
                self?.fetchingMore = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self?.todayCombinationView.tableView.reloadData()
                }
            }
        }
    }
}

extension TodayCombinationViewController: UITableViewDelegate {
    // 셀 선택시 Detail 화면으로
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todayCombinationDetailVC = TodayCombinationDetailViewController()
        navigationController?.pushViewController(todayCombinationDetailVC, animated: true)
    }
    
    //페이징
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.bounds.size.height
        
        if offsetY > contentHeight - height {
//            print("맨 아래에 도달")
//            print("totalPageNum - \(totalPageNum)")
//            print("nowPageNum - \(nowPageNum)")
            if !fetchingMore && totalPageNum > 1 && nowPageNum != totalPageNum {
                fetchingMore = true
//                print("fetchingMore - \(fetchingMore)")
                fetchNextPage()
            }
        }
    }
}
