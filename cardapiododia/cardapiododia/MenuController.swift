//
//  MenuController.swift
//  cardapiododia
//
//  Created by Henrique Guarnieri on 29/01/2016.
//  Copyright © 2016 Henrique Guarnieri. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

let Menu = MenuController.sharedInstance

class MenuController {
    
    static let sharedInstance = MenuController()
    
    var menus: [MenuItem]!
    var isLoading: Bool = false
    let RELOAD_STRING = "reloadedMenuController"
    
    func reloadData() {
        downloadMenus()
    }
    
    private func downloadMenus() {
        self.isLoading = true
        self.menus = [MenuItem]()
        
        Alamofire.request(.GET, "http://www2.comp.ufscar.br/~henrique.guarnieri/cardapiov3/cardapio.txt")
            .responseString { response in
                let data = response.result.value?.characters.split{$0 == "\n"}.map(String.init)
                
                if let lines = data {
                    var count = 0
                    var menu = MenuItem()
                    
                    for line in lines {
                        let value = String(line.characters.dropLast())
                        switch count {
                        case 0:
                            menu.firstChoice = value
                        case 1:
                            menu.secondChoice = value
                        case 2:
                            menu.complementary = value
                        case 3:
                            menu.salad = value
                        case 4:
                            menu.desert = value
                        case 5:
                            menu.drink = value
                        default:
                            self.menus.append(menu)
                            menu = MenuItem()
                            count = -1
                        }
                        count++
                    }
                }
                
                self.isLoading = false
                SVProgressHUD.dismiss()
                NSNotificationCenter.defaultCenter().postNotificationName(self.RELOAD_STRING, object: nil)
        }
    }
}