//
//  LikeTapmanViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/17/24.
//

import UIKit
import Tabman
import Pageboy

class LikeTapmanViewController: TabmanViewController {
    let likeCombinationViewController = LikeCombinationViewController()
    let likeRecipeBookViewController = LikeRecipeBookViewController()
    
    var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers.append(likeCombinationViewController)
        viewControllers.append(likeRecipeBookViewController)
        
        self.dataSource = self
        self.view.backgroundColor = .white
        setupNaviBar()
        setupTabman()
    }
    
    private func setupNaviBar() {
        title = "좋아요"
        
        // 네비게이션바 투명
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // 백버튼 커스텀
        let customBackImage = UIImage(named: "ic_back")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = customBackImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = customBackImage
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupTabman() {
        
        
        let bar = TMBar.ButtonBar()
        bar.backgroundView.style = .clear
        
        bar.layout.transitionStyle = .snap
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        bar.layout.interButtonSpacing = 0 // 버튼 사이 간격
        
        
        bar.buttons.customize { (button) in
            button.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)!
            button.tintColor = .base0400 // 선택 X
            button.selectedTintColor = .black // 선택 O
        }
        

        bar.indicator.weight = .light
        bar.indicator.tintColor = .customOrange
        bar.indicator.overscrollBehavior = .compress
        

        addBar(bar, dataSource: self, at: .top)
    }
}

extension LikeTapmanViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    // 각 탭바 항목
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "오늘의 조합")
        case 1:
            return TMBarItem(title: "레시피북")
        default:
            return TMBarItem(title: "Page \(index)")
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    // 기본 페이지
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
