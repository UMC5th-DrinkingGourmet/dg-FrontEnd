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
    
    private let todayCombinationView = TodayCombinationView()
    
    private lazy var buttons: [UIButton] = [todayCombinationView.writeButton, todayCombinationView.modifyButton]
    private lazy var labels: [UILabel] = [todayCombinationView.writeLabel, todayCombinationView.modifyLabel]
    
    private var isShowFloating: Bool = false
    private var isShowLabel: Bool = false
    
    // MARK: - View 설정
    override func loadView() {
        view = todayCombinationView
    }
    
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
        
        todayCombinationView.writeButton.addTarget(self, action: #selector(writeButtonTapped), for: .touchUpInside)
        
        todayCombinationView.modifyButton.addTarget(self, action: #selector(modifyButtonTapped), for: .touchUpInside)
    }
    
    @objc func floatingButtonTapped(_ sender: UIButton) {
        
        let shadowView = todayCombinationView.shadowView
        
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
        print("작성하기 버튼 눌림")
    }
    
    @objc func modifyButtonTapped() {
        print("수정하기 버튼 눌림")
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodayCombinationCell", for: indexPath) as! TodayCombinationCell
        
        cell.selectionStyle = .none // cell 선택 시 시각효과 제거
        
        return cell
    }
}

extension TodayCombinationViewController: UITableViewDelegate {
    // 셀 선택시 Detail 화면으로
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todayCombinationDetailVC = TodayCombinationDetailViewController()
        navigationController?.pushViewController(todayCombinationDetailVC, animated: true)
    }
}
