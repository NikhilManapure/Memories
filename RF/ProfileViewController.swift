//
//  ProfileViewController.swift
//  RF
//
//  Created by Nikhil Manapure on 15/10/17.
//  Copyright © 2017 Nikhil Manapure. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    static var instanceFromStoryboard: ProfileViewController {
        let identifier = "\(ProfileViewController.self)"
        return UIStoryboard.main.instantiateViewController(withIdentifier: identifier) as! ProfileViewController
    }

    var user: User?
    var memories: [Memory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let user = user else {
            return
        }

        memories = Memory.memories(forUser: user)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
