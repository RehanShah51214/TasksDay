//
//  CoreDataTask+CoreDataProperties.swift
//  TasksDay1
//
//  Created by Rehan Shah on 09/05/2022.
//
//

import Foundation
import CoreData


extension CoreDataTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataTask> {
        return NSFetchRequest<CoreDataTask>(entityName: "CoreDataTask")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: String?
    @NSManaged public var education: String?

}

extension CoreDataTask : Identifiable {

}
