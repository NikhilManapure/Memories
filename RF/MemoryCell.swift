//
//  MemoryCell.swift
//  RF
//
//  Created by Nikhil Manapure on 15/10/17.
//  Copyright © 2017 Nikhil Manapure. All rights reserved.
//

import UIKit

class MemoryCell: UITableViewCell {

    var memory: Memory?
    
    @IBOutlet var textView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    }
    
    func configure(for memory: Memory) {
        self.memory = memory
        textView.text = memory.text
    }
}

extension MemoryCell {
    static let nibName = "\(MemoryCell.self)"
    static let identifier = "\(MemoryCell.self)"
}
