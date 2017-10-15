//
//  LoginViewController.swift
//  RF
//
//  Created by Nikhil Manapure on 14/10/17.
//  Copyright © 2017 Nikhil Manapure. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    static var identifier: String {
        get {
            return "\(LoginViewController.self)"
        }
    }
    
    static var instanceFromStoryboard: LoginViewController {
        return UIStoryboard.main.instantiateViewController(withIdentifier: identifier) as! LoginViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
