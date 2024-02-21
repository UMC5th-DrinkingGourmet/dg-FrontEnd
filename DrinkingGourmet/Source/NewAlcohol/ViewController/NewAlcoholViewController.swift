//
//  NewAlcoholViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/21/24.
//

import UIKit

class NewAlcoholViewController: UIViewController {
    
    // MARK: - View
    let mainImage = UIImageView().then {
        $0.image = UIImage(named: "img_new_alcohol_main")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupNaviBar()
        
        view.addSubviews([])
        
    }
    
    // MARK: - 네비게이션바 설정
    func setupNaviBar() {
        title = "새로 출시된 주류"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // 불투명
        appearance.backgroundColor = .white
        
        // 네비게이션바 밑줄 삭제
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // 백버튼 커스텀
        let customBackImage = UIImage(named: "ic_back")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = customBackImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = customBackImage
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
