//
//  HomeViewController.swift
//  cardapiododia
//
//  Created by Henrique Guarnieri on 29/01/2016.
//  Copyright © 2016 Henrique Guarnieri. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let menuViewController = MenuViewController()
        let menuNavigationController = UINavigationController(rootViewController: menuViewController)
        
        self.presentViewController(menuNavigationController, animated: true, completion: nil)
    }
}