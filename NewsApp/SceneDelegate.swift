//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by Алексей Орловский on 16.05.2023.
//

import RealmSwift
import Firebase
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                //
            }
        )
        Realm.Configuration.defaultConfiguration = config
        
        /// Creating window and add main controller
        let realm = try! Realm()
        if let user = realm.objects(User.self).first {
            NavigationManager.shared.showAuthorizedUserStage()
        } else {
            NavigationManager.shared.showNotAuthorizedUserStage()
        }
    }
}

