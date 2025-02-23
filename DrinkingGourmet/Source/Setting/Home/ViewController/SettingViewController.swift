//
//  SettingViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 3/31/24.
//

import UIKit
import Kingfisher
import PhotosUI

final class SettingViewController: UIViewController {
    // MARK: - Properties
    var myInfo: MyInfoResultDTO?
    private let settingSections = SettingSections()
    private let settingView = SettingView()
    
    // MARK: - Header View
    private var settingHomeHeaderView: SettingTopView!
    
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
                UserDefaultManager.shared.userNickname = data.result.nickName
                UserDefaultManager.shared.userName = data.result.name
                UserDefaultManager.shared.userBirth = data.result.birthDate
                UserDefaultManager.shared.userPhoneNumber = data.result.phoneNumber
                UserDefaultManager.shared.userGender = data.result.gender
                self.myInfo = data.result
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
        
        // 테이블 뷰의 헤더 뷰 설정
        settingHomeHeaderView = SettingTopView(frame: CGRect(x: 0, y: 0, width: 0, height: 215))
        tb.tableHeaderView = settingHomeHeaderView
    }
    
    private func updateHeaderView() {
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
        
        settingHomeHeaderView.cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
        settingHomeHeaderView.myInfoButton.addTarget(self, action: #selector(myInfoButtonTapped), for: .touchUpInside)
        settingHomeHeaderView.modifyButton.addTarget(self, action: #selector(modifyButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension SettingViewController {
    @objc func cameraButtonTapped() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let actions: [UIAlertAction] = [
            UIAlertAction(title: "프로필 사진 삭제", style: .destructive) { _ in
                MyPageService.shared.patchProfileImage { error in
                    if let error = error {
                        print("프로필 사진 삭제 실패: \(error)")
                    } else {
                        print("프로필 사진 삭제 성공")
                        DispatchQueue.main.async {
                            self.settingHomeHeaderView.profileImage.image = UIImage(named: "ic_profile_mypage")
                        }
                    }
                }
            },
            
            UIAlertAction(title: "앨범에서 선택", style: .default) { _ in
                self.checkPermission { granted in
                    if granted {
                        var config = PHPickerConfiguration()
                        config.filter = .images // 이미지만 보이게
                        config.selectionLimit = 1 // 사진 갯수 제한
                        
                        let imagePicker = PHPickerViewController(configuration: config)
                        imagePicker.delegate = self
                        imagePicker.modalPresentationStyle = .fullScreen
                        
                        self.present(imagePicker, animated: true)
                    } else {
                        print("권한이 없어서 앨범을 열 수 없습니다.")
                    }
                }
            },
            
            UIAlertAction(title: "취소", style: .cancel, handler: nil)
        ]
        
        actions.forEach { actionSheet.addAction($0) }
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func myInfoButtonTapped() {
        let VC = ProfileCreationViewController()
        VC.hidesBottomBarWhenPushed = true
        VC.isPatch = true
        navigationController?.pushViewController(VC, animated: true);
    }
    
    @objc func modifyButtonTapped() {
        let VC = SelectTypeOfLiquorViewController()
        VC.hidesBottomBarWhenPushed = true
        VC.isModify = true
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
            case "버전 정보":
                let VC = AnswerViewController()
                VC.isVersionInfo = true
                VC.answer = """
                개요
                
                버전 0.0.1은 [서비스 이름]의 초기 베타 버전으로, 우리는 사용자로부터의 피드백을 기반으로 지속적인 개선을 목표로 합니다. 이 버전에서는 기본적인 기능과 인터페이스를 제공하며,
                사용자는 음식과 어울리는 주류를 추천받을 수 있습니다.
                
                주요 기능
                
                · 음식과주류매칭추천
                사용자는 음식을 선택하면 그에 어울리는 주류를 추천받을 수 있습니다.
                
                · 사용자 리뷰 및 평가
                사용자는 자신의 경험을 공유하고 다른 사용자의 리뷰를 확인할 수 있습니다.
                
                · 개인 맞춤 설정
                사용자는 선호도, 알레르기 정보 등을 설정하여 개인화된 추천을 받을 수 있습니다.
                
                개발 중인 기능
                
                · 비알코올 음료 추천
                다양한 비알코올 음료 매칭 추천 기능을 개발 중입니다.
                                
                · 다국어 지원
                서비스를 더 많은 사용자에게 제공하기 위해 다양한 언어 지원을 계획하고 있습니다.
                                
                · 향상된 사용자 인터페이스: 사용자 경험을 개선하기 위해 인터페이스를 지속적으로 업데이트할 예정입니다.
                
                
                향후 계획: 우리는 사용자의 피드백을 바탕으로 기능을 추가하고 성능을 향상시키는 것을 목표로 합니다. 다음 버전에서는 [개발 중인 기능] 등을 포함시킬 예정입니다.
                
                지원 및 피드백: 사용자의 피드백은 우리에게 매우 중요합니다. 문제가 발생하거나 개선 사항이 있으면 언제든지 [지원 이메일 주소 또는 연락처]로 문의해 주세요.
                """
                VC.isTermsAndPolicies = true
                VC.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(VC, animated: true)
            default:
                break
            }
        case 1:
            let selectedItem = settingSections.login[indexPath.row]
            if selectedItem == "로그아웃" {
                // 로그아웃 확인 얼러트 생성
                let alert = UIAlertController(title: "로그아웃하시겠습니까?", message: nil, preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                let confirmAction = UIAlertAction(title: "확인", style: .destructive) { _ in
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
                                
                                // UserDefaults 초기화
                                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                                    UserDefaults.standard.removeObject(forKey: key.description)
                                }
                            } else {
                                print("로그아웃 실패: 서버와의 로그아웃 실패 또는 네트워크 문제")
                            }
                        }
                    }
                }
                
                alert.addAction(cancelAction)
                alert.addAction(confirmAction)
                
                present(alert, animated: true, completion: nil)
            } else if selectedItem == "회원탈퇴" {
                let alertController = UIAlertController(title: "회원 탈퇴", message: "7일 내에 다시 로그인하시면 탈퇴처리가 취소됩니다.\n정말 회원 탈퇴하시겠습니까?", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
                alertController.addAction(cancelAction)
                
                let confirmAction = UIAlertAction(title: "탈퇴하기", style: .destructive) { _ in
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
                            
                            // UserDefaults 초기화
                            for key in UserDefaults.standard.dictionaryRepresentation().keys {
                                UserDefaults.standard.removeObject(forKey: key.description)
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

// MARK: - PHPickerViewControllerDelegate
extension SettingViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                guard let self = self,
                      let image = image as? UIImage else { return }

                DispatchQueue.main.async {
                    // 이미지 업로드 호출
                    MyPageService.shared.patchProfileImage(image: image) { error in
                        if let error = error {
                            print("프로필 사진 수정 실패: \(error.localizedDescription)")
                        } else {
                            print("프로필 사진 수정 성공")
                            self.settingHomeHeaderView.profileImage.image = image
                        }
                    }
                }
            }
        }
        picker.dismiss(animated: true)
    }
}

