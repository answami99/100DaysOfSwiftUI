//
//  DataController.swift
//  FriendFace
//
//  Created by Aditya Narayan Swami on 18/01/22.
//

import Foundation
import CoreData
class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "DataModel")
    init(){
        container.loadPersistentStores{ description, error in
            if let error = error{
                print("We caught an error \(error.localizedDescription)")
                return
            }
        }
    }
}
