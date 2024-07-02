//
//  DeleteAccountViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/2/24.
//

import UIKit

final class DeleteAccountViewController: UIViewController {
    // MARK: - Properties
    private let deleteAccountView = DeleteAccountView()
    
    // MARK: - View 설정
    override func loadView() {
        view = deleteAccountView
    }
    
    // MARK: - ViewDidLodad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNaviBar()
        setupButton()
    }
    
    private func setupNaviBar() {
        title = "자주 묻는 질문"
    }
    
    private func setupButton() {
        deleteAccountView.deleteAccountButton.addTarget(self, action: #selector(deleteAccountButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension DeleteAccountViewController {
    @objc private func deleteAccountButtonTapped() {
        let alertController = UIAlertController(title: nil, message: "정말 회원탈퇴 하시겠습니까?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            print("회원탈퇴 확인됨")
            // 회원탈퇴 로직을 여기에 추가하세요
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
