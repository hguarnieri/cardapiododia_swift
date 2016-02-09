//
//  BusTimesController.swift
//  cardapiododia
//
//  Created by Henrique on 5/02/2016.
//  Copyright © 2016 Henrique Guarnieri. All rights reserved.
//

import Foundation

let BusTimes = BusTimesController.sharedInstance

class BusTimesController {
    
    static let sharedInstance = BusTimesController()
    
    let timetable: [[String]] = [["05:30", "06:20", "07:30", "08:30", "09:30", "11:05", "11:50", "12:25","13:15", "13:35",
        "14:30", "15:30", "16:05", "17:05", "17:35", "18:05", "19:40", "20:45", "21:50", "22:50"],
        
        ["05:45", "06:35", "07:45", "08:45", "09:45", "11:20", "12:05", "12:40", "13:25", "13:50",
            "14:45", "15:45", "16:20", "17:20", "17:50", "18:20", "19:55", "21:00", "22:05", "23:05"],
        
        ["06:00", "06:50", "08:00", "09:00", "10:00", "11:35", "12:20", "12:55", "13:40",
            "14:05", "15:00", "16:00", "16:35", "17:35", "18:05", "18:35", "20:10", "21:15", "22:20", "23:20"],
        
        ["05:50", "06:25", "07:35", "11:05", "12:25", "13:35", "15:00", "16:00", "17:05",
            "17:45"],
        
        ["06:05", "06:40", "07:50", "11:20", "12:40", "13:50", "15:15", "16:15", "17:20",
            "18:00"],
        
        ["06:20", "06:55", "08:05", "11:35", "12:55", "14:05", "15:30", "16:30", "17:35",
            "18:15"]]
    
    let timetableTitles: [String] = ["Saída do Prédio Central", "Portão de Acesso", "Chegada ao Prédio Central"]
    let timetablePeriods: [String] = ["Período Letivo", "Férias"]
    
    func getNextTime(index: Int) -> String {
        let date = NSDate()
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = NSTimeZone(abbreviation: "ACST")
        
        let hourNow = formatter.stringFromDate(date)
        
        formatter.timeZone = NSTimeZone(abbreviation: "UTC")
        
        for timeString in self.timetable[index] {
            let time = formatter.dateFromString(timeString)
            let timeNow = formatter.dateFromString(hourNow)
            
            if time!.isGreaterThanDate(timeNow!) || time!.isEqualToDate(timeNow!) {
                return timeString
            }
        }
        
        return self.timetable[index][0]
    
    }
}