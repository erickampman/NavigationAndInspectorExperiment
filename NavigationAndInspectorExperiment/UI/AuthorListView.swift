//
//  AuthorListView.swift
//  NavigationAndInspectorExperiment
//
//  Created by Eric Kampman on 4/26/24.
//

import SwiftUI

struct AuthorListView: View {
	@Bindable var library: Library
	@Binding var navigationPath: NavigationPath
	@State private var selection = Author?.none
	@State private var inspecting = false
	@State private var showingAddAuthor = false

    var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Text("Authors")
					.font(.title2)
				Button("Add Author", systemImage: "plus") {
					showingAddAuthor.toggle()
				}
			}
			List($library.authors, id: \.self, selection: $selection) { author in
				Text(author.id)
			}
			.onChange(of: selection) {
				inspecting = selection != nil
			}
		}
		.inspector(isPresented: $inspecting) {
			if (selection == nil) {
				EmptyView()
			} else {
				AuthorView(author: selection!, navigationPath: $navigationPath)
			}
		}
		.sheet(isPresented: $showingAddAuthor) {
			AddAuthorView(library: library, showingAddAuthor: $showingAddAuthor)
		}
	}
}

#Preview {
	@State var library = Library.setData()
	@State var navigationPath = NavigationPath()

    return AuthorListView(library: library, navigationPath: $navigationPath)
}
