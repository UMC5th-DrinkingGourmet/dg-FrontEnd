//
//  MyPageViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/20/24.
//

import UIKit

class MyPageViewController: UIViewController {
    // MARK: - Properties
    private let tabmanVC = MyPageTapmanViewController()
    
    private let myPageView = MyPageView()
    
    // MARK: - View 설정
    override func loadView() {
        view = myPageView
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        fetchData()
        addViews()
        configureConstraints()
        setupNaviBar()
        setupButton()
    }
    
    private func fetchData() {
        MyPageService.shared.getMyInfo { result in
            switch result {
            case .success(let data):
                print("내 정보 조회 성공")
                DispatchQueue.main.async {
                    if let profileImageUrl = URL(string: data.result.profileImageUrl) {
                        self.myPageView.profileImage.kf.setImage(with: profileImageUrl)
                    }
                    
                    self.myPageView.nickNameLabel.text = ("\(data.result.nickName) 님")
                    
                    var provider = ""
                    switch data.result.provider {
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
            case .failure:
                print("내 정보 조회 실패")
            }
        }
    }
    
    private func updateUI() {
        
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
        myPageView.myInfoButton.addTarget(self, action: #selector(myInfoButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension MyPageViewController {
    @objc func settingButtonTapped() {
        let VC = SettingViewController()
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc func myInfoButtonTapped() {
        print("기본 정보 보기 클릭")
    }
}
