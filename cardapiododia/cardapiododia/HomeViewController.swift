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
    
    var menuViewController: MenuViewController?
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        self.title = "Inicio"
        
        let topCard = UIView(frame: CGRectMake(0, 44, self.view.frame.width, 120))
        topCard.backgroundColor = UIColor.redColor()
        
        let contentView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 244))
        contentView.center.y = (self.view.frame.width / 2) + 212
        
        let imageHat = UIImage(named: "chefsHat")
        let imageViewHat = UIImageView(image: imageHat)
        imageViewHat.image = (imageViewHat.image?.imageWithRenderingMode(.AlwaysTemplate))!
        imageViewHat.tintColor = UIColor.whiteColor()
        imageViewHat.frame = CGRectMake(16, 0, 70, 70)
        imageViewHat.center.y = (topCard.frame.height / 2)
        
        let title = UILabel(frame: CGRectMake(imageViewHat.frame.maxX + 16, imageViewHat.frame.minY + 4, 200, 22))
        title.font = UIFont.systemFontOfSize(22)
        title.textColor = UIColor.whiteColor()
        title.text = "CARDÁPIO DO DIA"
        
        let description = UILabel(frame: CGRectMake(imageViewHat.frame.maxX + 16, title.frame.maxY + 5, 250, 40))
        description.textColor = UIColor.whiteColor()
        description.text = "Cardápio e Laranjinha da FZEA na palma da sua mão!"
        description.numberOfLines = 0
        description.sizeToFit()
        
        topCard.addSubview(imageViewHat)
        topCard.addSubview(title)
        topCard.addSubview(description)
        
        let dateCard = UIView(frame: CGRectMake(0, topCard.frame.maxY + 8, self.view.frame.width, 30))
        dateCard.backgroundColor = UIColor.redColor()
        let date = UILabel(frame: CGRectMake(8, 0, self.view.frame.width, 20))
        date.text = "Quarta-Feira, 06 de agosto de 2014"
        date.textColor = UIColor.whiteColor()
        date.center.y = (dateCard.frame.height / 2)
        dateCard.addSubview(date)
        
        let menuCard = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 94))
        menuCard.backgroundColor = UIColor.whiteColor()
        menuCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "swapToMenuViewController"))
        
        let lunchText = UILabel(frame: CGRectMake(8, 12, self.view.frame.width, 20))
        lunchText.text = "Almoço - 11:00 às 13:30"
        menuCard.addSubview(lunchText)
        
        let lineLunch = drawCustomImage(CGSize(width: self.view.frame.width, height: 1))
        let lineLunchImageView = UIImageView(image: lineLunch)
        lineLunchImageView.frame = CGRectMake(8, lunchText.frame.maxY + 8, self.view.frame.width - 16, 1)
        menuCard.addSubview(lineLunchImageView)
        
        let dinnerText = UILabel(frame: CGRectMake(8, lunchText.frame.maxY + 16, self.view.frame.width, 20))
        dinnerText.text = "Jantar - 17:00 às 19:15"
        menuCard.addSubview(dinnerText)
        
        let lineDinner = drawCustomImage(CGSize(width: self.view.frame.width, height: 1))
        let lineDinnerImageView = UIImageView(image: lineDinner)
        lineDinnerImageView.frame = CGRectMake(8, dinnerText.frame.maxY + 8, self.view.frame.width - 16, 1)
        menuCard.addSubview(lineDinnerImageView)
        
        contentView.addSubview(menuCard)
        
        let busCard = UIView(frame: CGRectMake(0, menuCard.frame.maxY + 20, self.view.frame.width, 150))
        busCard.backgroundColor = UIColor.whiteColor()
        contentView.addSubview(busCard)
        
        self.view.addSubview(contentView)
        
        self.view.addSubview(topCard)
        self.view.addSubview(dateCard)
    }
    
    func drawCustomImage(size: CGSize) -> UIImage {
        // Setup our context
        let bounds = CGRect(origin: CGPoint.zero, size: size)
        let opaque = false
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        let context = UIGraphicsGetCurrentContext()
        
        // Setup complete, do drawing here
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        CGContextSetLineWidth(context, 2.0)
        
        CGContextStrokeRect(context, bounds)
        
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, CGRectGetMinX(bounds), CGRectGetMinY(bounds))
        CGContextAddLineToPoint(context, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds))
        CGContextMoveToPoint(context, CGRectGetMaxX(bounds), CGRectGetMinY(bounds))
        CGContextAddLineToPoint(context, CGRectGetMinX(bounds), CGRectGetMaxY(bounds))
        CGContextStrokePath(context)
        
        // Drawing complete, retrieve the finished image and cleanup
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    func swapToMenuViewController() {
        self.tabBarController?.selectedIndex = 1
    }
    
    func openMenus() {
        if menuViewController == nil {
            self.menuViewController = MenuViewController()
        }
        
        self.navigationController?.showViewController(self.menuViewController!, sender: self)
    }
}