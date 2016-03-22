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

class MenuViewController: UIViewController, SwipeViewDelegate, SwipeViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    var contentView: UIView!
    var segmentedControl: UISegmentedControl!
    var swipeView: SwipeView!
    
    var widthForSwipeView: CGFloat!
    var heightForSwipeView: CGFloat!
    var widthForCard: CGFloat!
    var heightForCard: CGFloat!
    var width: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Cardápio"
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        self.createRefreshButton()

        self.widthForSwipeView = self.view.frame.width * 0.70
        self.heightForSwipeView = self.view.frame.height * 0.7
        self.widthForCard = self.view.frame.width * 0.6
        self.heightForCard = self.view.frame.height * 0.65
        self.width = self.view.frame.width
        
        // Creates the view to centralize the content
        self.createContentView()
        
        // Creates the segmented control
        self.createSegmentedControl()
        self.contentView.addSubview(self.segmentedControl)
        
        // Creates the swipe view
        self.createSwipeView()
        self.contentView.addSubview(self.swipeView)
        
        // Create the notification observer
        self.createNotificationCenterObserver()
        
        self.view.addSubview(self.contentView)
        self.reloadData()
    }
    
    //MARK:- Visual functions
    func createRefreshButton() {
        let attributes = [NSFontAttributeName: UIFont.fontAwesomeOfSize(20)] as Dictionary!
        let button = UIBarButtonItem(title: "", style: .Plain, target: self, action: "reloadData")
        button.setTitleTextAttributes(attributes, forState: .Normal)
        button.title = String.fontAwesomeIconWithName(.Repeat)
        button.tintColor = UIColor.redColor()
        self.navigationItem.rightBarButtonItem = button
    }
    
    func createContentView() {
        self.contentView = UIView(frame: CGRectMake(0, 0, self.widthForSwipeView, self.heightForSwipeView))
        self.contentView.center.x = (self.view.frame.width / 2)
        self.contentView.center.y = (self.view.frame.height / 2) + 8
    }
    
    func createSwipeView() {
        self.swipeView = SwipeView(frame: CGRectMake(0, self.segmentedControl.frame.height + 8, self.widthForSwipeView, self.heightForSwipeView))
        self.swipeView.itemsPerPage = 1
        self.swipeView.delegate = self
        self.swipeView.dataSource = self
    }
    
    func createSegmentedControl() {
        self.segmentedControl = UISegmentedControl(items: ["Almoço", "Jantar"])
        self.segmentedControl.frame = CGRectMake(0, 0, self.widthForSwipeView, 28)
        self.segmentedControl.layer.cornerRadius = 5.0
        self.segmentedControl.selectedSegmentIndex = 0
        self.segmentedControl.backgroundColor = UIColor.whiteColor()
        self.segmentedControl.tintColor = UIColor.redColor()
        self.segmentedControl.addTarget(self, action: Selector("segmentedControlChanged"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    //MARK:- Observers
    func createNotificationCenterObserver() {
        NSNotificationCenter.defaultCenter().addObserverForName(Menu.RELOAD_STRING, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { notification in
            self.swipeView.reloadData()
        })
    }
    
    func swipeView(swipeView: SwipeView!, viewForItemAtIndex index: Int, reusingView view: UIView!) -> UIView! {
        let mainView = UIView(frame: CGRectMake(0, 0, self.widthForSwipeView, self.heightForSwipeView))
        
        let menuCard = UIView(frame: CGRectMake(0, 0, self.widthForCard, self.heightForCard))
        menuCard.center.x = mainView.center.x
        menuCard.backgroundColor = UIColor.whiteColor()
        menuCard.layer.cornerRadius = 8.0
        menuCard.clipsToBounds = true
        
        var type = 0
        if self.segmentedControl.selectedSegmentIndex == 1 {
            type = 5
        }
        
        let tableView = UITableView(frame: CGRectMake(0, 8, self.widthForCard, self.heightForCard - 15))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.tag = index + type
        menuCard.addSubview(tableView)
        
        tableView.reloadData()
        
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
    
    //MARK:- TableView functions
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        for s in cell.contentView.subviews {
            s.removeFromSuperview()
        }
        
        var icon: UIImageView!
        let label = UILabel()
        var text: String!
        
        switch (indexPath.row) {
        case 0:
            text = Menu.menus[tableView.tag].firstChoice
            icon = getImageViewForImageNamed("mainChoice")
        case 1:
            text = Menu.menus[tableView.tag].secondChoice
            icon = getImageViewForImageNamed("secondChoice")
        case 2:
            text = Menu.menus[tableView.tag].complementary
            icon = getImageViewForImageNamed("complementary")
        case 3:
            text = Menu.menus[tableView.tag].salad
            icon = getImageViewForImageNamed("salad")
        case 4:
            text = Menu.menus[tableView.tag].desert
            icon = getImageViewForImageNamed("desert")
        case 5:
            text = Menu.menus[tableView.tag].drink
            icon = getImageViewForImageNamed("drink")
        default:
            text = ""
        }
        
        icon.frame = CGRectMake(0, 8, 30, 30)
        icon.center.x = (self.widthForCard / 2)
        
        label.frame = CGRectMake(6, icon.frame.maxY + 4, self.widthForCard - 12, 20)
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(15)
        
        if text == "-" {
            label.text = "Não Informado"
        } else {
            label.text = text
        }
        
        cell.contentView.addSubview(label)
        cell.contentView.addSubview(icon)
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 20))
        view.backgroundColor = UIColor.whiteColor()

        let day = tableView.tag % 5
        var text: String!
        
        switch(day) {
        case 0:
            text = "Segunda-Feira"
        case 1:
            text = "Terça-Feira"
        case 2:
            text = "Quarta-Feira"
        case 3:
            text = "Quinta-Feira"
        case 4:
            text = "Sexta-Feira"
        default:
            text = ""
        }
        
        let title = UILabel(frame: CGRectMake(0, 0, self.widthForCard, 20))
        title.text = text
        title.font = UIFont.boldSystemFontOfSize(16)
        title.textAlignment = NSTextAlignment.Center
        view.addSubview(title)
        
//        let lineBus = drawCustomImage(CGSize(width: self.view.frame.size.width, height: 1))
//        let lineBusImageView = UIImageView(image: lineBus)
//        lineBusImageView.frame = CGRectMake(8, title.frame.maxY + 8, self.mainViewWidth - 16, 1)
//        view.addSubview(lineBusImageView)
        
        return view
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 67
    }
    
    //MARK:- Views creation functions
    func getImageViewForImageNamed(name: String) -> UIImageView {
        let image = UIImage(named: name)
        let imageView = UIImageView(image: image)
        imageView.image = (imageView.image?.imageWithRenderingMode(.AlwaysTemplate))!
        imageView.tintColor = UIColor.redColor()
        
        return imageView
    }
    
    func createLabelForText(text: String) -> UILabel {
        let label = UILabel()
        
        if DeviceType.IS_IPHONE_4_OR_LESS {
            label.font = UIFont.systemFontOfSize(14)
        } else if DeviceType.IS_IPHONE_5 {
            label.font = UIFont.systemFontOfSize(15)
        }
        
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.Center
        label.frame.size.width = self.widthForCard
        label.sizeToFit()
        
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

