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

    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNaviBar()
        setupTableView()
    }

    func fetchData() {
        MyPageService.shared.getMyInfo { result in
            switch result {
            case .success(let data):
                print("내 정보 조회 성공")
                self.myInfo = data.result
                // 데이터가 성공적으로 불러와졌을 때 UI 업데이트
                DispatchQueue.main.async {
                    self.updateHeaderView()
                }
            case .failure:
                print("내 정보 조회 실패")
            }
        }
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
    }

    private func updateHeaderView() {
        guard let myInfo = self.myInfo else { return }

        let settingHomeHeaderView = SettingTopView(frame: CGRect(x: 0, y: 0, width: 0, height: 215))

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

        settingHomeHeaderView.myInfoButton.addTarget(self, action: #selector(myInfoButtonTapped), for: .touchUpInside)

        // 테이블 뷰의 헤더 뷰 설정
        settingView.tableView.tableHeaderView = settingHomeHeaderView
    }
}

// MARK: - Actions
extension SettingViewController {
    @objc func myInfoButtonTapped() {
        print("기본 정보 보기 클릭")
        let VC = ProfileCreationViewController()
        VC.hidesBottomBarWhenPushed = true
        VC.isPatch = true
        navigationController?.pushViewController(VC, animated: true);
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
            let selectedItem = settingSections.login[indexPath.row]
            if selectedItem == "로그아웃" {
                Task {
                    SignService.shared.logout { success in
                        if success {
                            let provider = UserDefaultManager.shared.provider

                            switch provider {
                            case "kakao":
                                let kakaoAuthViewModel = KakaoAuthViewModel()
                                kakaoAuthViewModel.kakaoLogut()
                            case "apple":
                                let appleAuthViewModel = AppleAuthViewModel()
                                appleAuthViewModel.isLoggedIn = false
                            default:
                                print("알 수 없는 provider: \(provider)")
                                return
                            }

                            do {
                                try Keychain.shared.deleteToken(kind: .accessToken)
                                try Keychain.shared.deleteToken(kind: .refreshToken)
                            } catch {
                                print("토큰 삭제 실패: \(error)")
                                return
                            }

                            DispatchQueue.main.async {
                                let authVC = AuthenticationViewController()
                                let windowScene = UIApplication.shared.connectedScenes
                                    .filter { $0.activationState == .foregroundActive }
                                    .compactMap { $0 as? UIWindowScene }
                                    .first
                                if let window = windowScene?.windows.first {
                                    window.rootViewController = UINavigationController(rootViewController: authVC)
                                    window.makeKeyAndVisible()
                                }
                            }
                        } else {
                            print("로그아웃 실패: 서버와의 로그아웃 실패 또는 네트워크 문제")
                        }
                    }
                }
            } else if selectedItem == "회원탈퇴" {
                let alertController = UIAlertController(title: "회원 탈퇴", message: "7일 내에 다시 로그인하시면 탈퇴처리가 취소됩니다.\n정말 회원 탈퇴하시겠습니까?", preferredStyle: .alert)
               
                let cancelAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
                alertController.addAction(cancelAction)
                
                let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
                    SignService.shared.postCancellations { error in
                        if let error = error {
                            print("회원 탈퇴 실패: \(error.localizedDescription)")
                        } else {
                            print("회원 탈퇴 성공")
                            
                            do {
                                try Keychain.shared.deleteToken(kind: .accessToken)
                                try Keychain.shared.deleteToken(kind: .refreshToken)
                                print("토큰 삭제 성공")
                            } catch {
                                print("토큰 삭제 실패: \(error)")
                            }
                            
                            DispatchQueue.main.async {
                                let authVC = AuthenticationViewController()
                                let windowScene = UIApplication.shared.connectedScenes
                                    .filter { $0.activationState == .foregroundActive }
                                    .compactMap { $0 as? UIWindowScene }
                                    .first
                                if let window = windowScene?.windows.first {
                                    window.rootViewController = UINavigationController(rootViewController: authVC)
                                    window.makeKeyAndVisible()
                                }
                            }
                        }
                    }
                }
                alertController.addAction(confirmAction)
                
                // Alert Controller를 화면에 표시
                self.present(alertController, animated: true, completion: nil)
            }
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
