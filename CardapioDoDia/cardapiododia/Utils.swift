//
//  Utils.swift
//  cardapiododia
//
//  Created by Henrique on 8/02/2016.
//  Copyright © 2016 Henrique Guarnieri. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Visual functions
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

func drawLineWithWidth(width: CGFloat, height: CGFloat, below view: UIView, paddingTop: Int? = 8) -> UIImageView {
    let size = CGSize(width: width, height: height)
    let frame = CGRectMake(view.frame.minX, view.frame.maxY + CGFloat(paddingTop!), width, height)
    
    let imageView = UIImageView(image: drawCustomImage(size))
    imageView.frame = frame
    
    return imageView
}