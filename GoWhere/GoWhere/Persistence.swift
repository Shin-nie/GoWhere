//
//  Persistence.swift
//  LoginCoreData
//
//  Created by Hang Vu on 2/10/2024.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            
            //  MARK: OLD CODE
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//            newItem.ursname = "PreviewUser"
            
            //  MARK: NEW CODE
            let newUser = AppUser(context: viewContext)
            newUser.usernames = "PreviewUser"
            newUser.pwd = "PreviewPassword"

        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoreStorage")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // Function to save a user
    func saveUser(username: String, password: String) {
        let newUser = AppUser(context: container.viewContext)
        newUser.usernames = username
        newUser.pwd = password
        
        do {
            try container.viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    // Function to fetch a user by username
    func fetchUser(username: String) -> AppUser? {
        let request: NSFetchRequest<AppUser> = AppUser.fetchRequest()
        request.predicate = NSPredicate(format: "usernames == %@", username)
        
        do {
            let result = try container.viewContext.fetch(request)
            return result.first
        } catch {
            print("Error fetching user: \(error)")
            return nil
        }
    }
    
    // Function to update user's credentials
        func updateUserCredentials(currentUsername: String, newUsername: String, newPassword: String) -> Bool {
            if let user = fetchUser(username: currentUsername) {
                user.usernames = newUsername
                user.pwd = newPassword
                
                do {
                    try container.viewContext.save()
                    return true
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
            return false
        }
}
