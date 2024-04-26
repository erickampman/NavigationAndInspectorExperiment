//
//  AddBookView.swift
//  NavigationAndInspectorExperiment
//
//  Created by Eric Kampman on 4/26/24.
//

import SwiftUI

struct AddBookView: View {
	@Bindable var library: Library
	@Binding var showingAddBook: Bool
	@State private var tempBook = Book(title: "", authorFirst: "", authorLast: "")

    var body: some View {
		VStack {
			TextField("Book Title", text: $tempBook.title)
			TextField("Author First Name", text: $tempBook.author.firstName)
			TextField("Author Last Name", text: $tempBook.author.lastName)
		}
		HStack {
			Button("Add") {
				if let author = library.findAuthor(first: tempBook.author.firstName, last: tempBook.author.lastName) {
					let newBook = Book(title: tempBook.title, author: author)
					library.books.append(newBook)
				} else {
					library.authors.append(tempBook.author)
					library.books.append(tempBook)
				}
				showingAddBook.toggle()
			}
			Button("Cancel") {
				showingAddBook.toggle()
			}

		}
    }
}

#Preview {
	@State var showingAddBook = false
	@State var library = Library.setData()
	return AddBookView(library: library, showingAddBook: $showingAddBook)
}
