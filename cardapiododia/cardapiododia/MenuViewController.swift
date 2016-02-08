//
//  ViewController.swift
//  cardapiododia
//
//  Created by Henrique Guarnieri on 19/01/2016.
//  Copyright © 2016 Henrique Guarnieri. All rights reserved.
//

import UIKit
import SwipeView
import SVProgressHUD
import FontAwesome_swift

class MenuViewController: UIViewController, SwipeViewDelegate, SwipeViewDataSource {
    
    var swipeView: SwipeView!
    var segmentedControl: UISegmentedControl!
    
    var widthOfSwipeView: CGFloat!
    var heightOfSwipeView: CGFloat!
    var widthOfCard: CGFloat!
    var heightOfCard: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Cardápio"
        
        let attributes = [NSFontAttributeName: UIFont.fontAwesomeOfSize(20)] as Dictionary!
        let button = UIBarButtonItem(title: "", style: .Plain, target: self, action: "reloadData")
        button.setTitleTextAttributes(attributes, forState: .Normal)
        button.title = String.fontAwesomeIconWithName(.Repeat)
        button.tintColor = UIColor.redColor()
        self.navigationItem.rightBarButtonItem = button

        self.widthOfSwipeView = self.view.frame.size.width * 0.7
        self.heightOfSwipeView = self.view.frame.size.height * 0.7
        self.widthOfCard = self.view.frame.size.width * 0.6
        self.heightOfCard = self.view.frame.size.height * 0.7

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    
        self.swipeView = SwipeView(frame: CGRectMake(0, 0, self.widthOfSwipeView, self.heightOfSwipeView))
        self.swipeView.center.x = (self.view.frame.size.width / 2)
        self.swipeView.center.y = (self.view.frame.size.height / 2) - 44
        self.swipeView.itemsPerPage = 1
        self.swipeView.delegate = self
        self.swipeView.dataSource = self
        
        var segmentedSpacing: CGFloat = 45
        if DeviceType.IS_IPHONE_5 {
            segmentedSpacing = 35
        }
        
        self.segmentedControl = UISegmentedControl(items: ["Almoço", "Jantar"])
        self.segmentedControl.frame = CGRectMake(self.view.frame.width / 2 - self.widthOfSwipeView / 2, self.swipeView.frame.minY - segmentedSpacing, self.widthOfSwipeView, 30)
        self.segmentedControl.layer.cornerRadius = 5.0
        self.segmentedControl.selectedSegmentIndex = 0
        self.segmentedControl.backgroundColor = UIColor.whiteColor()
        self.segmentedControl.tintColor = UIColor.redColor()
        self.segmentedControl.addTarget(self, action: Selector("segmentedControlChanged"), forControlEvents: UIControlEvents.ValueChanged)
        
