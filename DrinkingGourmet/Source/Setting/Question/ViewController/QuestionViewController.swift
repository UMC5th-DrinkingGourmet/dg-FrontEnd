//
//  QuestionViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/1/24.
//

import UIKit

final class QuestionViewController: UIViewController {
    // MARK: - Properties
    private let detailQuestions: [(question: String, answer: String)] = [
        ("이 서비스는 어떤 기준으로 음식과 어울리는 주류를 추천하나요?", "우리 서비스는 다양한 요인을 종합적으로 고려하여 음식과 어울리는 주류를 추천합니다. \n\n이에는 음식의 맛(단맛, 산미, 짠맛, 매운맛 등), 질감, 조리 방법 및 주재료의 특성과 같은 요소가 포함됩니다. \n\n또한, 세계 각국의 전통적인 음식과 주류 조합, 소믈리에의 추천, 그리고 사용자 리뷰와 평가도 참고합니다."),
        ("특정 알레르기가 있는 경우, 안전하게 주류를 선택할 수 있나요?", "네, 가능합니다. \n\n사용자가 알레르기 정보를 프로필에 입력할 경우, 우리 시스템은 해당 정보를 고려하여 알레르기 유발 요소를 포함하지 않은 주류를 추천합니다. \n\n알레르기 정보는 언제든지 프로필 설정에서 업데이트할 수 있습니다."),
        ("비알코올 음료도 추천해 주나요?", "네, 우리 서비스는 알코올 음료뿐만 아니라 비알코올 음료 추천도 제공합니다. \n\n음식에 어울리는 다양한 종류의 비알코올 음료, 예를 들어 목테일, 비알코올 와인, 비알코올 맥주 등을 추천받을 수 있습니다."),
        ("음식과 주류의 조합을 직접 추천할 수도 있나요?", "네, 사용자가 직접 음식과 주류의 조합을 추천할 수 있습니다. \n\n사용자가 경험한 매칭에 대한 리뷰와 평가를 공유하면, 이 정보는 다른 사용자에게도 도움이 될 수 있습니다. \n\n사용자 커뮤니티의 의견을 반영하여 서비스를 지속적으로 개선해 나갑니다."),
        ("이 서비스를 사용하기 위한 비용이 있나요?", "기본적인 음식과 주류의 매칭 추천 서비스는 무료로 제공됩니다. \n\n그러나, 프리미엄 기능이나 개인화된 추천을 원하는 사용자를 위해 유료 구독 서비스를 제공하고 있습니다. \n\n유료 서비스에는 전문 소믈리에의 1:1 상담, 고급 주류 추천, 특별 이벤트 초대 등의 혜택이 포함됩니다."),
        ("회원탈퇴 버튼을 못찾겠어요", "회원 탈퇴가 필요하신 경우, 아래의 '회원 탈퇴' 버튼을 클릭해주시기 바랍니다.")
    ]
    
    private let questionView = QuestionView()
    
    // MARK: - View 설정
    override func loadView() {
        view = questionView
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNaviBar()
        setupTableView()
    }
    
    private func setupNaviBar() {
        title = "자주 묻는 질문"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupTableView() {
        let tb = questionView.tableView
        tb.tableHeaderView = UIView()
        tb.register(QuestionCell.self, forCellReuseIdentifier: "QuestionCell")
        tb.dataSource = self
        tb.delegate = self
    }
}

// MARK: - UITableViewDataSource
extension QuestionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! QuestionCell
        cell.questionLabel.text = detailQuestions[indexPath.row].question
        return cell
    }
}

// MARK: - UITableViewDelegate
extension QuestionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedQuestion = detailQuestions[indexPath.row].question
        if selectedQuestion == "회원탈퇴 버튼을 못찾겠어요" {
            let VC = DeleteAccountViewController()
            navigationController?.pushViewController(VC, animated: true)
        } else {
            let VC = AnswerViewController()
            VC.answer = detailQuestions[indexPath.row].answer
            navigationController?.pushViewController(VC, animated: true)
        }
    }
}
