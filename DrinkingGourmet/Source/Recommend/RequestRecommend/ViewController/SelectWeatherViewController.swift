//
//  SelectWeatherViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/4/24.
//

import UIKit
import TagListView

final class SelectWeatherViewController: UIViewController {
    // MARK: - Properties
    private let selectWeatherView = SelectWeatherView()
    
    // MARK: - View 설정
    override func loadView() {
        view = selectWeatherView
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
        selectWeatherView.passButton.addTarget(self, action: #selector(passButtonTapped), for: .touchUpInside)
        selectWeatherView.nextButton.button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    private func setupTagListView() {
        selectWeatherView.tagListView.delegate = self
    }
    
    private func getSelectedTags() -> String {
        let selectedTags = selectWeatherView.tagListView.tagViews
            .filter { $0.isSelected }
            .map { $0.titleLabel?.text ?? "" }
        return selectedTags.joined(separator: ", ")
    }
    
    private func updateNextButtonState() {
        let hasSelectedTags = !selectWeatherView.tagListView.tagViews.filter { $0.isSelected }.isEmpty
        selectWeatherView.nextButton.button.isEnabled = hasSelectedTags
        selectWeatherView.nextButton.backgroundColor = hasSelectedTags ? .base0100 : .base0500
    }
}

// MARK: - Actions
extension SelectWeatherViewController {
    private func navigateToNextViewController() {
        let VC = RecommendLodingViewController()
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc private func passButtonTapped() {
        navigateToNextViewController()
    }
    
    @objc private func nextButtonTapped() {
        RecommendRequestDTO.shared.weather = getSelectedTags()
        navigateToNextViewController()
    }
}

// MARK: - TagListViewDelegate
extension SelectWeatherViewController: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagView.isSelected = !tagView.isSelected
        print("\(title) - \(tagView.isSelected)")
        updateNextButtonState()
    }
}
