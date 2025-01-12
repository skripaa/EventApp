//
//  MainTabBarController.swift
//  EventApp 1
//
//  Created by Vova SKR on 23/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {

    let networkManager: NetworkManagerProtocol = NetworkManager()
    let storageService: StorageServiceProtocol = StorageService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .black
        tabBar.barTintColor = .white
        
        let allEventsVC = AllEventsVC(networkManager: networkManager, storageService: storageService)
        allEventsVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "events"), tag: 0)
        
        let favoriteEventsVC = FavoriteEventsVC(networkManager: networkManager, storageService: storageService)
        favoriteEventsVC.title = "Избранное"
        favoriteEventsVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "favorite"), tag: 0)
        
        
        let searchVC  = SearchVC(networkManager: networkManager)
        searchVC.title = "Поиск"
        searchVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "search"), tag: 0)
        
        let profileVC = ProfileVC(storageService: storageService)
        profileVC.title = "Профиль"
        profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "profile"), tag: 0)
      
        let tabBarList = [allEventsVC, favoriteEventsVC, searchVC, profileVC ]
        viewControllers = tabBarList.map { UINavigationController(rootViewController: $0) }
    }
}
