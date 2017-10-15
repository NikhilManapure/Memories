//
//  MainViewController.swift
//  RF
//
//  Created by Nikhil Manapure on 14/10/17.
//  Copyright © 2017 Nikhil Manapure. All rights reserved.
//

import UIKit
import FSCalendar

class MainViewController: UIViewController {
    
    @IBOutlet var calender: FSCalendar!
    @IBOutlet var memoriesTableView: UITableView!
    @IBOutlet var calenderHeight: NSLayoutConstraint!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var weekDayLabel: UILabel!
    @IBOutlet var monthYearLabel: UILabel!

    var user: User? = {
        if let user = User.current {
            return user
        }
        let user = User()
        let _ = user.update(name: "Nikhil")
        return user
    }()
    
    var memories: [Memory] = []
    var shouldLoadMemoriesForcibly = true
    var calenderWeekScopeHeight: CGFloat = 0.0

    static func instanceFromStoryboard(withUser user: User) -> MainViewController {
        let identifier = "\(MainViewController.self)"
        let mainViewController = UIStoryboard.main.instantiateViewController(withIdentifier: identifier) as! MainViewController
        mainViewController.user = user
        return mainViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: MemoryCell.nibName, bundle:nil)
        memoriesTableView.register(nib, forCellReuseIdentifier: MemoryCell.identifier)
        calender.setScope(.week, animated: false)
        calender.select(Date())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if shouldLoadMemoriesForcibly {
            loadMemories()
            shouldLoadMemoriesForcibly = false
        } else if !Date().isEqual(to: calender.selectedDate) {
            loadMemories()
        }
        calenderHeight.constant = 0.0
        view.layoutIfNeeded()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToMemoryDetailViewController", let destination = segue.destination as? MemoryDetailViewController, let memory = sender as? Memory {
            destination.memory = memory
            destination.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadMemories() {
        guard let user = user else {
            return
        }
        memories = Memory.memories(forUser: user, forDate: calender.selectedDate)
        memoriesTableView.reloadData()
        setupTopView(forDate: calender.selectedDate)
    }
    
    func setupTopView(forDate date: Date) {
        dayLabel.text = "\(date.day)".addingSpaceIfHasOnlyOneCharacter
        weekDayLabel.text = "\(date.weekDay)"
        monthYearLabel.text = "\(date.month) \(date.year)"
    }
    
    @IBAction func addButtonTouched(_ sender: UIButton) {
        let newMemory = Memory()
        newMemory.author = user
        newMemory.createdOn = calender.selectedDate
        performSegue(withIdentifier: "ToMemoryDetailViewController", sender: newMemory)
    }
    
    @IBAction func dateButtonTouched(_ sender: UIButton) {
        if calenderHeight.constant == 0.0 {
            calenderHeight.constant = calenderWeekScopeHeight
        } else {
            calenderHeight.constant = 0.0
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}


extension MainViewController: MemoryDetailViewControllerDelegate {
    func memoryDetailViewControllerDidSave(memory: Memory) {
        loadMemories()
    }
}


extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MemoryCell.identifier, for: indexPath as IndexPath) as? MemoryCell {
            let memory = memories[indexPath.row]
            cell.configure(for: memory)
            return cell
        }
        return UITableViewCell()
    }
}


extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToMemoryDetailViewController", sender: memories[indexPath.row])
    }
}


extension MainViewController: FSCalendarDataSource {
    
}


extension MainViewController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        loadMemories()
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calenderHeight.constant = bounds.size.height
        calenderWeekScopeHeight = bounds.size.height
        view.layoutIfNeeded()
    }
}
