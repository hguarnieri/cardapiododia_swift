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

class HomeViewController: UIViewController {
    
    var menuViewController: MenuViewController?
    
    var mainViewWidth: CGFloat!
    
    var contentView: UIView!
    var titleView: UIView!
    var dateView: UIView!
    var menuCard: UIView!
    var busCard: UIView!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        self.title = "Inicio"
        self.mainViewWidth = self.view.frame.width
        
        self.contentView = UIView(frame: CGRectMake(0, 0, mainViewWidth, 260))
        self.contentView.center.y = (self.view.frame.height / 2) + 80
        self.view.addSubview(contentView)
        
        // Creates the title view
        self.createTitleView()
        self.view.addSubview(self.titleView)

        // Creates the date view
        self.createDateView()
        self.view.addSubview(self.dateView)
        
        // Creates the menu card
        self.createMenuCard()
        contentView.addSubview(self.menuCard)
        
        // Creates the bus card
        self.createBusCard()
        contentView.addSubview(self.busCard)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK:- View creation functions
    func createTitleView() {
        self.titleView = UIView(frame: CGRectMake(0, 44, mainViewWidth, 120))
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
    
    //MARK:- Helper functions
    func swapToMenuViewController() {
        self.tabBarController?.selectedIndex = 1
    }
    
    func swapToBusTimesViewController() {
        self.tabBarController?.selectedIndex = 2
    }
    
    func openMenus() {
        if menuViewController == nil {
            self.menuViewController = MenuViewController()
        }
        
        self.navigationController?.showViewController(self.menuViewController!, sender: self)
    }
}