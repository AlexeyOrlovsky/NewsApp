//
//  TabBarViewController.swift
//  NewsApp
//
//  Created by Алексей Орловский on 23.05.2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }

    /// setupTabBar
    private func setupTabBar() {
        viewControllers = [
            UINavigationController(rootViewController: ViewController(viewController: MainViewController(), title: "News", image: UIImage(systemName: "newspaper"))),
            UINavigationController(rootViewController: ViewController(viewController: LibraryViewController(), title: "Library", image: UIImage(systemName: "checklist.checked"))),
            UINavigationController(rootViewController: ViewController(viewController: SettingsViewController(), title: "Settings", image: UIImage(systemName: "gearshape")))
        ]
    }

    func ViewController(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
}


