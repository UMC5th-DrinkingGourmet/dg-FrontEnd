//
//  MainMenuViewController.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 2/4/24.
//

import UIKit

class MainMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        configNav()
    }
    
    func configNav() {
        navigationItem.title = "회원 정보 입력"
        let item = UIBarButtonItem(image: UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal).withTintColor(.white), style: .plain, target: self, action: #selector(backToPrevious))
        navigationItem.leftBarButtonItem = item
    }
    
    @objc func backToPrevious() {
        navigationController?.popViewController(animated: true)
    }
    


}
