//
//  RecipeBookHomeVC.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

final class RecipeBookHomeVC: UIViewController {
    
    // MARK: - Properties
    var arrayRecipeBookHome: [RecipeBookHomeModel.Result] = []
    var fetchingMore: Bool = false
    var totalPageNum: Int = 0
    var nowPageNum: Int = 0
    
    private let recipeBookHomeView = RecipeBookHomeView()
    
    // MARK: - View 설정
    override func loadView() {
        view = recipeBookHomeView
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
        recipeBookHomeView.customSearchBar.textField.delegate = self
        
        recipeBookHomeView.customSearchBar.textField.attributedPlaceholder = NSAttributedString(
            string: "레시피북 검색",
            attributes: [
                .foregroundColor: UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1),
                .font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!
            ]
        )
        
        let input = RecipeBookHomeInput(page: 0)
        RecipeBookHomeDataManager().fetchRecipeBookHomeData(input, self) { [weak self] model in
            guard let self = self else { return }
            
            if let model = model {
//                self.totalPageNum = model.result.totalPage
                self.arrayRecipeBookHome = model.result
                DispatchQueue.main.async {
                    self.recipeBookHomeView.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - 네비게이션바 설정
    func setupNaviBar() {
        title = "음주미식회 레시피북"
        
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
        let tb = recipeBookHomeView.tableView
        
        tb.dataSource = self
        tb.delegate = self
        
        tb.rowHeight = 232 // 셀 높이 고정
        tb.register(RecipeBookHomeCell.self, forCellReuseIdentifier: "RecipeBookHomeCell")
    }
    
    // MARK: - 플로팅버튼 설정
    func setupFloatingButton() {
        recipeBookHomeView.floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
    }
    
    @objc func floatingButtonTapped() {
        let vc = UploadViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension RecipeBookHomeVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let searchResultsVC = SearchResultVC()
        searchResultsVC.navigationItem.hidesBackButton = true // 검색화면 백버튼 숨기기
        navigationController?.pushViewController(searchResultsVC, animated: true)
    }
}

extension RecipeBookHomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRecipeBookHome.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeBookHomeCell", for: indexPath) as! RecipeBookHomeCell
        
        let recipeBook = arrayRecipeBookHome[indexPath.row]
        
        // 이미지 API 필요
        
        cell.titleLabel.text = recipeBook.name
        
//        let hashtags = combination.hashTageList.map { "#\($0)" }.joined(separator: " ")
//        cell.hashtagLabel.text = hashtags
        
        cell.commentNumLabel.text = "\(recipeBook.commentCount)"
        
        cell.likeNumLabel.text = "\(recipeBook.likeCount)"
        
        cell.selectionStyle = .none // cell 선택 시 시각효과 제거
        
        return cell
    }
}

extension RecipeBookHomeVC: UITableViewDelegate {
    // 셀 선택시 Detail 화면으로
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeBookDetailVC = RecipeBookDetailVC()
        navigationController?.pushViewController(recipeBookDetailVC, animated: true)
    }
}
