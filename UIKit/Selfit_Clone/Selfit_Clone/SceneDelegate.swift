//
//  SceneDelegate.swift
//  Selfit_Clone
//
//  Created by MadCow on 2024/5/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
//        let viewController = ViewController()
//        let navigation = UINavigationController(rootViewController: createTabBar())
        
        self.window?.rootViewController = createTabBar()
        self.window?.makeKeyAndVisible()
    }
    
    func createTabBar() -> UITabBarController {
                
        let recordView = RecordView()
        recordView.tabBarItem = UITabBarItem(title: "기록", image: UIImage(systemName: "calendar"), selectedImage: nil)
        let recordNavigation = UINavigationController(rootViewController: recordView)
        
        let dailyView = DailyView()
        dailyView.tabBarItem = UITabBarItem(title: "일지", image: UIImage(systemName: "list.bullet.clipboard"), selectedImage: nil)
        let dailyNavigation = UINavigationController(rootViewController: dailyView)
        
        let settingView = SettingView()
        settingView.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "ellipsis"), selectedImage: nil)
        let settingNavigation = UINavigationController(rootViewController: settingView)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [recordNavigation, dailyNavigation, settingNavigation]
        
        return tabBarController
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

