//
//  Dish+CoreDataProperties.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//
//

public import Foundation
public import CoreData

public typealias DishCoreDataPropertiesSet = NSSet

extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var itemId: Int64
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var image: String?
    @NSManaged public var price: String?
    @NSManaged public var category: String?

}

extension Dish : Identifiable {

}
