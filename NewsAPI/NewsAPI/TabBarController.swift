//
//  TabBarController.swift
//  NewsAPI
//
//  Created by Katerina on 05/12/2023.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = .black
        setupViewControllers()
        setupTabBar() 
    }
    
    private func setupViewControllers() {
        
        viewControllers = [
            setupNavigationController(rootViewController: GeneralViewController(viewModel: GeneralViewModel()),
                                      title: "General",
                                      image: UIImage(systemName: "newspaper") ?? UIImage.add),
            setupNavigationController(rootViewController: BusinessViewController(),
                                      title: "Business",
                                      image: UIImage(systemName: "briefcase") ?? UIImage.add),
            setupNavigationController(rootViewController: TechnologyViewController(),
                                      title: "Technologi",
                                      image: UIImage(systemName: "gyroscope") ?? UIImage.add)
        ]
    }
    private func setupNavigationController(rootViewController: UIViewController,
                                           title: String,
                                           image: UIImage) -> UINavigationController {
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
        
    }
    private func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        tabBar.standardAppearance = appearance
        
        view.tintColor = .black
    }
}
