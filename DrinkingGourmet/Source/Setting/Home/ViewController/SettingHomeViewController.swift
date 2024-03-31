//
//  SettingHomeViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 3/31/24.
//

import UIKit

final class SettingHomeViewController: UIViewController {
    // MARK: - Properties
    private let settingHomeView = SettingHomeView()
    
    // MARK: - View 설정
    override func loadView() {
        view = settingHomeView
    }
    
    // MARK: - ViewDidLodad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNaviBar()
    }
    
    private func setupNaviBar() {
        title = "설정"
    }
}
