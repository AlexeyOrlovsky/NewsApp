//
//  NavigationManager.swift
//  NewsApp
//
//  Created by Алексей Орловский on 16.05.2023.
//

import UIKit

// To display screens. Authorization and Registered

class NavigationManager {
    static let shared = NavigationManager()
    
    func showNotAuthorizedUserStage() {
        
        let controller = WelcomeViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as! SceneDelegate
        
        sceneDelegate.window?.rootViewController = navigationController
        sceneDelegate.window?.makeKeyAndVisible()
    }

    func showAuthorizedUserStage() {

        let controller = TabBarViewController()
        let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as! SceneDelegate

        sceneDelegate.window?.rootViewController = controller
        sceneDelegate.window?.makeKeyAndVisible()
    }
}

