//
//  ViewController.swift
//  Scouter
//
//  Created by judongseok on 2022/04/19.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        settingTabbarDesign()
        initTabbarItems()
    }
    
    func settingTabbarDesign() {
        UITabBar.appearance().tintColor = .secondary
        UITabBar.appearance().unselectedItemTintColor = UIColor.lightGray
    }
    
    func initTabbarItems() {
        let home = HomeViewController()
        let search = SearchViewController()
        let notify = NotifyViewController()
        let user = UserViewController()
        
        home.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), tag: 0)
        home.tabBarItem.standardAppearance?.selectionIndicatorTintColor = .white
        search.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        notify.tabBarItem = UITabBarItem(title: "알림", image: UIImage(systemName: "bell"), tag: 2)
        user.tabBarItem = UITabBarItem(title: "유저", image: UIImage(systemName: "person"), tag: 3)
        
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: search)
        let nav3 = UINavigationController(rootViewController: notify)
        let nav4 = UINavigationController(rootViewController: user)
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: false)
    }
}