// MARK: - Setting
extension SettingViewController {
    private func checkPermission(completion: @escaping (Bool) -> Void) {
        if #available(iOS 14, *) {
            switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
            case .notDetermined:
                print("not determined")
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                    switch status {
                    case .authorized, .limited:
                        print("권한이 부여 됐습니다. 앨범 사용이 가능합니다")
                        completion(true) // 권한이 허용된 경우
                    case .denied:
                        DispatchQueue.main.async {
                            self.moveToSetting()
                        }
                        print("권한이 거부 됐습니다. 앨범 사용 불가합니다.")
                        completion(false) // 권한이 거부된 경우
                    default:
                        print("그 밖의 권한이 부여 되었습니다.")
                        completion(false)
                    }
                }
            case .restricted, .denied:
                DispatchQueue.main.async {
                    self.moveToSetting()
                }
                print("권한이 거부 되었습니다.")
                completion(false)
            case .authorized, .limited:
                print("권한이 이미 부여 되었습니다.")
                completion(true) // 이미 권한이 부여된 경우
            @unknown default:
                print("알 수 없는 권한 상태")
                completion(false)
            }
        } else {
            switch PHPhotoLibrary.authorizationStatus() {
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                    switch status {
                    case .authorized, .limited:
                        print("권한이 부여 됐습니다.")
                        completion(true)
                    case .denied:
                        DispatchQueue.main.async {
                            self.moveToSetting()
                        }
                        print("권한이 거부 됐습니다.")
                        completion(false)
                    default:
                        print("기타 권한 상태")
                        completion(false)
                    }
                }
            case .restricted, .denied:
                DispatchQueue.main.async {
                    self.moveToSetting()
                }
                completion(false)
            case .authorized, .limited:
                completion(true)
            @unknown default:
                completion(false)
            }
        }
    }
    
    private func moveToSetting() {
        let alertController = UIAlertController(title: "권한 거부됨", message: "앨범 접근이 거부 되었습니다. 앱의 일부 기능을 사용할 수 없어요", preferredStyle: UIAlertController.Style.alert)
            
        let okAction = UIAlertAction(title: "권한 설정으로 이동하기", style: .default) { (action) in
            
            self.navigationController?.popViewController(animated: true)
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        }
        let cancelAction = UIAlertAction(title: "확인", style: .cancel) { _ in
            self.navigationController?.popViewController(animated: true)
        }
            
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
            
        self.present(alertController, animated: false, completion: nil)
    }
}
