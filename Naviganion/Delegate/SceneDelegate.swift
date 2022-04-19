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
        let LogInVC = LogInViewController()
        LogInVC.title = "Profile"
        LogInVC.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        LogInVC.tabBarItem.title = "Profile"
        

        
        return UINavigationController(rootViewController: LogInVC)
    }
    
    func createFeedNC() -> UINavigationController {
        let feedVC = FeedViewController()
        feedVC.title = "Лента"
        feedVC.tabBarItem.image = UIImage(systemName: "house")
        feedVC.tabBarItem.title = "Feed"
        
        return UINavigationController(rootViewController: feedVC)
    }
    
    func createTabbar() -> UITabBarController {
        let tabbar = UITabBarController()
        UINavigationBar.appearance().backgroundColor = .white
        UINavigationBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = .systemBlue
        UITabBar.appearance().barTintColor = .white
        tabbar.viewControllers = [createFeedNC(), createProfileNC()]
        
        return tabbar
    }

}

