//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Aditya Narayan Swami on 27/12/21.
//

import SwiftUI

@main
struct BookWormApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
