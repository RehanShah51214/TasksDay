//
//  Database.swift
//  TasksDay1
//
//  Created by Rehan Shah on 09/05/2022.
//

import Foundation
import CoreData
import UIKit


class Database
{
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    static var shareinstance = Database()
    
    //MARK:- SAVE DATA
    
    func Save(object: [String: String])
    {
        
        let Data = NSEntityDescription.insertNewObject(forEntityName: "CoreDataTask", into: context!) as! CoreDataTask
        Data.name = object["name"]
        Data.date = object["date"]
        Data.education = object["education"]
        
        
        do
                {
                    try self.context!.save()
                    print("Data Saved")
                }
        catch
        {
            print("error")
        }
        
    }
    
    //MARK:- Fetch Data
    
    func GetData() -> [CoreDataTask]
    {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataTask")
        var resultsArr:[CoreDataTask] = []
        do {
            resultsArr = try (context!.fetch(fetchRequest) as! [CoreDataTask])
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return resultsArr
    }
    
    func DeleteAllData(){


        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataTask"))
        do {
            try managedContext.execute(DelAllReqVar)
            print("Deleted")
        }
        catch {
            print(error)
        }
    }
    
    
}
