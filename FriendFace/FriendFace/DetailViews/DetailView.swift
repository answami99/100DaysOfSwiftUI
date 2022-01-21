//
//  DetailView.swift
//  FriendFace
//
//  Created by Aditya Narayan Swami on 14/01/22.
//

import SwiftUI

struct DetailView: View {
    var person: Person
    @State private var showSheet = false
    @ObservedObject var persons: PersonClass
    var body: some View {
        NavigationView{
            Form{
                Section{
                    HStack{
                        Text("Name")
                            .foregroundColor(.primary)
                        Spacer()
                        Text("\(person.name)")
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
                        Text(person.company)
                            .foregroundColor(.secondary)
                    }
                    HStack{
                        Text("Email")
                            .foregroundColor(.primary)
                        Spacer()
                        Text(person.email)
                            .foregroundColor(.secondary)
                    }
                    HStack{
                        Text("Address")
                            .foregroundColor(.primary)
                        Spacer()
                        Text(person.address)
                            .foregroundColor(.secondary)
                    }
                }
                Section{
                    Text(person.about)
                        .font(.callout)
                } header: {
                    Text("About")
                }
                Section{
                    ForEach(person.friends){ friend in
                        Button{
                            showSheet = true
                        } label:{
                            Text(friend.name)
                        }
                        .sheet(isPresented: $showSheet){
                            VStack{
                                Text(friend.name)
                                Text(friend.id)
                                Text("I will work on this later in future, i couldn't seem to work out friend.id to the actual persons array")
                            }
                        }
                    }
                } header: {
                    Text("Friends")
                }
                
            }
            
            .navigationTitle("\(person.name)'s Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(person: Person(id: "50a48fa3-2c0f-4397-ac50-64da464f9954", isActive: false, name: "Alford Rodriguez", age: 20, company: "Something", email: "alfordrodriguez@imkan.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.",friends: [Friend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Hawkins Patel")]), persons: PersonClass())
    }
}
