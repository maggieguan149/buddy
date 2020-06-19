//
//  HabitsViewController.swift
//  buddy
//
//  Created by Maggie Guan on 6/19/20.
//  Copyright © 2020 Maggie Guan. All rights reserved.
//

import UIKit

class HabitsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var habitArray = [Habit]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("habits.plist")

    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "HabitBubble", bundle: .none), forCellReuseIdentifier: "HabitCell")
        
        var habit = Habit()
        habit.name = "sleep plz"
        
        loadData()
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add habit!", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            var newHabit = Habit()
            newHabit.name = textField.text!
            self.habitArray.append(newHabit)
            self.saveData()
        }
        alert.addTextField { (field) in
            field.placeholder = "New Habit"
            textField = field
        }
        alert.addAction(action)
        
        present(alert, animated: true)

    }
    
    @IBAction func nextDayPressed(_ sender: UIButton) {
        let i = habitArray.count - 1
        for n in 0...i {
            if !habitArray[n].done{
                habitArray[n].streak = 0
            }
            habitArray[n].done = false
        }
        saveData()
    }
    
    
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    

    func saveData() {
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(habitArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("error encoding array, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadData() {
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
                habitArray = try decoder.decode([Habit].self, from: data)
            } catch {
                print("error loading data, \(error)")
            }
        }
        tableView.reloadData()
    }

}

//MARK: - Tableview datasource methods

extension HabitsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habitArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let habit = habitArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HabitCell", for: indexPath) as! HabitBubble
        cell.habitLabel?.text = habit.name
        if habit.done {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.streakLabel.text = "Streak: \(habit.streak)"
        return cell
    }
    

}

//MARK: - Tableview delegate methods

extension HabitsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if habitArray[indexPath.row].done{
            habitArray[indexPath.row].done = false
            habitArray[indexPath.row].streak -= 1
        } else {
            habitArray[indexPath.row].done = true
            habitArray[indexPath.row].streak += 1
        }
        saveData()
    }
    
    //the heck that actually worked :0
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            habitArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}
