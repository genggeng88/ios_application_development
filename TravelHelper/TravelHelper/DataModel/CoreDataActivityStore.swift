//
//  CoreDataActivityStore.swift
//  TravelHelper
//
//  Created by Qin Geng on 5/10/23.
//

import Foundation
import CoreData

protocol ActivityStore {
    func fetchActivity() -> [Activity]
    func save(activity: Activity)
    func delete(activity: Activity)
    func update(activity: Activity)
}

struct CoreDataActivityStore: ActivityStore {
    
    private static var persitentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TravelHelper")
        container.loadPersistentStores { _, error in
            if let error = error {
                // Let the user know?
            }
        }
        return container
    }()
    
    
    func fetchActivity() -> [Activity] {
        let managedContext = CoreDataActivityStore.persitentContainer.viewContext
        let fetchRequest = ActivityEntity.fetchRequest()
        do {
            let activityEntities: [ActivityEntity] = try managedContext.fetch(fetchRequest)
            return activityEntities.compactMap { Activity(entity: $0)}
        } catch {
            return []
        }
    }
    
    func save(activity: Activity) {
        let managedContext = CoreDataActivityStore.persitentContainer.viewContext
        let _ = ActivityEntity(context: managedContext, activity: activity)
        do {
            try managedContext.save()
        } catch { }
    }
    
    func delete(activity: Activity) {
        let managedContext = CoreDataActivityStore.persitentContainer.viewContext
        let fetchRequest = ActivityEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date = %@", activity.date as NSDate)
        do {
            guard let activityEntity = try managedContext.fetch(fetchRequest).first else {
                return
            }
            managedContext.delete(activityEntity)
            try managedContext.save()
        } catch {
            
        }
    }
    
    func update(activity: Activity) {
        let managedContext = CoreDataActivityStore.persitentContainer.viewContext
        let fetchRequest = ActivityEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date = %@", activity.date as NSDate)
        do {
            guard let activityEntity = try managedContext.fetch(fetchRequest).first else {
                return
            }
            activityEntity.title = activity.title
            activityEntity.date = activity.date
            activityEntity.isDone = activity.isDone
            try managedContext.save()
        } catch {
            
        }
    }
}


extension ActivityEntity {
    convenience init(context: NSManagedObjectContext, activity: Activity) {
        self.init(context: context)
        title = activity.title
        date = activity.date
        isDone = activity.isDone
    }
}

