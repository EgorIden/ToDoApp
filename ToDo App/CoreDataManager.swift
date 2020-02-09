//
//  CoreDataManager.swift
//  ToDo App
//
//  Created by Egor on 05.02.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    func loadSavedNotes(entityName: String) -> [NSManagedObject]?{
        
        var savedNotes: [NSManagedObject] = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Error with load notes")
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            savedNotes = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return savedNotes
    }
    
    func saveNote(noteText text: String, to entityName: String) -> NSManagedObject?{
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Error with Save Note")
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
        
        let savedNote = NSManagedObject(entity: entity, insertInto: managedContext)
        
        savedNote.setValue(text, forKeyPath: "text")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return savedNote
    }
    
    func deletNote(note: NSManagedObject) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.delete(note)
        
    }
    
}
