//
//  ToDoTableViewController.swift
//  ToDo App
//
//  Created by Egor on 02.02.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit
import CoreData

class ToDoTableViewController: UITableViewController, AddViewControllerDelegate {
    
    let coreDataManager: CoreDataManager = CoreDataManager()
    
    var notes: [NSManagedObject] = []
    
    override func viewWillAppear(_  animated: Bool) {
        super.viewWillAppear(animated)
        if let recivedNotes = coreDataManager.loadSavedNotes(entityName: "Note"){
            self.notes = recivedNotes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        
        cell.textLabel?.text = notes[indexPath.row].value(forKey: "text") as? String
        return cell
    }
    
    // deleting and checking notes
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        /*let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            completion(true)
        }*/
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            completion(true)
            
            let index = indexPath.row
            self.coreDataManager.deletNote(note: self.notes[index])
            self.notes.remove(at: index)
            self.tableView.reloadData()
            
        }
        action.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    /*
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
            completion(true)
        }
        action.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [action])
    }*/
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let checkBarBtn = sender as? UIBarButtonItem, segue.identifier == "showAddView"{
            let vc = segue.destination as! AddViewController
            vc.delegate = self
        }
    }
    
    func saveNote(text: String) {
        if let savedNote = coreDataManager.saveNote(noteText: text, to: "Note"){
            self.notes.append(savedNote)
            tableView.reloadData()
        }
    }
}
