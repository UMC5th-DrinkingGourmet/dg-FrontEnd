//
//  SelectMoodViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/4/24.
//

import UIKit
import TagListView

final class SelectMoodViewController: UIViewController {
    // MARK: - Properties
    private let selectMoodView = SelectMoodView()
    private var selectedTags: String = ""
    
    // MARK: - View 설정
    override func loadView() {
        view = selectMoodView
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNaviBar()
        setupButton()
        setupTagListView()
    }
    
    private func setupNaviBar() {
        title = "주류 추천"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupButton() {
        selectMoodView.passButton.addTarget(self, action: #selector(passButtonTapped), for: .touchUpInside)
        selectMoodView.nextButton.button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    private func setupTagListView() {
        selectMoodView.tagListView.delegate = self
    }
    
    private func getSelectedTags() -> String { // 선택되어있는 값 얻기
        let selectedTags = selectMoodView.tagListView.tagViews
            .filter { $0.isSelected }
            .map { $0.titleLabel?.text ?? "" }
        return selectedTags.joined(separator: ", ")
    }
    
    private func updateNextButtonState() {
        let hasSelectedTags = !selectMoodView.tagListView.tagViews.filter { $0.isSelected }.isEmpty
        selectMoodView.nextButton.button.isEnabled = hasSelectedTags
        selectMoodView.nextButton.backgroundColor = hasSelectedTags ? .base0100 : .base0500
    }
}

// MARK: - Actions
extension SelectMoodViewController {
    private func navigateToNextViewController() {
        let VC = InputMoodeViewController()
        VC.previousMood = RecommendRequestDTO.shared.mood // 다음 뷰컨에 현재 상태를 전달
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc private func passButtonTapped() {
        RecommendRequestDTO.shared.mood = selectedTags // 이전 선택된 태그 값으로 되돌리기
        navigateToNextViewController()
    }
    
    @objc private func nextButtonTapped() {
        selectedTags = getSelectedTags()
        RecommendRequestDTO.shared.mood = selectedTags
        navigateToNextViewController()
    }
}

// MARK: - TagListViewDelegate
extension SelectMoodViewController: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagView.isSelected = !tagView.isSelected
        print("\(title) - \(tagView.isSelected)")
        updateNextButtonState()
    }
}
