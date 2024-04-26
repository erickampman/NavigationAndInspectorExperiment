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
		VStack {
			Text(library.id)
				.font(.title2)
			
			NavigationSplitView {
				VStack(alignment: .leading) {
					NavigationLink("Books", value: library.books)
						.navigationDestination(for: [Book].self) { book in
							BookListView(library: library, navigationPath: $navigationPath)
						}
				}
				.padding([.bottom], 10)
				
				VStack(alignment: .leading) {
					NavigationLink("Authors", value: library.authors)
						.navigationDestination(for: [Author].self) { author in
							AuthorListView(library: library, navigationPath: $navigationPath)
						}
				}
				.padding([.bottom], 10)
			} detail: {
				Text("Detail View")
			}
		}
	}
}

#Preview {
    NavigationMainView()
}
