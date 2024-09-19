//
//  QuestionDetailViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/2/24.
//

import UIKit

final class AnswerViewController: UIViewController {
    // MARK: - Properties
    var answer: String?
    var isVersionInfo = false
    var isTermsAndPolicies = false
    
    private let questionAnswerView = AnswerView()
    
    // MARK: - View 설정
    override func loadView() {
        view = questionAnswerView
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNaviBar()
        setupContent()
    }
    
    private func setupNaviBar() {
        if isVersionInfo {
            title = "버전 정보"
        } else {
            title = isTermsAndPolicies ? "약관 및 정책" : "자주 묻는 질문"
        }
    }
    
    private func setupContent() {
        questionAnswerView.answerLabel.text = answer
    }
}
