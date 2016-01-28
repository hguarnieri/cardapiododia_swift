//
//  ViewController.swift
//  cardapiododia
//
//  Created by Henrique Guarnieri on 19/01/2016.
//  Copyright © 2016 Henrique Guarnieri. All rights reserved.
//

import UIKit
import SwipeView

class MenuController: UIViewController, SwipeViewDelegate, SwipeViewDataSource {
    
    var swipeView: SwipeView!
    var segmentedControl: UISegmentedControl!
    
    var widthOfSwipeView: CGFloat!
    var heightOfSwipeView: CGFloat!
    var widthOfCard: CGFloat!
    var heightOfCard: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.widthOfSwipeView = self.view.frame.size.width * 0.7
        self.heightOfSwipeView = self.view.frame.size.height * 0.7
        
        self.widthOfCard = self.view.frame.size.width * 0.6
        self.heightOfCard = self.view.frame.size.height * 0.6
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    
        self.swipeView = SwipeView(frame: CGRectMake((self.view.frame.width / 2) - (self.widthOfSwipeView / 2),
                                          (self.view.frame.height / 2) - (self.heightOfSwipeView / 2) + 64,
                                          self.widthOfSwipeView, self.heightOfSwipeView))
        self.swipeView.itemsPerPage = 1
        self.swipeView.delegate = self
        self.swipeView.dataSource = self
        
        self.segmentedControl = UISegmentedControl(items: ["Almoço", "Jantar"])
        self.segmentedControl.frame = CGRectMake(self.view.frame.width / 2 - self.widthOfSwipeView / 2, self.swipeView.frame.minY - 60, self.widthOfSwipeView, 35)
        self.segmentedControl.layer.cornerRadius = 5.0
        self.segmentedControl.selectedSegmentIndex = 0
        self.segmentedControl.backgroundColor = UIColor.whiteColor()
        self.segmentedControl.tintColor = UIColor.redColor()
        
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.swipeView)
    }
    
    func swipeView(swipeView: SwipeView!, viewForItemAtIndex index: Int, reusingView view: UIView!) -> UIView! {
        let mainView = reuseViewForSwipeView(view, width: self.widthOfSwipeView, height: self.heightOfSwipeView)
        
        let menuCard = UIView(frame: CGRectMake(mainView.frame.size.width / 2 - self.widthOfCard / 2, 0, self.widthOfCard, self.heightOfCard))
        menuCard.backgroundColor = UIColor.whiteColor()
        menuCard.layer.cornerRadius = 8.0
        menuCard.clipsToBounds = true
        
        let label = UILabel(frame: CGRectMake(0, 0, menuCard.frame.size.width - 6, 20))
        label.textAlignment = NSTextAlignment.Center
        label.text = dayOfWeek(index)
        
        menuCard.addSubview(label)
        mainView.addSubview(menuCard)
        return mainView
    }
    
    func numberOfItemsInSwipeView(swipeView: SwipeView!) -> Int {
        return 5
    }
    
    func reuseViewForSwipeView(view: UIView!, width: CGFloat, height: CGFloat) -> UIView {
        if view == nil {
            return UIView(frame: CGRectMake(0, 0, width, height))
        } else {
            for s in view.subviews {
                s.removeFromSuperview()
            }
            return view
        }
    }
    
    func dayOfWeek(day: Int) -> String {
        switch(day) {
        case 0:
            return "Segunda-Feira"
        case 1:
            return "Terça-Feira"
        case 2:
            return "Quarta-Feira"
        case 3:
            return "Quinta-Feira"
        case 4:
            return "Sexta-Feira"
        default:
            return "Unknown"
        }
    }
}

