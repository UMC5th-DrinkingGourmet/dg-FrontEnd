//
//  QuestionViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/1/24.
//

import UIKit

final class QuestionViewController: UIViewController {
    // MARK: - Properties
    private let questions = ["이 서비스는 어떤 기준으로 음식과 어울리는 주류를 추천하나요?",
                             "특정 알레르기가 있는 경우, 안전하게 주류를 선택할 수 있나요?",
                             "비알코올 음료도 추천해 주나요?",
                             "음식과 주류의 조합을 직접 추천할 수도 있나요?",
                             "이 서비스를 사용하기 위한 비용이 있나요?",
                             "회원탈퇴 버튼을 못찾겠어요"]
    
    private let questionView = QuestionView()
    
    // MARK: - View 설정
    override func loadView() {
        view = questionView
    }
    
    // MARK: - ViewDidLodad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNaviBar()
        setupTableView()
    }
    
    private func setupNaviBar() {
        title = "자주 묻는 질문"
    }
    
    private func setupTableView() {
        let tb = questionView.tableView
        tb.tableHeaderView = UIView()
        tb.register(QuestionCell.self, forCellReuseIdentifier: "QuestionCell")
        tb.dataSource = self
        tb.delegate = self
    }
}

extension QuestionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! QuestionCell
        cell.questionLabel.text = questions[indexPath.row]
        return cell
    }
}

extension QuestionViewController: UITableViewDelegate {
    
}
