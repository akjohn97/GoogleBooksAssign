

import Foundation
import CoreData

final class CoreManager{
    
    static let shared = CoreManager()
    private init(){}
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GoogleBooksAssessment")
        
        container.loadPersistentStores{ (storedDescrip, err) in
            if let error = err {
                fatalError(error.localizedDescription)
            }
            
        }
        return container
    }()
    
    
    //MARK: Save
    func save(_ book: Book){
        let entity = NSEntityDescription.entity(forEntityName: "CoreBook", in: context)!
        let coreBook = CoreBook(entity: entity, insertInto: context)
        
        coreBook.author = book.author
        coreBook.uid = book.id
        coreBook.title = book.title
        coreBook.published = book.published
        coreBook.pageCount = Int64(book.pageCount)
        coreBook.udescription = book.description
        coreBook.cover = book.cover
        
        saveContext()
        
        print("Saved Book: \(book.title)")
        
    }
    
    //MARK: Load
    
    func load() -> [Book] {
        
        let fetch = NSFetchRequest<CoreBook>(entityName: "CoreBook")
        var books = [Book]()
        
        do {
            let coreBooks = try context.fetch(fetch)
            for core in coreBooks {
                let book = Book(core)
                books.append(book)
            }
        } catch {
            print("Couldn't fetch tracks: \(error.localizedDescription)")
        }
        return books
    }
    
    
    //MARK: Helper
    func saveContext() {
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    
}
