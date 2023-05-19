//
//  ActivityViewController.swift
//  TravelHelper
//
//  Created by Qin Geng on 5/10/23.
//

import UIKit

class ActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var store: ActivityStore = CoreDataActivityStore()

    var activities: [Activity] = []
    
    // Lazy instantiation: A lazy property will get created the first time it is accessed. And only once.
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    

    @IBOutlet weak var tableView: UITableView!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // A segue is the transition between two controllers. In this case, is the one between the one with the table, and the one with the menu for adding a task
        if segue.identifier == "AddActivity" {
            print("AddActivity found!!!")
            let vc = segue.destination as! AddActivityViewController
            vc.newActivityCreated = { newActivity in
                self.activities.append(newActivity)
                self.store.save(activity: newActivity)
                self.store.update(activity: newActivity)
                self.fetchAndReloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        activities = store.fetchActivity()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "taskCell")
    }

    // MARK: - UITableViewDelegate implementation - this implements what happens when click on the cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var task = activities[indexPath.row]
        task.isDone = !task.isDone
        activities[indexPath.row] = task
        store.update(activity: task)
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    // MARK: - UITableViewDataSource implementation - this implements how each cell looks like
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        let task = activities[indexPath.row]
        
        let displayString = "\(dateFormatter.string(from: task.date)): \(task.title)"
        cell.textLabel?.text = displayString
        if task.isDone {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    // MARK: - This decides how many rows will be displayed
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    // MARK: - This decides the deletion of the cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = activities[indexPath.row]
            store.delete(activity: task)
            activities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func fetchAndReloadData() {
        activities = store.fetchActivity()
        tableView.reloadData()
    }

}

