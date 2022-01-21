//
//  CachedPerson+CoreDataProperties.swift
//  FriendFace
//
//  Created by Aditya Narayan Swami on 18/01/22.
//
//

import Foundation
import CoreData


extension CachedPerson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedPerson> {
        return NSFetchRequest<CachedPerson>(entityName: "CachedPerson")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var friends: NSSet?
    public var wrappedId: String{
        id ?? "unknown ID"
    }
    public var wrappedName: String{
        name ?? "unknown Name"
    }
    public var wrappedCompany: String{
        company ?? "Unkwown Company"
    }
    public var wrappedEmail: String{
        email ?? "unknown email"
    }
    public var wrappedAddress: String{
        address ?? "Unknown Address"
    }
    public var wrappedAbout: String{
        about ?? "Unknown About"
    }
    public var friendsArray: [CachedFriend]{
        let set = friends as? Set<CachedFriend> ?? []
        return set.sorted{
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for friends
extension CachedPerson {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedPerson : Identifiable {

}