        let mainView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, self.swipeView.frame.maxY))
        
        mainView.addSubview(self.segmentedControl)
        mainView.addSubview(self.swipeView)
        mainView.center.y = self.view.frame.height / 2
        
        NSNotificationCenter.defaultCenter().addObserverForName(Menu.RELOAD_STRING, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { notification in
            self.swipeView.reloadData()
        })
        
        self.view.addSubview(mainView)
        
        self.reloadData()
    }
    
    func swipeView(swipeView: SwipeView!, viewForItemAtIndex index: Int, reusingView view: UIView!) -> UIView! {
        let mainView = UIView(frame: CGRectMake(0, 0, self.widthOfSwipeView, self.heightOfSwipeView))
        
        //TODO: Implement offline connection handler
        var type = 0
        if segmentedControl.selectedSegmentIndex == 1 {
            type = 4
        }
        
        var menu = MenuItem()
        if let menus = Menu.menus {
            menu = menus[index + type]
        }
        
        let menuCard = UIView(frame: CGRectMake(0, 0, self.widthOfCard, self.heightOfCard))
        menuCard.center.x = mainView.center.x
        menuCard.backgroundColor = UIColor.whiteColor()
        menuCard.layer.cornerRadius = 8.0
        menuCard.clipsToBounds = true
        
        let title = UILabel(frame: CGRectMake(0, 8, 0, 0))
        title.font = UIFont.boldSystemFontOfSize(17)
        title.text = dayOfWeek(index)
        title.sizeToFit()
        title.center.x = menuCard.frame.size.width / 2

        let imageMainChoice = getImageViewForImageNamed("mainChoice", below: title, margin: 8)
        let labelMainChoice = createLabelForText(menu.firstChoice, below: imageMainChoice)
        
        let imageSecondChoice = getImageViewForImageNamed("secondChoice", below: labelMainChoice)
        let labelSecondChoice = createLabelForText(menu.secondChoice, below: imageSecondChoice)
        
        let imageComplementary = getImageViewForImageNamed("complementary", below: labelSecondChoice)
        let labelComplementary = createLabelForText(menu.complementary, below: imageComplementary)
        
        let imageSalad = getImageViewForImageNamed("salad", below: labelComplementary)
        let labelSalad = createLabelForText(menu.salad, below: imageSalad)
        
        let imageDesert = getImageViewForImageNamed("desert", below: labelSalad)
        let labelDesert = createLabelForText(menu.desert, below: imageDesert)
        
        let imageDrink = getImageViewForImageNamed("drink", below: labelDesert)
        let labelDrink = createLabelForText(menu.drink, below: imageDrink)

        let contentView = UIView()
        
        contentView.addSubview(title)
        contentView.addSubview(imageMainChoice)
        contentView.addSubview(labelMainChoice)
        contentView.addSubview(imageSecondChoice)
        contentView.addSubview(labelSecondChoice)
        contentView.addSubview(imageComplementary)
        contentView.addSubview(labelComplementary)
        contentView.addSubview(imageSalad)
        contentView.addSubview(labelSalad)
        contentView.addSubview(imageDesert)
        contentView.addSubview(labelDesert)
        contentView.addSubview(imageDrink)
        contentView.addSubview(labelDrink)
        
        contentView.frame = CGRectMake(0, 0, menuCard.frame.width, labelDrink.frame.maxY)
        contentView.center.y = menuCard.frame.height / 2
        
        menuCard.addSubview(contentView)
        mainView.addSubview(menuCard)
  
        return mainView
    }
    
    func numberOfItemsInSwipeView(swipeView: SwipeView!) -> Int {
        if let items = Menu.menus {
            return items.count / 2
        } else {
            return 0
        }
    }
    
    //MARK:- Views creation functions
    func getImageViewForImageNamed(name: String, below: UIView, margin: Int? = 4) -> UIImageView {
        let image = UIImage(named: name)
        let imageView = UIImageView(image: image)
        imageView.image = (imageView.image?.imageWithRenderingMode(.AlwaysTemplate))!
        
        if DeviceType.IS_IPHONE_4_OR_LESS {
            imageView.frame = CGRectMake(0, 0, 25, 25)
        } else if DeviceType.IS_IPHONE_6P {
            imageView.frame = CGRectMake(0, 0, 35, 35)
        } else {
            imageView.frame = CGRectMake(0, 0, 30, 30)
        }
        
        imageView.tintColor = UIColor.redColor()
        imageView.frame.origin.y = below.frame.maxY + CGFloat(margin!)
        imageView.center.x = below.center.x
        
        return imageView
    }
    
    func createLabelForText(text: String, below: UIView, margin: Int? = 4) -> UILabel {
        let label = UILabel()
        
        if DeviceType.IS_IPHONE_4_OR_LESS {
            label.font = UIFont.systemFontOfSize(14)
        } else if DeviceType.IS_IPHONE_5 {
            label.font = UIFont.systemFontOfSize(15)
        }
        
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.Center
        label.frame.size.width = self.widthOfCard - 8
        label.sizeToFit()
        
        label.frame.origin.y = below.frame.maxY + CGFloat(margin!)
        label.center.x = below.center.x
        
        return label
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
    
    func reloadData() {
        SVProgressHUD.showWithStatus("Loading")
        Menu.reloadData()
    }
    
    func segmentedControlChanged() {
        self.swipeView.reloadData()
    }
}

