//
//  RecipeBookHomeVC.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

final class RecipeBookHomeVC: UIViewController {
    
    // MARK: - Properties
    private let recipeBookHomeView = RecipeBookHomeView()
    
    private lazy var buttons: [UIButton] = [recipeBookHomeView.writeButton, recipeBookHomeView.modifyButton]
    private lazy var labels: [UILabel] = [recipeBookHomeView.writeLabel, recipeBookHomeView.modifyLabel]
    
    private var isShowFloating: Bool = false
    private var isShowLabel: Bool = false
    
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
        
        recipeBookHomeView.writeButton.addTarget(self, action: #selector(writeButtonTapped), for: .touchUpInside)
        
        recipeBookHomeView.modifyButton.addTarget(self, action: #selector(modifyButtonTapped), for: .touchUpInside)
    }
    
    @objc func floatingButtonTapped(_ sender: UIButton) {
        
        let shadowView = recipeBookHomeView.shadowView
        
        if isShowFloating { // 플로팅버튼 열려있을 때
            buttons.reversed().forEach { button in
                UIView.animate(withDuration: 0.3) {
                    button.isHidden = true
                    self.view.layoutIfNeeded()
                }
            }
            labels.forEach { $0.isHidden = true }
            
            UIView.animate(withDuration: 0.5, animations: {
                shadowView.alpha = 0
            }) { (_) in
                shadowView.isHidden = true
            }
        } else { // 플로팅버튼 닫혀있을 때

            shadowView.isHidden = false
            
            UIView.animate(withDuration: 0.5) { shadowView.alpha = 1 }
            
            buttons.forEach { [weak self] button in
                button.isHidden = false
                button.alpha = 0
                
                UIView.animate(withDuration: 0.3) {
                    button.alpha = 1
                    self?.view.layoutIfNeeded()
                }
            }
            labels.forEach { $0.isHidden = false }
        }
        
        isShowFloating = !isShowFloating
        
        let backgroundColor: UIColor = isShowFloating ? .black : .customOrange

        let roatation = isShowFloating ? CGAffineTransform(rotationAngle: .pi - (.pi / 4)) : CGAffineTransform.identity
        
        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = backgroundColor
            sender.transform = roatation
        }
    }
    
    @objc func writeButtonTapped() {
        print("레시피북 작성하기 버튼 눌림")
    }
    
    @objc func modifyButtonTapped() {
        print("레시피북 수정하기 버튼 눌림")
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeBookHomeCell", for: indexPath) as! RecipeBookHomeCell
        
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
