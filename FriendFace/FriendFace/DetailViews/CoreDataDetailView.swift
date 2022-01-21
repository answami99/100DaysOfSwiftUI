//
//  DetailView.swift
//  FriendFace
//
//  Created by Aditya Narayan Swami on 14/01/22.
//

import SwiftUI
import CoreData
struct CoreDataDetailView: View {
    @State private var showSheet = false
    @FetchRequest var person: FetchedResults<CachedPerson>
    init(person_id: String){
        _person = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "id == %@", person_id))
    }
    var body: some View {
//        NavigationView{
            ForEach(person){ person in
                Form{
                    Section{
                        HStack{
                            Text("Name")
                                .foregroundColor(.primary)
                            Spacer()
                            Text(person.wrappedName)
                                .foregroundColor(.secondary)
                        }
                        HStack{
                            Text("Age")
                                .foregroundColor(.primary)
                            Spacer()
                            Text("\(person.age)")
                                .foregroundColor(.secondary)
                        }
                        HStack{
                            Text("Company")
                                .foregroundColor(.primary)
                            Spacer()
                            Text(person.wrappedCompany)
                                .foregroundColor(.secondary)
                        }
                        HStack{
                            Text("Email")
                                .foregroundColor(.primary)
                            Spacer()
                            Text(person.wrappedEmail)
                                .foregroundColor(.secondary)
                        }
                        HStack{
                            Text("Address")
                                .foregroundColor(.primary)
                            Spacer()
                            Text(person.wrappedAddress)
                                .foregroundColor(.secondary)
                        }
                    } header:{
                        Text("Personal Info")
                    }
                    Section{
                        Text(person.wrappedAbout)
                            .font(.callout)
                    } header: {
                        Text("About")
                    }
                    Section{
                        ForEach(person.friendsArray, id:\.self){ friend in
                            Button{
                                showSheet = true
                            } label: {
                                Text(friend.wrappedName)
                            }
                            .sheet(isPresented: $showSheet){
                                FriendDetailView(friend_id: friend.wrappedId)
                            }
                        }
                    } header: {
                        Text("Friends")
                    }
                }
                
                .navigationTitle("\(person.wrappedName)'s Profile")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CoreDataDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataDetailView(person_id: "")
    }
}
