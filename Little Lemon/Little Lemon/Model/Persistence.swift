import CoreData
import Foundation

class PersistenceController {
    static let shared = PersistenceController()

    private var container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "LittleLemon")
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    
    func load() async throws {
        try await prepareContainer()
        await prepareContext()
    }
    
    func prepareContainer() async throws {
        return try await withCheckedThrowingContinuation { cont in
            container.loadPersistentStores(completionHandler: { _, error in
                if let error {
                    cont.resume(throwing: error)
                } else {
                    cont.resume()
                }
            })
        }
    }
    
    @MainActor
    func prepareContext() async {
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func clear() {
        // Delete all dishes from the store
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Dish")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let _ = try? container.persistentStoreCoordinator.execute(deleteRequest, with: container.viewContext)
    }
    
    var viewContext: NSManagedObjectContext { container.viewContext }
    func backgroundContext() -> NSManagedObjectContext { container.newBackgroundContext() }
}
