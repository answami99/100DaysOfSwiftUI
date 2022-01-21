//
//  AddNewBook.swift
//  BookWorm
//
//  Created by Aditya Narayan Swami on 29/12/21.
//

import SwiftUI

struct AddNewBook: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var review = ""
    @State private var rating = 1
    @State private var genre = "Unknown"
    
    var saveButton: Bool{
        if title.isEmpty || author.isEmpty || review.isEmpty || genre == "Unknown"{
            return false
        }else{
            return true
        }
    }
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Title of the Book", text: $title)
                        .disableAutocorrection(true)
                    TextField("Name of the Author", text: $author)
                        .disableAutocorrection(true)
                    Picker("Genre", selection: $genre){
                        ForEach(genres, id: \.self){
                            Text($0)
                        }
                    }
                }
                Section{
                    TextEditor(text: $review)
                        .disableAutocorrection(true)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                Section{
                    Button("Save"){
                        let newBook = Book(context: moc)
                        newBook.title = title
                        newBook.author = author
                        newBook.genre = genre
                        newBook.id = UUID()
                        newBook.review = review
                        newBook.rating = Int16(rating)
                        newBook.date = String(Date.now.formatted(date: .abbreviated, time: .omitted))
                        try? moc.save()
                        dismiss()
                    }
                }
                .disabled(!saveButton)
            }
            .navigationTitle("Add New Book")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddNewBook_Previews: PreviewProvider {
    static var previews: some View {
        AddNewBook()
    }
}
