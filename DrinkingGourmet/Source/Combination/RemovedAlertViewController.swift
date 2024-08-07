//
//  RemovedAlertViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/3/24.
//

import UIKit

protocol RemovedAlertViewControllerDelegate: AnyObject {
    func removedAlertViewControllerDidTapClose(_ controller: RemovedAlertViewController)
}

final class RemovedAlertViewController: UIViewController {
    // MARK: - Properties
    private let removedAlertView = RemovedAlertView()
    weak var delegate: RemovedAlertViewControllerDelegate?
    
    // MARK: - View 설정
    override func loadView() {
        view = removedAlertView
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton()
    }
    
    private func setupButton() {
        removedAlertView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    func appear(sender: UIViewController) {
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        sender.present(self, animated: false) {
            self.show()
        }
    }
    
    private func show() {
        self.removedAlertView.backView.alpha = 1
        self.removedAlertView.contentView.alpha = 1
    }
}

// MARK: - Actions
extension RemovedAlertViewController {
    @objc private func closeButtonTapped() {
        self.dismiss(animated: false) {
            self.delegate?.removedAlertViewControllerDidTapClose(self)
        }
    }
}
