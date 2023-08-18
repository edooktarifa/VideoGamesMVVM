//
//  CoreDataHelper.swift
//  RAWGVideoGames
//
//  Created by Phincon on 17/08/23.
//

import Foundation
import CoreData
import UIKit

struct VideoGameData {
    var rating: String?
    var released: String?
    var title: String?
    var videoImg: Data?
    var desc: String?
    var play: String?
}

class CoreDataManager {
    
    //1
    static let sharedManager = CoreDataManager()
    private init() {} // Prevent clients from creating another instance.
    
    //2
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "RAWGVideoGames")
        
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //3
    func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    /*Insert*/
    func insertVideoDetail(data: VideoGameData)-> VideoGames? {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "VideoGames",
                                                in: managedContext)!
        
        let videoGame = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        videoGame.setValue(data.released, forKey: "released")
        videoGame.setValue(data.rating, forKey: "rating")
        videoGame.setValue(data.title, forKey: "title")
        videoGame.setValue(data.videoImg, forKey: "videoImg")
        videoGame.setValue(data.desc, forKey: "desc")
        videoGame.setValue(data.play, forKey: "playerPlay")
        do {
            try managedContext.save()
            return videoGame as? VideoGames
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    
    func fetchAllVideoGames() -> [VideoGames]? {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "VideoGames")
        
        do {
            let people = try managedContext.fetch(fetchRequest)
            return people as? [VideoGames]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func delete(title: String) -> [VideoGames]? {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        /*init fetch request*/
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "VideoGames")
        fetchRequest.predicate = NSPredicate(format: "title == %@" ,title)
        do {
            
            let item = try managedContext.fetch(fetchRequest)
            var arrRemovedPeople = [VideoGames]()
            for i in item {
                managedContext.delete(i)
                try managedContext.save()
                
                arrRemovedPeople.append(i as! VideoGames)
            }
            return arrRemovedPeople
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
        
    }
}
