//
//  DataManager.swift
//  Wtest
//
//  Created by Pedro Del Rio Ortiz on 02/05/22.
//

import Foundation
import CoreData

class DataManager {
    
    static let shared = DataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PostalCodeData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func createPostalCodeCoreDataModel(postalCodeModel: PostalCodeModel) -> PostalCode {
        let postalCode = PostalCode(context: persistentContainer.viewContext)
        postalCode.desigPostal = postalCodeModel.desigPostal
        postalCode.extCodPostal = postalCodeModel.extCodPostal
        postalCode.numCodPostal = postalCodeModel.numCodPostal
        
        return postalCode
    }
    
    func getPostalCodesData() -> [PostalCode] {
        let request: NSFetchRequest<PostalCode> = PostalCode.fetchRequest()
        var fetchedPostalCodes: [PostalCode] = []
        
        do {
            fetchedPostalCodes = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error")
        }
        
        return fetchedPostalCodes
    }
    
    func fetchPostalCodes(searchText: String) -> [PostalCode] {
        var fetchedPostalCodes: [PostalCode] = []
        
        let predicateCode = NSPredicate(format: "numCodPostal contains[cd] '\(searchText)'")
        let predicateExtCode = NSPredicate(format: "extCodPostal contains[cd] '\(searchText)'")
        let predicateName = NSPredicate(format: "desigPostal contains[cd] '\(searchText)'")
        
        let predicateOR = NSCompoundPredicate(type: .or, subpredicates: [predicateCode, predicateExtCode, predicateName])
        
        let fetchRequest: NSFetchRequest<PostalCode> = PostalCode.fetchRequest()
        fetchRequest.predicate = predicateOR
                
        do {
            fetchedPostalCodes = try persistentContainer.viewContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
        
        return fetchedPostalCodes
    }

    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
