//
//  BusTimesViewController.swift
//  cardapiododia
//
//  Created by Henrique on 5/02/2016.
//  Copyright © 2016 Henrique Guarnieri. All rights reserved.
//

import UIKit

class BusTimesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var titleView: UIView!
    var timesView: UIView!
    var contentView: UIView!
    
    var tableView: UITableView!
    
    var mainViewWidth: CGFloat!
    
    override func viewDidLoad() {
        
        self.title = "Laranjinha"
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        self.mainViewWidth = self.view.frame.width
        
        self.contentView = UIView(frame: CGRectMake(0, 0, self.mainViewWidth, 200))
        
        self.timesView = UIView(frame: CGRectMake(0, 0, self.mainViewWidth, 200))
        self.timesView.backgroundColor = UIColor.whiteColor()
        
        self.tableView = UITableView(frame: CGRectMake(self.timesView.frame.maxX - 100, 0, 100, self.timesView.frame.height))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.reloadData()
        self.timesView.addSubview(self.tableView)
        
        self.contentView.addSubview(timesView)
        
        self.view.addSubview(self.contentView)
    }
    
    //TODO: Highlight next bus time
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = BusTimes.timetable[0][indexPath.row]
        cell.textLabel?.textAlignment = NSTextAlignment.Center
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BusTimes.timetable[0].count
    }
}
