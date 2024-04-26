//
//  BookListView.swift
//  NavigationAndInspectorExperiment
//
//  Created by Eric Kampman on 4/26/24.
//

import SwiftUI

struct BookListView: View {
	@Bindable var library: Library
	@Binding var navigationPath: NavigationPath
	@State private var selection = Book?.none
	@State private var inspecting = false
	@State private var showingAddBook = false
    var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Text("Books")
					.font(.title2)
				Button("Add Book") {
					showingAddBook.toggle()
				}
			}
			List(library.books, id: \.self, selection: $selection) { book in
				Text(book.title)
			}
			.onChange(of: selection) {
				inspecting = selection != nil
			}
		}
		.inspector(isPresented: $inspecting) {
			if (selection == nil) {
				EmptyView()
			} else {
				BookView(book: selection!, navigationPath: $navigationPath)
			}
		}
		.toolbar {
		}
		.sheet(isPresented: $showingAddBook) {
			AddBookView(library: library, showingAddBook: $showingAddBook)
		}

    }
}

#Preview {
	@State var library = Library.setData()
	@State var navigationPath = NavigationPath()

    return BookListView(library: library, navigationPath: $navigationPath)
}
