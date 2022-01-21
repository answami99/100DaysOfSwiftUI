//  ContentView.swift
//  FriendFace
//
//  Created by Aditya Narayan Swami on 14/01/22.
//

import SwiftUI
class PersonClass: ObservableObject{
    init(){
        if let savedData = UserDefaults.standard.data(forKey: "PersonData"){
            if let personData = try? JSONDecoder().decode([Person].self, from: savedData){
                persons = personData
                print("Loaded from UserDefaults")
                return
            }
        }
        persons = []
    }
    @Published var persons = [Person]()
}
struct ContentView: View {
    @StateObject var persons = PersonClass()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedPersons: FetchedResults<CachedPerson>
    var body: some View {
        NavigationView{
         
                List{
                    ForEach(cachedPersons){ person in
                        NavigationLink{
                            CoreDataDetailView(person_id: person.wrappedId)
                        } label:{
                            HStack{
                                VStack(alignment: .leading){
                                    Text(person.wrappedName)
                                    Text(person.wrappedCompany)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Text("Active")
                                    .font(.caption)
                                    .overlay{
                                        Circle()
                                            .fill(person.isActive ? .green : .red)
                                            .offset(x: -30)
                                    }
                            }
                        }
                    }
                }
//            .preferredColorScheme(.dark)
            .navigationTitle("FriendFace")
        }
        .task{
            if persons.persons.isEmpty{
                await loadData()
            }
        }
    }
    func loadData() async{
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else{
            print("Failed to load data from link")
            return
        }
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            if let encodedData = try? JSONEncoder().encode(data){
                UserDefaults.standard.set(encodedData, forKey: "PersonData")
            }
            if let savedData = try? JSONDecoder().decode([Person].self, from: data){
                await MainActor.run{
                    for person in savedData{
                        let personObject = CachedPerson(context: moc)
                        personObject.id = person.id
                        personObject.name = person.name
                        personObject.about = person.about
                        personObject.email = person.email
                        personObject.address = person.address
                        personObject.company = person.company
                        personObject.isActive = person.isActive
                        personObject.age = Int16(person.age)
                        for friend in person.friends{
                            let friendObject = CachedFriend(context: moc)
                            friendObject.id = friend.id
                            friendObject.name = friend.name
                            friendObject.person = personObject
                        }
                    }
                    if moc.hasChanges{
                        try? moc.save()
                    }
                    persons.persons = savedData
                }
               
                print("Loaded again")
            }
//            print("Loading successful")
        }catch{
            fatalError("Loading unsuccessful")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
