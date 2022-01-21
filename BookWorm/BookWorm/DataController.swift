//
//  DataController.swift
//  BookWorm
//
//  Created by Aditya Narayan Swami on 29/12/21.
//

import Foundation
import CoreData

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "Bookworm")
    init(){
        container.loadPersistentStores{ description, error in
            if let error = error{
                print("Failed to load data due to \(error.localizedDescription)")
            }
        }
    }
}
