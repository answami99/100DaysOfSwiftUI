//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Aditya Narayan Swami on 01/01/22.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @State private var dataController = DataController()
    var body: some Scene {
        WindowGroup{
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
