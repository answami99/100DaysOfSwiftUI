//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Aditya Narayan Swami on 14/01/22.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    @State var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
