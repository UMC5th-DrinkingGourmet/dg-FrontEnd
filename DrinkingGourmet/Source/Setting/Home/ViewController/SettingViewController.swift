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
    var myInfo: MyInfoResultDTO?
    
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
        
        guard let myInfo = self.myInfo else { return }
        
        if let profileImageUrl = URL(string: myInfo.profileImageUrl) {
            settingHomeHeaderView.profileImage.kf.setImage(with: profileImageUrl)
        }
        
        settingHomeHeaderView.nicknameLabel.text = ("\(myInfo.nickName) 님")
        
        var provider = ""
        switch myInfo.provider {
        case "kakao":
            provider = "ic_login_kakao"
        case "apple":
            provider = "ic_login_apple"
        case "naver":
            provider = "ic_login_naver"
        default:
            return
        }
        settingHomeHeaderView.providerIcon.image = UIImage(named: provider)
        
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
            let title = settingSections.supportAndInformation[indexPath.row]
            cell.titleLabel.text = title
            
            switch title {
            case "자주 묻는 질문":
                cell.iconImageView.image = UIImage(named: "ic_ask")
                cell.configureConstraints(hasIcon: true)
                cell.versionLabel.isHidden = true
            case "약관 및 정책":
                cell.iconImageView.image = UIImage(named: "ic_document")
                cell.configureConstraints(hasIcon: true)
                cell.versionLabel.isHidden = true
            case "버전 정보":
                cell.iconImageView.image = UIImage(named: "ic_information")
                cell.configureConstraints(hasIcon: true)
                cell.versionLabel.isHidden = false
                cell.versionLabel.text = "0.0.1"
            default:
                cell.iconImageView.image = nil
                cell.configureConstraints(hasIcon: false)
                cell.versionLabel.isHidden = true
            }
            
        case 1:
            let title = settingSections.login[indexPath.row]
            cell.titleLabel.text = title
            cell.iconImageView.image = nil // 로그인 섹션에서는 아이콘 제거
            cell.configureConstraints(hasIcon: false)
            cell.versionLabel.isHidden = true
            
            // "회원탈퇴" 텍스트 색상 설정
            if title == "회원탈퇴" {
                cell.setTitleColor(.red)
            } else {
                cell.setTitleColor(UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1))
            }
            
        default:
            cell.titleLabel.text = ""
            cell.iconImageView.image = nil
            cell.configureConstraints(hasIcon: false)
            cell.versionLabel.isHidden = true
        }
        
        return cell
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        56
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let selectedItem = settingSections.supportAndInformation[indexPath.row]
            switch selectedItem {
            case "자주 묻는 질문":
                let VC = QuestionViewController()
                VC.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(VC, animated: true)
            case "약관 및 정책":
                let VC = TermsAndPoliciesViewController()
                VC.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(VC, animated: true)
            default:
                break
            }
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
            $0.backgroundColor = .base0900
        }
        return separatorView
    }
}
