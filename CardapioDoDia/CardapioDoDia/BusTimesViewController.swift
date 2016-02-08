//
//  BusTimesViewController.swift
//  cardapiododia
//
//  Created by Henrique on 5/02/2016.
//  Copyright © 2016 Henrique Guarnieri. All rights reserved.
//

import UIKit
import SwipeView

class BusTimesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeViewDelegate, SwipeViewDataSource {
    
    var titleView: UIView!
    var contentView: UIView!
    
    var swipeView: SwipeView!
    
    var widthForSwipeView: CGFloat!
    var heightForSwipeView: CGFloat!
    var widthForCard: CGFloat!
    var heightForCard: CGFloat!
    var width: CGFloat!
    
    override func viewDidLoad() {
        BusTimes.getNextTime(0)
        
        self.widthForSwipeView = self.view.frame.size.width * 0.7
        self.heightForSwipeView = self.view.frame.size.height * 0.7
        self.widthForCard = self.view.frame.size.width * 0.6
        self.heightForCard = self.view.frame.size.height * 0.7
        self.width = self.view.frame.width
        
        self.title = "Laranjinha"
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        self.contentView = UIView(frame: CGRectMake(0, 0, self.widthForSwipeView, self.heightForSwipeView))
        self.contentView.center.x = (self.view.frame.width / 2)
        self.contentView.center.y = (self.view.frame.height / 2) + 20
        
        self.swipeView = SwipeView(frame: CGRectMake(0, 0, self.widthForSwipeView, self.heightForSwipeView))
        self.swipeView.center.x = (self.contentView.frame.width / 2)
        self.swipeView.center.y = (self.contentView.frame.height / 2)
        self.swipeView.itemsPerPage = 1
        self.swipeView.delegate = self
        self.swipeView.dataSource = self

        self.contentView.addSubview(self.swipeView)
        
        self.view.addSubview(self.contentView)
    }
    
    //MARK:- SwipeView functions
    func swipeView(swipeView: SwipeView!, viewForItemAtIndex index: Int, reusingView view: UIView!) -> UIView! {
        let mainView = UIView(frame: CGRectMake(0, 0, self.widthForSwipeView, self.heightForSwipeView))
        
        // Card creation
        let card = UIView(frame: CGRectMake(0, 0, self.widthForCard, self.heightForCard))
        card.backgroundColor = UIColor.whiteColor()
        card.center.x = (mainView.frame.width / 2)
        
        // Rounded corners
        card.layer.cornerRadius = 8.0
        card.clipsToBounds = true
        
        // Title
        let title = UILabel(frame: CGRectMake(8, 8, width, 20))
        title.font = UIFont.fontAwesomeOfSize(16)
        title.text = "\(String.fontAwesomeIconWithName(.ClockO)) \(BusTimes.timetableTitles[index % 3])"
        
        let line = drawLineWithWidth(card.frame.width - 8, height: 1, below: title)
        
        // Period of the week
        let days = UILabel(frame: CGRectMake(8, line.frame.maxY + 8, 0, 0))
        days.text = "Segunda à Sexta-Feira"
        days.sizeToFit()
        days.center.x = (card.frame.width / 2)
        
        // Period of the calendar
        let subTitle = UILabel(frame: CGRectMake(8, days.frame.maxY + 8, 0, 0))
        subTitle.text = "\(BusTimes.timetablePeriods[index / 3])"
        subTitle.sizeToFit()
        subTitle.center.x = (card.frame.width / 2)
        
        // TableView creation
        let tableView = UITableView(frame: CGRectMake(0, subTitle.frame.maxY + 8, 100, card.frame.height - subTitle.frame.maxY - 16))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.center.x = (card.frame.width / 2)
        tableView.tag = index
        
        card.addSubview(title)
        card.addSubview(line)
        card.addSubview(days)
        card.addSubview(subTitle)
        card.addSubview(tableView)
        
        mainView.addSubview(card)
        
        return mainView
    }
    
    func numberOfItemsInSwipeView(swipeView: SwipeView!) -> Int {
        return BusTimes.timetable.count
    }
    
    //MARK:- TableView functions
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        if BusTimes.timetable[tableView.tag][indexPath.row] == BusTimes.getNextTime(tableView.tag) {
            cell.textLabel?.font = UIFont.boldSystemFontOfSize(16)
        } else {
            cell.textLabel?.font = UIFont.systemFontOfSize(16)
        }
        
        cell.textLabel?.text = BusTimes.timetable[tableView.tag][indexPath.row]
        cell.textLabel?.textAlignment = NSTextAlignment.Center
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BusTimes.timetable[tableView.tag].count
    }
}
