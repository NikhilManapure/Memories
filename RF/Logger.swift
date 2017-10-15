//
//  Logger.swift
//  SwiftLogger
//
//  Created by Sauvik Dolui on 03/05/2017.
//  Copyright © 2016 Innofied Solutions Pvt. Ltd. All rights reserved.
//

import Foundation

enum LogEvent: String {
    case error   = "[‼️]"
    case info    = "[ℹ️]"
    case debug   = "[💬]"
    case time    = "[⏰]"
    case warning = "[⚠️]"
    case severe  = "[🔥]"
}

class Logger {
    class func log(message: String, event: LogEvent, filePath: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        #if DEBUG
            print("\(Date().toString()) \(event.rawValue)[\(fileName(from: filePath))]:\(line) \(column) \(funcName) -> \(message)")
        #endif
    }
    
    class func log(error: Error, event: LogEvent = .severe, filePath: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        #if DEBUG
            print("\(Date().toString()) \(event.rawValue)[\(fileName(from: filePath))]:\(line) \(column) \(funcName) -> \(error.localizedDescription)")
        #endif
    }
    
    private class func fileName(from filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}

internal extension Date {
    private static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
    
    private static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    func toString() -> String {
        return Date.dateFormatter.string(from: self as Date)
    }
}
