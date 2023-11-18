//
//  MainTC.swift
//  DELIGHT LABS
//
//  Created by 표건욱 on 2023/11/16.
//


import UIKit


class MainTC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    private func initialize() {
        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()
        
        let nomalTitle: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10),
            .foregroundColor: UIColor.gray
        ]
        let selectedTitle: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 10),
            .foregroundColor: UIColor.black
        ]
        
        tabBarItemAppearance.normal.titleTextAttributes = nomalTitle
        tabBarItemAppearance.selected.titleTextAttributes = selectedTitle
        tabBarItemAppearance.selected.iconColor = .black
        
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.shadowImage = UIColor.gray.toImage(height: 0.5)
        
        tabBar.standardAppearance = tabBarAppearance
        
        UITabBar.appearance().backgroundColor = UIColor.white
        
        let viewController = [
            TabBarVC(vc: UIViewController(), itme: UITabBarItem(
                title: "",
                image: UIImage(systemName: "menucard"),
                selectedImage: UIImage(systemName: "menucard.fill")
            )),
            TabBarVC(vc: UIViewController(), itme: UITabBarItem(
                title: "",
                image: UIImage(systemName: "creditcard"),
                selectedImage: UIImage(systemName: "creditcard.fill")
            )),
            TabBarVC(vc: TransactionsVC(), itme: UITabBarItem(
                title: "",
                image: UIImage(systemName: "chart.bar"),
                selectedImage: UIImage(systemName: "chart.bar.fill")
            )),
            TabBarVC(vc: UIViewController(), itme: UITabBarItem(
                title: "",
                image: UIImage(systemName: "person"),
                selectedImage: UIImage(systemName: "person.fill")
            ))
        ]
        
        viewControllers = viewController.map { $0.navi }
        
        self.selectedIndex = 2
    }
}

fileprivate class TabBarVC {
    
    let vc: UIViewController
    let item: UITabBarItem
    
    init(vc: UIViewController, itme: UITabBarItem) {
        self.vc = vc
        self.item = itme
    }
    
    var navi: BaseNC {
        let navi = BaseNC(rootViewController: vc)
        navi.tabBarItem = item
        
        return navi
    }
}
