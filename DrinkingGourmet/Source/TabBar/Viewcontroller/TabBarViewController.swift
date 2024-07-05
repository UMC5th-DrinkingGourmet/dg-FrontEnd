//
//  TabBarViewController.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 1/6/24.
//
import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tabBarConfig()
        self.selectedIndex = 2
        
        view.backgroundColor = .black
        //view.backgroundColor = .darkGray
    }
    
    private func tabBarConfig() {
        //tabBar.barTintColor = .darkGray
        tabBar.barTintColor = .black
        tabBar.tintColor = .white
        tabBar.isTranslucent = false
        
        
        // 뷰컨 생성
        let mainMenuVC = UINavigationController(rootViewController: MainMenuViewController())
        let recommendVC = UINavigationController(rootViewController: RecommendGuideViewController())
        let communityVC = UINavigationController(rootViewController: CommunityViewController())
        let likeVC = UINavigationController(rootViewController: LikeTapmanViewController())
        let myPageVC = UINavigationController(rootViewController: MyPageTapmanViewController())
        
        
        // 탭 바 이이템 설정
        mainMenuVC.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(named: "ic_navigation_home"),
            selectedImage: UIImage(named: "ic_navigation_home_selected")
        )
        recommendVC.tabBarItem = UITabBarItem(
            title: "주류추천",
            image: UIImage(named: "ic_navigation_recommend"),
            selectedImage: UIImage(named: "ic_navigation_recommend_selected")
        )
        communityVC.tabBarItem = UITabBarItem(
            title: "커뮤니티",
            image: UIImage(named: "ic_navigation_community"),
            selectedImage: UIImage(named: "ic_navigation_community_selected")
        )
        likeVC.tabBarItem = UITabBarItem(
            title: "좋아요",
            image: UIImage(named: "ic_navigation_like"),
            selectedImage: UIImage(named: "ic_navigation_like_selected")
        )
        myPageVC.tabBarItem = UITabBarItem(
            title: "마이페이지",
            image: UIImage(named: "ic_navigation_mypage"),
            selectedImage: UIImage(named: "ic_navigation_mypage_selected")
        )
        
        
        
        let tabItems = [
            recommendVC,
            communityVC,
            mainMenuVC,
            likeVC,
            myPageVC
        ]
        
        //tab bar controller에 컨트롤러 배열 저장.
        setViewControllers(tabItems, animated: true)
    }

}
extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
    var sizeThatFits = super.sizeThatFits(size)
    sizeThatFits.height = 89 // 원하는 길이
    return sizeThatFits
   }
}
