//
//  MainTabBarController.swift
//  WhiteAndFluffyTest
//
//  Created by Михаил Кулагин on 01.02.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let collectionController = CollectionController()
    let tableController = TableController(style: .insetGrouped)
    
    let collectionImage = UIImage(systemName: "photo.on.rectangle.angled")!
    let favoritesImage = UIImage(systemName: "heart.circle.fill")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNavigationController(with: collectionController, title: "Photos", image: collectionImage),
            createNavigationController(with: tableController, title: "Favorites", image: favoritesImage)
        ]
    }
    
    private func createNavigationController(with rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}

