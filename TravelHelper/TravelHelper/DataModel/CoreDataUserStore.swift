//
//  CoreDataUserStore.swift
//  TravelHelper
//
//  Created by Qin Geng on 5/19/23.
//

import Foundation
import CoreData

struct CoreDataUserStore {
    
    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TravelHelper")
        container.loadPersistentStores { _, error in
            if let error = error {
                // Let the user know?
                print("Failed to load Core Data stack: \(error)")
            }
        }
        return container
    }()
    
    
    func fetchUser() -> ProfileEntity? {
        let managedContext = CoreDataUserStore.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ProfileEntity> = ProfileEntity.fetchRequest()
        fetchRequest.fetchLimit = 1
        do {
            let profileEntities: [ProfileEntity] = try managedContext.fetch(fetchRequest)
            return profileEntities.first
        } catch {
            print("Failed to fetch user: \(error)")
            return nil
        }
    }
    
    func save(user: User, name: String, bio: String) {
        print("CoreDataUserStore.save() is called in the CoreDataUserStore file")
        let managedContext = CoreDataUserStore.persistentContainer.viewContext
            
        if let profileEntity = fetchUser() {
            // Update existing profile entity
            profileEntity.name = name
            profileEntity.bio = bio
            print("Fetched a profileEntity in CoreDataUserStore file")
        } else {
            // Create new profile entity
            let profileEntity = ProfileEntity(context: managedContext)
            profileEntity.name = name
            profileEntity.bio = bio
            profileEntity.date = Date() // Set the current date
            print("Create a new profileEntity in CoreDataUserStore file")
        }
            
        do {
            try managedContext.save()
            print("Saved the new profileEntity in CoreDataUserStore file")
        } catch {
            print("Failed to save user: \(error)")
        }
    }
}

extension ProfileEntity {
    convenience init(context: NSManagedObjectContext, user: User) {
        self.init(context: context)
        name = user.name
        bio = user.bio
        date = user.date
    }
}

