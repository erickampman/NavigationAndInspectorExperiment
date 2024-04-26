//
//  NavigationMainView.swift
//  NavigationAndInspectorExperiment
//
//  Created by Eric Kampman on 4/26/24.
//

import SwiftUI

struct NavigationMainView: View {
	@State var library = Library.setData()
	@State private var navigationPath = NavigationPath()

    var body: some View {
		NavigationSplitView {
			VStack(alignment: .leading) {
				Text(library.id)
					.font(.title2)
				NavigationLink("Books", value: library.books)
					.navigationDestination(for: [Book].self) { book in
						BookListView(library: library, navigationPath: $navigationPath)
					}

//				.navigationDestination(for: Book.self) { book in
//					BookView(book: book, navigationPath: $navigationPath)
//				}
//				.navigationDestination(for: Author.self) { author in
//					AuthorView(author: author, navigationPath: $navigationPath)
//				}
			}
			.padding([.bottom], 10)
			
//			VStack(alignment: .leading) {
//				Text("Authors")
//					.font(.title2)
//				List(library.authors) { author in
//					NavigationLink(author.id, value: author)
//				}
//				.navigationDestination(for: Author.self) { author in
//					AuthorView(author: author, navigationPath: $navigationPath)
//				}
//			}
//			.padding([.bottom], 10)
		} detail: {
			Text("Detail View")
		}

    }
}

#Preview {
    NavigationMainView()
}
