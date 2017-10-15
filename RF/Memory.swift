//
//  Memory.swift
//  RF
//
//  Created by Nikhil Manapure on 14/10/17.
//  Copyright © 2017 Nikhil Manapure. All rights reserved.
//

import UIKit
import RealmSwift


class Memory: Object {
    
    struct Keys {
        static let createdOn = "createdOn"
    }
    
    dynamic var uuid: String = String.uuid
    dynamic var createdOn: Date = Date()
    dynamic var lastUpdatedOn: Date?
    dynamic var text: String = ""
    dynamic var author: User?
    dynamic var emotionalScore: Int = 1
    
    static var all: [Memory] {
        get {
            do {
                let realm = try Realm()
                return Array(realm.objects(Memory.self).sorted(byKeyPath: Keys.createdOn, ascending: false))
            } catch {
                Logger.log(error: error)
            }
            return []
        }
    }
    
    static func memories(forUser user: User, forDate date: Date) -> [Memory] {
        do {
            let realm = try Realm()
            return realm.objects(Memory.self).filter({ $0.createdOn.isEqual(to: date) && $0.author == user }).sorted(by: { (first, second) -> Bool in
                first.createdOn == second.createdOn
            })
        } catch {
            Logger.log(error: error)
        }
        return []
    }
    
    static func memories(forUser user: User) -> [Memory] {
        do {
            let realm = try Realm()
            return realm.objects(Memory.self).filter({ $0.author == user }).sorted(by: { (first, second) -> Bool in
                first.createdOn == second.createdOn
            })
        } catch {
            Logger.log(error: error)
        }
        return []
    }
    
    func update(text: String? = nil) -> Bool {
        do {
            let realm = try Realm()
            try realm.write() {
                
                if let text = text {
                    if self.text != text {
                        self.text = text
                    }
                }
                
                lastUpdatedOn = Date()
                
                realm.add(self, update: true)
            }
            return true
        } catch {
            Logger.log(error: error)
        }
        return false
    }
    
    func delete() {
        do {
            let realm = try Realm()
            try realm.write() {
                realm.delete(self)
            }
        } catch {
            Logger.log(error: error)
        }
    }
    
    override static func ignoredProperties() -> [String] {
        return [""]
    }
    
    override class func primaryKey() -> String? {
        return "uuid"
    }
}
