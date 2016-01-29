//
//  MenuModel.swift
//  cardapiododia
//
//  Created by Henrique Guarnieri on 29/01/2016.
//  Copyright © 2016 Henrique Guarnieri. All rights reserved.
//

import Foundation

enum MenuType {
    case Lunch
    case Dinner
}

class MenuItem {
    
    var type: MenuType!
    var firstChoice: String = ""
    var secondChoice: String = ""
    var complementary: String = ""
    var salad: String = ""
    var desert: String = ""
    var drink: String = ""
    
}