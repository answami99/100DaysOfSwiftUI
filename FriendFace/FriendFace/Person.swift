//
//  Person.swift
//  FriendFace
//
//  Created by Aditya Narayan Swami on 14/01/22.
//

import Foundation
struct Friend: Codable, Identifiable{
    let id: String
    let name: String
}
struct Person: Codable, Identifiable{
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let friends: [Friend]
}
