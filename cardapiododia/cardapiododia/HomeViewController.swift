//
//  HomeViewController.swift
//  cardapiododia
//
//  Created by Henrique Guarnieri on 29/01/2016.
//  Copyright © 2016 Henrique Guarnieri. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mainViewWidth: CGFloat!
    
    var contentView: UIView!
    var titleView: UIView!
    var dateView: UIView!
    var menuCard: UIView!
    var busCard: UIView!
    
    var menuTableView: UITableView!
    var busTableView: UITableView!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        self.title = "Inicio"
        self.mainViewWidth = self.view.frame.width
        
        self.contentView = UIView(frame: CGRectMake(0, 0, mainViewWidth, 312))
        
        //TODO: Improve this
        if DeviceType.IS_IPHONE_4_OR_LESS {
            self.contentView.center.y = (self.view.frame.height / 2) + 20
        } else {
            self.contentView.center.y = (self.view.frame.height / 2) + 70
        }
        
        self.view.addSubview(contentView)
        
        // Creates the title view
        self.createTitleView()
        self.view.addSubview(self.titleView)

        // Creates the date view
        self.createDateView()
        self.view.addSubview(self.dateView)
        
        // Creates the menu card
        self.createMenuTableView()
        contentView.addSubview(self.menuCard)
        
        // Creates the bus card
        self.createBusTableView()
        contentView.addSubview(self.busCard)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK:- View creation functions
    func createTitleView() {
        if DeviceType.IS_IPHONE_4_OR_LESS {
            self.titleView = UIView(frame: CGRectMake(0, 30, mainViewWidth, 0))
        } else {
            self.titleView = UIView(frame: CGRectMake(0, 30, mainViewWidth, 120))
            self.titleView.backgroundColor = UIColor.redColor()
            
            let imageHat = UIImage(named: "chefsHat")
            let imageViewHat = UIImageView(image: imageHat)
            imageViewHat.image = (imageViewHat.image?.imageWithRenderingMode(.AlwaysTemplate))!
            imageViewHat.tintColor = UIColor.whiteColor()
            imageViewHat.frame = CGRectMake(16, 0, 70, 70)
            imageViewHat.center.y = (self.titleView.frame.height / 2)
            self.titleView.addSubview(imageViewHat)
            
            let title = UILabel(frame: CGRectMake(imageViewHat.frame.maxX + 16, imageViewHat.frame.minY + 4, self.view.frame.width - imageViewHat.frame.maxX - 50, 100))
            title.font = UIFont.systemFontOfSize(18)
            title.textColor = UIColor.whiteColor()
            title.numberOfLines = 0
            title.text = "CARDÁPIO DO DIA" + "\nCardápio e Laranjinha da FZEA na palma da sua mão!"
            title.sizeToFit()
            title.center.y = imageViewHat.center.y + 3
            self.titleView.addSubview(title)
        }
        
    }
    
    //TODO: Fix the date format for English
    func createDateView() {
        self.dateView = UIView(frame: CGRectMake(0, self.titleView.frame.maxY + 8, self.mainViewWidth, 30))
        self.dateView.backgroundColor = UIColor.redColor()
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE, dd 'de' MMMM 'de' y"
        
        let date = UILabel(frame: CGRectMake(8, 0, self.mainViewWidth, 20))
        date.text = formatter.stringFromDate(NSDate())
        date.textColor = UIColor.whiteColor()
        date.center.y = (dateView.frame.height / 2)
        
        dateView.addSubview(date)
    }

    func createMenuCard() {
        self.menuCard = UIView(frame: CGRectMake(0, 0, self.mainViewWidth, 85))
        self.menuCard.backgroundColor = UIColor.whiteColor()
        self.menuCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "swapToMenuViewController"))
        
        let lunchText = UILabel(frame: CGRectMake(8, 8, self.mainViewWidth, 20))
        lunchText.font = UIFont.fontAwesomeOfSize(16)
        lunchText.text = "Almoço - \(Menu.lunchStartingTime) às \(Menu.lunchEndingTime) " + String.fontAwesomeIconWithName(.ClockO)
        self.menuCard.addSubview(lunchText)
        
        let lineLunch = drawLineWithWidth(self.mainViewWidth, height: 1, below: lunchText)
        self.menuCard.addSubview(lineLunch)
        
        let dinnerText = UILabel(frame: CGRectMake(8, lineLunch.frame.maxY + 8, self.mainViewWidth, 20))
        dinnerText.font = UIFont.fontAwesomeOfSize(16)
        dinnerText.text = "Jantar - \(Menu.dinnerStartingTime) às \(Menu.dinnerEndingTime) " + String.fontAwesomeIconWithName(.ClockO)
        self.menuCard.addSubview(dinnerText)
        
        let lineDinner = drawLineWithWidth(self.mainViewWidth, height: 1, below: dinnerText)
        self.menuCard.addSubview(lineDinner)
    }
    
    func createMenuTableView() {
        self.menuCard = UIView(frame: CGRectMake(0, 0, self.mainViewWidth, 135))
        self.menuCard.backgroundColor = UIColor.whiteColor()
        self.menuCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "swapToMenuViewController"))
        
        self.menuTableView = UITableView(frame: CGRectMake(0, 0, self.mainViewWidth, 135))
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        self.menuTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.menuCard.addSubview(self.menuTableView)
    }
    
    func createBusCard() {
        self.busCard = UIView(frame: CGRectMake(0, menuCard.frame.maxY + 20, self.mainViewWidth, 150))
        self.busCard.backgroundColor = UIColor.whiteColor()
        self.busCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "swapToBusTimesViewController"))
        
        let busTitle = UILabel(frame: CGRectMake(8, 16, self.view.frame.size.width - 8, 20))
        busTitle.text = "Horário de Ônibus - Interno"
        self.busCard.addSubview(busTitle)
        
        let lineBus = drawCustomImage(CGSize(width: self.mainViewWidth, height: 1))
        let lineBusImageView = UIImageView(image: lineBus)
        lineBusImageView.frame = CGRectMake(8, busTitle.frame.maxY + 8, self.mainViewWidth - 16, 1)
        self.busCard.addSubview(lineBusImageView)
        
        let busTextCentral = UILabel(frame: CGRectMake(12, lineBusImageView.frame.maxY + 16, self.mainViewWidth, 20))
        busTextCentral.font = UIFont.fontAwesomeOfSize(16)
        busTextCentral.text = String.fontAwesomeIconWithName(.Bus) + "  Saída do Prédio Central - \(BusTimes.getNextTime(0))"
        self.busCard.addSubview(busTextCentral)
        
        let busTextPortao = UILabel(frame: CGRectMake(12, busTextCentral.frame.maxY + 8, self.mainViewWidth, 20))
        busTextPortao.font = UIFont.fontAwesomeOfSize(16)
        busTextPortao.text = String.fontAwesomeIconWithName(.Bus) + "  Portão de Acesso - \(BusTimes.getNextTime(1))"
        self.busCard.addSubview(busTextPortao)
        
        let busTextBackCentral = UILabel(frame: CGRectMake(12, busTextPortao.frame.maxY + 8, self.mainViewWidth, 20))
        busTextBackCentral.font = UIFont.fontAwesomeOfSize(16)
        busTextBackCentral.text = String.fontAwesomeIconWithName(.Bus) + "  Chegada Prédio Central - \(BusTimes.getNextTime(2))"
        self.busCard.addSubview(busTextBackCentral)
    }
    
    func createBusTableView() {
        self.busCard = UIView(frame: CGRectMake(0, menuCard.frame.maxY + 8, self.mainViewWidth, 150))
        self.busCard.backgroundColor = UIColor.whiteColor()
        self.busCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "swapToBusTimesViewController"))
        
        self.busTableView = UITableView(frame: CGRectMake(0, 0, self.mainViewWidth, 170))
        self.busTableView.delegate = self
        self.busTableView.dataSource = self
        self.busTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.busCard.addSubview(self.busTableView)
    }
    
    //MARK:- Helper functions
    func swapToMenuViewController() {
        self.tabBarController?.selectedIndex = 1
    }
    
    func swapToBusTimesViewController() {
        self.tabBarController?.selectedIndex = 2
    }
    
    //MARK:- TableView functions
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.menuTableView {
            return 2
        } else {
            return 3
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel?.font = UIFont.fontAwesomeOfSize(16)
        
        var text: String!
        
        if tableView == self.menuTableView {
            switch (indexPath.row) {
            case 0:
                text = "Almoço - \(Menu.lunchStartingTime) às \(Menu.lunchEndingTime) " + String.fontAwesomeIconWithName(.ClockO)
            case 1:
                text = "Jantar - \(Menu.dinnerStartingTime) às \(Menu.dinnerEndingTime) " + String.fontAwesomeIconWithName(.ClockO)
            default:
                text = ""
            }
        } else {
            switch (indexPath.row) {
            case 0:
                text = String.fontAwesomeIconWithName(.Bus) + "  Saída do Prédio Central - \(BusTimes.getNextTime(0))"
            case 1:
                text = String.fontAwesomeIconWithName(.Bus) + "  Portão de Acesso - \(BusTimes.getNextTime(1))"
            case 2:
                text = String.fontAwesomeIconWithName(.Bus) + "  Chegada Prédio Central - \(BusTimes.getNextTime(2))"
            default:
                text = ""
            }
        }
        
        cell.textLabel?.text = text
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRectMake(0, 0, self.mainViewWidth, 40))
        
        view.backgroundColor = UIColor.whiteColor()
        
        let title = UILabel(frame: CGRectMake(8, 10, self.view.frame.size.width - 8, 20))
        
        if tableView == self.menuTableView {
            title.text = "Horário do Restaurante Universitário"
        } else {
            title.text = "Horário do Ônibus Interno"
        }
        
        view.addSubview(title)
        
        let lineBus = drawCustomImage(CGSize(width: self.mainViewWidth, height: 1))
        let lineBusImageView = UIImageView(image: lineBus)
        lineBusImageView.frame = CGRectMake(8, title.frame.maxY + 8, self.mainViewWidth - 16, 1)
        view.addSubview(lineBusImageView)
        
        return view
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == self.menuTableView {
            self.swapToMenuViewController()
        } else {
            self.swapToBusTimesViewController()
        }
    }
}