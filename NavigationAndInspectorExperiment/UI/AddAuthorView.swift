//
//  AddAuthorView.swift
//  NavigationAndInspectorExperiment
//
//  Created by Eric Kampman on 4/26/24.
//

import SwiftUI

struct AddAuthorView: View {
	@Bindable var library: Library
	@Binding var showingAddAuthor: Bool
	@State private var tempAuthor = Author(firstName: "", lastName: "")

    var body: some View {
		VStack {
			TextField("First Name", text: $tempAuthor.firstName)
			TextField("Last Name", text: $tempAuthor.lastName)
		}
		HStack {
			Button("Add") {
				if let _ = library.findAuthor(first: tempAuthor.lastName, last: tempAuthor.lastName) {
					// already present -- HUD?
				} else {
					library.authors.append(tempAuthor)
				}
				showingAddAuthor.toggle()
			}
			Button("Cancel") {
				showingAddAuthor.toggle()
			}
		}
    }
}

#Preview {
	@State var showingAddAuthor = false
	@State var library = Library.setData()

	return AddAuthorView(library: library, showingAddAuthor: $showingAddAuthor)
}
