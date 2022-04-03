//
//  SceneDelegate.swift
//  Naviganion
//
//  Created by Daniil Ivanov on 01.04.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowsScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowsScene.coordinateSpace.bounds)
        window?.windowScene = windowsScene
        window?.rootViewController = createTabbar()
        window?.makeKeyAndVisible()
    }
    
    func createProfileNC() -> UINavigationController {
        let profileVC = ProfileViewController()
        profileVC.title = "Профиль"
        profileVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        
        return UINavigationController(rootViewController: profileVC)
    }
    
    func createFeedNC() -> UINavigationController {
        let feedVC = FeedViewController()
        feedVC.title = "Лента"
        feedVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        
        return UINavigationController(rootViewController: feedVC)
    }
    
    func createTabbar() -> UITabBarController {
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = .systemGreen
        tabbar.viewControllers = [createProfileNC(), createFeedNC()]
        
        return tabbar
    }

}

