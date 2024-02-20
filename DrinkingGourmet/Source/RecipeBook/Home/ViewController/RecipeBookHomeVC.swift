//
//  RecipeBookHomeVC.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

final class RecipeBookHomeVC: UIViewController {
    
    // MARK: - Properties
    var arrayRecipeBookHome: [RecipeBookHomeModel.RecipeList] = []
    var totalPageNum: Int = 0
    var pageNum: Int = 0
    var isLastPage: Bool = false
    
    let recipeBookHomeView = RecipeBookHomeView()
    
    // MARK: - View 설정
    override func loadView() {
        view = recipeBookHomeView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        prepare()
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNaviBar()
        setupTextField()
        setupTableView()
        setupFloatingButton()
    }
    
    func prepare() {
        let input = RecipeBookHomeInput.fetchRecipeBookHomeDataInput(page: 0)
        pageNum = 0
        
        RecipeBookHomeDataManager().fetchRecipeBookHomeData(input, self) { [weak self] model in
            guard let self = self else { return }
            
            if let model = model {
                self.totalPageNum = model.result.totalPage
                self.isLastPage = model.result.isLast
                self.arrayRecipeBookHome = model.result.recipeList
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
    
    // MARK: - 텍스트필드 설정
    func setupTextField() {
        recipeBookHomeView.customSearchBar.textField.delegate = self
        
        recipeBookHomeView.customSearchBar.textField.attributedPlaceholder = NSAttributedString(
            string: "레시피북 검색",
            attributes: [
                .foregroundColor: UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1),
                .font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!
            ]
        )
    }
    
    // MARK: - 테이블뷰 설정
    func setupTableView() {
        let tb = recipeBookHomeView.tableView
        
        tb.dataSource = self
        tb.delegate = self
        tb.prefetchDataSource = self
        
        tb.rowHeight = 232 // 셀 높이 고정
        tb.register(RecipeBookHomeCell.self, forCellReuseIdentifier: "RecipeBookHomeCell")
    }
    
    // MARK: - 플로팅버튼 설정
    func setupFloatingButton() {
        recipeBookHomeView.floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
    }
    
    @objc func floatingButtonTapped() {
        let vc = RecipeBookUploadViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension RecipeBookHomeVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let recipeBookSearchVC = RecipeBookSearchVC()
        recipeBookSearchVC.navigationItem.hidesBackButton = true // 검색화면 백버튼 숨기기
        navigationController?.pushViewController(recipeBookSearchVC, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension RecipeBookHomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRecipeBookHome.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeBookHomeCell", for: indexPath) as! RecipeBookHomeCell
        
        let recipeBook = arrayRecipeBookHome[indexPath.row]
        
        cell.likeSelectedIcon.isHidden = !recipeBook.like
        
        if !recipeBook.recipeImageList.isEmpty {
            if let url = URL(string: recipeBook.recipeImageList[0]) {
                cell.mainImage.kf.setImage(with: url)
            }
        } else {
            // 이미지 리스트가 비어 있을 경우의 처리
            // 예: 기본 이미지 설정 또는 이미지 뷰 숨기기
            cell.mainImage.image = UIImage(named: "defaultImage") // "defaultImage"는 기본 이미지의 이름
        }

        
        cell.titleLabel.text = recipeBook.title
        
        cell.hashtagLabel.text = recipeBook.hashTagNameList.map { "#\($0)" }.joined(separator: " ")
        
        cell.commentNumLabel.text = "\(recipeBook.commentCount)"
        
        cell.likeNumLabel.text = "\(recipeBook.likeCount)"
        
        cell.selectionStyle = .none // cell 선택 시 시각효과 제거
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension RecipeBookHomeVC: UITableViewDelegate {
    // 셀 선택시 Detail 화면으로
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = arrayRecipeBookHome[indexPath.row].id
        
        let recipeBookDetailVC = RecipeBookDetailVC()
        recipeBookDetailVC.recipeBookId = selectedItem
        navigationController?.pushViewController(recipeBookDetailVC, animated: true)
    }
}

// MARK: - UITableViewDataSourcePrefetching
extension RecipeBookHomeVC: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            
            if arrayRecipeBookHome.count - 1 == indexPath.row && pageNum < totalPageNum &&  !isLastPage {
                
                pageNum += 1
                
                let input = RecipeBookHomeInput.fetchRecipeBookHomeDataInput(page: pageNum)
                
                RecipeBookHomeDataManager().fetchRecipeBookHomeData(input, self) { [weak self] model in
                    if let model = model {
                        guard let self = self else { return }
                        self.arrayRecipeBookHome += model.result.recipeList
                        self.isLastPage = model.result.isLast
                        DispatchQueue.main.async {
                            self.recipeBookHomeView.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
}
