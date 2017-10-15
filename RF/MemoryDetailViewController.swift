//
//  MemoryDetailViewController.swift
//  RF
//
//  Created by Nikhil Manapure on 15/10/17.
//  Copyright © 2017 Nikhil Manapure. All rights reserved.
//

import UIKit

protocol MemoryDetailViewControllerDelegate {
    func memoryDetailViewControllerDidSave(memory: Memory)
}

class MemoryDetailViewController: UIViewController {
    
    var memory: Memory?
    var delegate: MemoryDetailViewControllerDelegate?

    @IBOutlet var textView: UITextView!


    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = memory?.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveEditButton(_ sender: UIButton) {
        if let text = textView.text {
            if let memory = memory {
                if memory.update(text: text) {
                    if let delegate = delegate {
                        delegate.memoryDetailViewControllerDidSave(memory: memory)
                    }
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
