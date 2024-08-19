//
//  DetailView.swift
//  Bookworm
//
//  Created by Joe Harrison on 2024-08-19.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                Text(book.genre.uppercased())
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.5))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            Text(book.review)
                .padding()
            
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete Book", isPresented: $showingDeleteAlert)
        {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel){}
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button("Delete this book", systemImage: "Trash"){
                showingDeleteAlert = true
            }
        }
    }
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
    
}

#Preview {
    //make a fake book
    do {
        //config and container need to be made to handle swiftdata
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Lord of the Rings",
                           author: "J. R. R. Tolkien",
                           genre:"Fantasy",
                           review:"J.R.R. Tolkien's 'Lord of the Rings' is one of the few books that I enjoy reading and rereading. It's become a yearly ritual for me. The story is of unparalleled depth, and could get very slow at times (especially in the chapter titled \"The Council of Elrond\") but is overall just great. Reading \"The Hobbit\" before this book is essential. Of course, you probably know all this already from other reviews or word of mouth. The real decision is not whether to buy the book or not, it is which edition to buy, among the numerous paperback and hardcover ones available.",
                           rating: 5)
        
        return DetailView(book: example)
            .modelContainer(container)
    }
    catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
