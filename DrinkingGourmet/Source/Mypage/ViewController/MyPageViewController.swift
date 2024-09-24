//
//  MyPageViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/20/24.
//

import UIKit
import Photos
import PhotosUI

class MyPageViewController: UIViewController {
    // MARK: - Properties
    private let tabmanVC = MyPageTapmanViewController()
    private var myInfo: MyInfoResultDTO?

    private let myPageView = MyPageView()
    
    // MARK: - View 설정
    override func loadView() {
        view = myPageView
    }
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addViews()
        configureConstraints()
        setupNaviBar()
        setupButton()
    }
    
    func fetchData() {
        MyPageService.shared.getMyInfo { result in
            switch result {
            case .success(let data):
                print("내 정보 조회 성공")
                self.myInfo = data.result
                UserDefaultManager.shared.userNickname = data.result.nickName
                UserDefaultManager.shared.userName = data.result.name
                UserDefaultManager.shared.userBirth = data.result.birthDate
                UserDefaultManager.shared.userPhoneNumber = data.result.phoneNumber
                UserDefaultManager.shared.userGender = data.result.gender
                self.updateUI()
            case .failure:
                print("내 정보 조회 실패")
            }
        }
    }
    
    private func updateUI() {
        guard let myInfo = self.myInfo else { return }
        
        DispatchQueue.main.async {
            if let profileImageUrl = URL(string: myInfo.profileImageUrl) {
                self.myPageView.profileImage.kf.setImage(with: profileImageUrl)
            }
            
            self.myPageView.nicknameLabel.text = ("\(myInfo.nickName) 님")
            
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
            self.myPageView.providerIcon.image = UIImage(named: provider)
        }
    }
    
    private func addViews() {
        addChild(tabmanVC)
        myPageView.tapmanView.addSubview(tabmanVC.view)
        tabmanVC.didMove(toParent: self)
    }
    
    private func configureConstraints() {
        tabmanVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupNaviBar() {
        title = "마이페이지"
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let customBackImage = UIImage(named: "ic_back")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = customBackImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = customBackImage
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // 네비게이션 바 오른쪽 아이템으로 설정 버튼 추가
        let settingButton = UIBarButtonItem(image: UIImage(named: "ic_setting")?.withRenderingMode(.alwaysOriginal),
                                             style: .plain,
                                             target: self,
                                             action: #selector(settingButtonTapped))
        
        navigationItem.rightBarButtonItem = settingButton
    }
    
    private func setupButton() {
        myPageView.cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
        myPageView.myInfoButton.addTarget(self, action: #selector(myInfoButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension MyPageViewController {
    @objc func settingButtonTapped() {
        let VC = SettingViewController()
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc func cameraButtonTapped() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let actions: [UIAlertAction] = [
            UIAlertAction(title: "프로필 사진 삭제", style: .destructive) { _ in
                
            },
            UIAlertAction(title: "앨범에서 선택", style: .default) { _ in
                self.checkPermission()
                
                var config = PHPickerConfiguration()
                config.filter = .images // 이미지만 보이게
                config.selectionLimit = 1 // 사진 갯수 제한
                        
                let imagePicker = PHPickerViewController(configuration: config)
                imagePicker.delegate = self
                imagePicker.modalPresentationStyle = .fullScreen
                        
                self.present(imagePicker, animated: true)
            },
            UIAlertAction(title: "취소", style: .cancel, handler: nil)
        ]
        
        actions.forEach { actionSheet.addAction($0) }
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func myInfoButtonTapped() {
        print("기본 정보 보기 클릭")
        let VC = ProfileCreationViewController()
        VC.hidesBottomBarWhenPushed = true
        VC.isPatch = true
        navigationController?.pushViewController(VC, animated: true);
    }
}

// MARK: - PHPickerViewControllerDelegate
extension MyPageViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                guard let image = image as? UIImage else {
                    return
                }

                DispatchQueue.main.async {
//                    self?.imageList.append(image)
//                    self?.imageCollectionView.reloadData()
//                    self?.updateImageCountLabel()
//                    self?.updateCompleteButton()
                    
//                    print(self?.imageList ?? "No data available")
                }
            }
        }
        picker.dismiss(animated: true)
    }
}

// MARK: - Setting
extension MyPageViewController {
    private func checkPermission() {
        if #available(iOS 14, *) {
            switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
            case .notDetermined:
                print("not determined")
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                    switch status {
                    case .authorized, .limited:
                        print("권한이 부여 됐습니다. 앨범 사용이 가능합니다")
                    case .denied:
                        DispatchQueue.main.async {
                            self.moveToSetting()
                        }
                        print("권한이 거부 됐습니다. 앨범 사용 불가합니다.")
                    default:
                        print("그 밖의 권한이 부여 되었습니다.")
                    }
                }
            case .restricted:
                print("restricted")
            case .denied:
                DispatchQueue.main.async {
                    self.moveToSetting()
                }
                print("denined")
            case .authorized:
                print("autorized")
            case .limited:
                print("limited")
            @unknown default:
                print("unKnown")
            }
        } else {
            switch PHPhotoLibrary.authorizationStatus() {
            case .notDetermined:
                print("not determined")
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                    switch status {
                    case .authorized, .limited:
                        print("권한이 부여 됐습니다. 앨범 사용이 가능합니다")
                    case .denied:
                        DispatchQueue.main.async {
                            self.moveToSetting()
                        }
                        print("권한이 거부 됐습니다. 앨범 사용 불가합니다.")
                    default:
                        print("그 밖의 권한이 부여 되었습니다.")
                    }
                }
            case .restricted:
                print("restricted")
            case .denied:
                DispatchQueue.main.async {
                    self.moveToSetting()
                }
                print("denined")
            case .authorized:
                print("autorized")
            case .limited:
                print("limited")
            @unknown default:
                print("unKnown")
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
