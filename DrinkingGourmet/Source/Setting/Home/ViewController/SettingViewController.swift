//
//  SettingViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 3/31/24.
//

import UIKit
import Kingfisher

final class SettingViewController: UIViewController {
    // MARK: - Properties
    var profileImageUrl: String? = nil
    var nickName: String? = nil
    
    private let settingSections = SettingSections()
    private let settingView = SettingView()
    
    // MARK: - View 설정
    override func loadView() {
        view = settingView
    }
    
    // MARK: - ViewDidLodad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNaviBar()
        setupTableView()
    }
    
    private func setupNaviBar() {
        title = "설정"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupTableView() {
        let tb = settingView.tableView
        
        tb.register(SettingCell.self, forCellReuseIdentifier: "SettingHomeCell")
        tb.dataSource = self
        tb.delegate = self
        
        let settingHomeHeaderView = SettingTopView(frame: CGRect(x: 0, y: 0, width: 0, height: 215))
        
        if let profileImageUrl = self.profileImageUrl,
           let nickName = self.nickName {
            let url = URL(string: profileImageUrl)
            settingHomeHeaderView.profileImage.kf.setImage(with: url)
            settingHomeHeaderView.nicknameLabel.text = nickName
        }
        
        tb.tableHeaderView = settingHomeHeaderView
    }
}

extension SettingViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingSections.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingSections.sections[section]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = SettingSectionHeaderView()
        
        let settingSections = SettingSections()
        if section < settingSections.sections.count {
            headerView.titleLabel.text = settingSections.sections[section]
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return settingSections.supportAndInformation.count
        case 1:
            return settingSections.login.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingHomeCell", for: indexPath) as! SettingCell
        
        switch indexPath.section {
        case 0:
            cell.titleLabel.text = settingSections.supportAndInformation[indexPath.row]
        case 1:
            cell.titleLabel.text = settingSections.login[indexPath.row]
        default:
            cell.titleLabel.text = ""
        }
        
        return cell
    }
}


extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: // 자주 묻는 질문
            let VC = QuestionViewController()
            VC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(VC, animated: true)
        case 1:
            print("섹션 1, 로우: \(settingSections.login[indexPath.row])")
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 8 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let separatorView = UIView().then {
            $0.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        }
        return separatorView
    }
}
