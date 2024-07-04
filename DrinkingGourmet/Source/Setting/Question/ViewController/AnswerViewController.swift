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
        title = "자주 묻는 질문"
    }
    
    private func setupContent() {
        questionAnswerView.answerLabel.text = answer
    }
}
