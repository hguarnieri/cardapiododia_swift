//
//  NavigationController.swift
//  cardapiododia
//
//  Created by Henrique Guarnieri on 29/01/2016.
//  Copyright © 2016 Henrique Guarnieri. All rights reserved.
//

import UIKit

class NavigationController: UITabBarController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let homeViewController = HomeViewController()
        let homeImage = UIImage.fontAwesomeIconWithName(.Home, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        let homeIcon = UITabBarItem(title: "Inicio", image: homeImage, selectedImage: homeImage)
        homeViewController.tabBarItem = homeIcon
        
        let menuViewController = MenuViewController()
        let menuNavigationController = UINavigationController(rootViewController: menuViewController)
        let menuImage = UIImage.fontAwesomeIconWithName(.Cutlery, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        let menuIcon = UITabBarItem(title: "Cardápio", image: menuImage, selectedImage: menuImage)
        menuNavigationController.tabBarItem = menuIcon
        
        let busTimesViewController = BusTimesViewController()
        let busTimesNavigationController = UINavigationController(rootViewController: busTimesViewController)
        let busTimesImage = UIImage.fontAwesomeIconWithName(.Bus, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        let busTimesIcon = UITabBarItem(title: "Laranjinha", image: busTimesImage, selectedImage: busTimesImage)
        busTimesNavigationController.tabBarItem = busTimesIcon
        
        self.tabBar.tintColor = UIColor.redColor()
        self.viewControllers = [homeViewController, menuNavigationController, busTimesNavigationController]
    }
}