//
//  HabitsViewController.swift
//  buddy
//
//  Created by Maggie Guan on 6/19/20.
//  Copyright © 2020 Maggie Guan. All rights reserved.
//

import UIKit
import Firebase

class HabitsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var habitArray = [Habit]()
    var secondArray = [Habit]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("habits.plist")
    let secondFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("second.plist")
    
    var currentEmail = Auth.auth().currentUser?.email
    
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
        
        if currentEmail == "a@b.com"{
            loadData(contentsOf: dataFilePath!)
        } else {
            loadData(contentsOf: secondFilePath!)
        }
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add habit!", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            var newHabit = Habit()
            newHabit.name = textField.text!
            if self.currentEmail == "a@b.com"{
                self.habitArray.append(newHabit)
            } else {
                self.secondArray.append(newHabit)
            }
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
        if currentEmail == "a@b.com"{
            let i = habitArray.count - 1
            for n in 0...i {
                if !habitArray[n].done{
                    habitArray[n].streak = 0
                }
                habitArray[n].done = false
            }
        } else {
            let i = secondArray.count - 1
            for n in 0...i {
                if !secondArray[n].done{
                    secondArray[n].streak = 0
                }
                secondArray[n].done = false
            }
        }
        saveData()
    }
    
    
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
    @IBAction func buddysHabitsClicked(_ sender: UIButton) {
        if currentEmail == "a@b.com"{
            currentEmail = "1@2.com"
            loadData(contentsOf: secondFilePath!)
        } else {
            currentEmail = "a@b.com"
            loadData(contentsOf: dataFilePath!)
        }
    }
    
    
    func saveData() {
        let encoder = PropertyListEncoder()
        do{
            if currentEmail == "a@b.com"{
                let data = try encoder.encode(habitArray)
                try data.write(to: dataFilePath!)
            } else {
                print("in encoding")
                let data = try encoder.encode(secondArray)
                try data.write(to: secondFilePath!)
            }
        } catch {
            print("error encoding array, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadData(contentsOf url: URL) {
        if let data = try? Data(contentsOf: url){
            let decoder = PropertyListDecoder()
            do {
                print("in decoding")
                if currentEmail == "a@b.com"{
                    habitArray = try decoder.decode([Habit].self, from: data)
                } else {
                    secondArray = try decoder.decode([Habit].self, from: data)
                }
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
        if currentEmail == "a@b.com"{
            return habitArray.count
        } else {
            return secondArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var habit = Habit()
        if currentEmail == "a@b.com"{
            habit = habitArray[indexPath.row]
        } else {
            habit = secondArray[indexPath.row]
        }
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
        if currentEmail == "a@b.com"{
            if habitArray[indexPath.row].done{
                habitArray[indexPath.row].done = false
                habitArray[indexPath.row].streak -= 1
            } else {
                habitArray[indexPath.row].done = true
                habitArray[indexPath.row].streak += 1
            }
        } else {
            if secondArray[indexPath.row].done{
                secondArray[indexPath.row].done = false
                secondArray[indexPath.row].streak -= 1
            } else {
                secondArray[indexPath.row].done = true
                secondArray[indexPath.row].streak += 1
            }
        }
        saveData()
    }
    
    //the heck that actually worked :0
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if currentEmail == "a@b.com"{
                habitArray.remove(at: indexPath.row)
            } else {
                secondArray.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
}
