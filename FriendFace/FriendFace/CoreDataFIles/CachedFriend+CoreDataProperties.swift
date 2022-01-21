//
//  CachedFriend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Aditya Narayan Swami on 18/01/22.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var person: CachedPerson?
    public var wrappedId: String{
        id ?? "Unknown Friend id"
    }
    public var wrappedName: String{
        name ?? "Unknown Friend Name"
    }

}

extension CachedFriend : Identifiable {

}
