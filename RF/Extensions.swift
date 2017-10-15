//
//  Extensions.swift
//  RF
//
//  Created by Nikhil Manapure on 14/10/17.
//  Copyright © 2017 Nikhil Manapure. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    private static let mainStoryboardName = "Main"
    
    static var main: UIStoryboard {
        get {
            return UIStoryboard(name: mainStoryboardName, bundle: nil)
        }
    }
}

extension Date {
    func isEqual(to anotherDate: Date?) -> Bool {
        
        guard let date = anotherDate else {
            return false
        }
        
        let order = NSCalendar.current.compare(self, to: date, toGranularity: .day)
        
        switch order {
        case .orderedSame:
            return true
        default:
            return false
        }
    }
    
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    var weekDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
    
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self).capitalized
    }
}

extension String {
    static var uuid: String {
        get {
            return NSUUID().uuidString
        }
    }
    
    var addingSpaceIfHasOnlyOneCharacter: String {
        get {
            if self.characters.count > 1 {
                return self
            } else {
                return " \(self)"
            }
        }
    }
}
