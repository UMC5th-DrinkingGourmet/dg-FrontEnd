//
//  TermsAndPoliciesViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/8/24.
//

import UIKit

final class TermsAndPoliciesViewController: UIViewController {
    // MARK: - Properties
    private let detailQuestions: [(question: String, answer: String)] = [
        ("이용 약관",
         """
        서비스 소개
         · 본 이용 약관은 "음주 미식회" 서비스(이하 '서비스')의 이용 조건 및 절차, 사용자와 운영자의 권리, 의무, 책임 사항 등 기본적인 사항을 규정합니다.
        
        이용 조건
         · 서비스를 사용함으로써, 사용자는 본 약관에 동의하는 것으로 간주합니다.
         · 사용자는 서비스 이용 시 법적인 제한사항을 준수해야 합니다.
        
        계정 관리
         · 사용자는 자신의 계정 정보를 안전하게 관리해야 합니다.
         · 계정의 부정 사용에 대한 책임은 사용자에게 있습니다.
        
        지적 재산권
         · 서비스에 포함된 모든 콘텐츠의 저작권은 "음주 미식회"에 있습니다.
        
        면책 조항
         · 서비스 운영자는 서비스 이용으로 발생하는 직접적, 간접적 손해에 대해 책임지지 않습니다.
        
        약관의 변경
         · 서비스 운영자는 필요시 이용 약관을 변경할 수 있으며, 변경된 약관은 서비스 내에 공지됩니다.
        """
        ),
        
        ("개인 정보 처리 방침",
        """
        개인 정보 수집 및 이용
         · 서비스는 사용자의 음료 추천 및 서비스 개선을 위해 필요한 최소한의 개인 정보를 수집합니다.
                
        수집 항목
         · 이름, 이메일 주소, 선호하는 음료, 사용 기록 등.
                
        정보 보호
         · 수집된 정보는 엄격한 보안 조치를 통해 보호됩니다.
                
        정보 공유 및 공개
         · 사용자의 동의 없이 개인 정보를 제3자에게 공유하거나 공개하지 않습니다.
                
        정보 보유 및 파기
         · 사용자 정보는 서비스 이용 기간 동안 보유되며, 이용 목적이 달성된 후 즉시 파기됩니다.
        """),
        ("마케팅 정보 수집 및 수신 동의 ",
        """
        마케팅 정보 수집
         · 서비스는 마케팅 및 광고 목적으로 사용자의 활동 데이터를 수집할 수 있습니다.
        
        수집 목적
         · 사용자에게 맞춤형 광고 및 프로모션을 제공하기 위함입니다.
        
        수신 동의
         · 사용자는 마케팅 목적의 정보 수집 및 수신에 대해 동의할 수 있으며, 언제든지 이 동의를 철회할 수 있습니다.
        
        정보 사용
         · 수집된 마케팅 정보는 서비스 개선 및 사용자 맞춤형 콘텐츠 제공을 위해 사용됩니다.
        """)
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
        title = "약관 및 정책"
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
extension TermsAndPoliciesViewController: UITableViewDataSource {
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
extension TermsAndPoliciesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = AnswerViewController()
        VC.answer = detailQuestions[indexPath.row].answer
        navigationController?.pushViewController(VC, animated: true)
    }
}
