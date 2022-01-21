//
//  ContentView.swift
//  BookWorm
//
//  Created by Aditya Narayan Swami on 27/12/21.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    @State private var showAddScreen = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(books){ book in
                    NavigationLink{
                        DetailView(book: book)
                    } label: {
                        HStack{
                            EmojiView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading){
                                Text(book.title ?? "unKnown")
                                    .font(.headline)
                                    .foregroundColor(book.rating == Int16(1) ? Color.red : Color.primary)
                                Text(book.author ?? "unKnown")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBook)
            }
            .navigationTitle("BookWorm")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        showAddScreen.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddScreen){
                AddNewBook()
                
            }
        }
    }
    func deleteBook(at offsets: IndexSet){
        for offset in offsets{
            let book = books[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
