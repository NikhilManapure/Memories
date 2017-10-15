//
//  User.swift
//  RF
//
//  Created by Nikhil Manapure on 14/10/17.
//  Copyright © 2017 Nikhil Manapure. All rights reserved.
//

import UIKit
import RealmSwift


enum UserType: Int {
    case firstTimer
    case loggedIn
    case skippedLoggingIn
    case loggedOut
    
    init(index: Int) {
        switch index {
        case 0:
            self = .firstTimer
        case 0:
            self = .loggedIn
        case 0:
            self = .skippedLoggingIn
        case 0:
            self = .loggedOut
        default:
            self = .firstTimer
        }
    }
    
    var index : Int {
        get {
            return rawValue
        }
    }
}


class User: Object {
    
    struct Keys {
        static let createdOn = "createdOn"
    }
    
    dynamic var uuid: String = String.uuid
    dynamic var name: String = ""
    dynamic var createdOn: Date = Date()
    dynamic var isCurrent: Bool = true
    private dynamic var _userType: Int = UserType.firstTimer.index
    
    
    var userType: UserType {
        set {
            _userType = newValue.index
        }
        get {
            return UserType(index: _userType)
        }
    }
    
    static var all: [User] {
        get {
            do {
                let realm = try Realm()
                return Array(realm.objects(User.self).sorted(byKeyPath: Keys.createdOn, ascending: false))
            } catch {
                Logger.log(error: error)
            }
            return []
        }
    }
    
    static var current: User? {
        get {
            do {
                let realm = try Realm()
                return realm.objects(User.self).sorted(byKeyPath: "createdOn", ascending: false).first(where: { $0.isCurrent })
            } catch {
                Logger.log(error: error)
            }
            return nil
        }
    }
    
    func update(name: String? = nil) -> Bool {
        do {
            let realm = try Realm()
            try realm.write() {
                
                if let name = name {
                    if self.name != name {
                        self.name = name
                    }
                }
                
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
        return ["userType"]
    }
    
    override class func primaryKey() -> String? {
        return "uuid"
    }
}
