//
//  SceneDelegate.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/22/25.
//

import UIKit
import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var loginCoordinator: LoginCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        setupNotificationObservers()
        
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(presentLoginFlow(_:)),
            name: NSNotification.Name("PresentLoginFlow"),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(loginDidFinish),
            name: NSNotification.Name("LoginDidFinish"),
            object: nil
        )
    }
    
    @objc private func presentLoginFlow(_ notification: NSNotification) {
        guard let navController = notification.object as? UINavigationController else { return }
        window?.rootViewController = navController
        UIView.transition(with: window!, duration: 0.3, options: .transitionCrossDissolve, animations: {})
    }
    
    @objc private func loginDidFinish() {
        let tabBarController = MainTabBarController()
        window?.rootViewController = tabBarController
        UIView.transition(with: window!, duration: 0.3, options: .transitionCrossDissolve, animations: {})
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
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
    
    private func tokenCheck() {
        let accessToken = UserStore.getAccessToken()
        let refreshToken = UserStore.getRefreshToken()
        
        guard let accessToken,
              let refreshToken,
              !accessToken.isEmpty,
              !refreshToken.isEmpty else {
            UserStore.setLogIn(false)
            return
        }
        UserStore.setLogIn(true)
    }
}

extension SceneDelegate: LoginCoordinatorDelegate {
    func loginCoordinatorDidFinish(_ coordinator: LoginCoordinator) {
//        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        let tabBarController = MainTabBarController()
        
        window?.rootViewController = tabBarController
        UIView.transition(with: window!, duration: 0.3, options: .transitionCrossDissolve, animations: {})
    }
}

