//
//  OnboardingViewController.swift
//  RF
//
//  Created by Nikhil Manapure on 14/10/17.
//  Copyright © 2017 Nikhil Manapure. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    static var identifier: String {
        get {
            return "\(OnboardingViewController.self)"
        }
    }
    
    static var instanceFromStoryboard: OnboardingViewController {
        return UIStoryboard.main.instantiateViewController(withIdentifier: identifier) as! OnboardingViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gotoLogin() {
        //
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
