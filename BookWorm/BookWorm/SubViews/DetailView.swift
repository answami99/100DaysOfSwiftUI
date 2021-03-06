//
//  DetailView.swift
//  BookWorm
//
//  Created by Aditya Narayan Swami on 30/12/21.
//

import SwiftUI
import CoreData
struct DetailView: View {
    let book: Book
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showAlert = false
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                ZStack(alignment: .bottomTrailing){
                    Image(book.genre ?? "Fantasy")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding()
                        .shadow(radius: 5)
                    Text(book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(.black.opacity(0.75))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .offset(x: -5, y: -5)
                }
                Text("Added on: \(book.date ?? "UnKnown")")
                    .font(.caption)
                Text(book.author ?? "unKnown")
                    .font(.title)
                    .foregroundColor(.secondary)
                Text(book.review ?? "unKnown")
                    .padding()
                    .frame(maxWidth: geo.size.width - 30)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 2)
                RatingView(rating: .constant(Int(book.rating)))
                    .font(.largeTitle)
            }
        }
        .alert("Delete Book", isPresented: $showAlert){
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {}
        } message:{
            Text("Are you sure")
        }
        .toolbar{
            Button{
                showAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
        .navigationTitle(book.title ?? "Unknown")
        .navigationBarTitleDisplayMode(.inline)
    }
    func deleteBook(){
        moc.delete(book)
        try? moc.save()
        dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."

        return NavigationView {
            DetailView(book: book)
        }
    }
}
