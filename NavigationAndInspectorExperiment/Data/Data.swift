//
//  Data.swift
//  NavigationAndInspectorExperiment
//
//  Created by Eric Kampman on 4/26/24.
//

import Foundation
import Observation

@Observable
class Book: Identifiable, Codable, Hashable {
	static func == (lhs: Book, rhs: Book) -> Bool {
		let left = lhs.title + lhs.author.id
		let right = rhs.title + rhs.author.id
		
		return left == right
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(title)
		hasher.combine(author)
	}

	init(title: String, author: Author) {
		self.title = title
		self.author = author
	}

	init(title: String, authorFirst: String, authorLast: String) {
		self.title = title
		let author = Author(firstName: authorFirst, lastName: authorLast)
		self.author = author
	}

	var title: String
	var author: Author
	
	var id: String {
		String("\(title) by \(author.id)")
	}
}

@Observable
class Author: Identifiable, Codable, Hashable {
	static func == (lhs: Author, rhs: Author) -> Bool {
		return lhs.id == rhs.id
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
	
	var firstName: String
	var lastName: String
	
	var id: String {
		return firstName + " " + lastName
	}
	
	init(firstName: String, lastName: String) {
		self.firstName = firstName
		self.lastName = lastName
	}
}

@Observable
class Library: Identifiable, Codable, Hashable {
	var id = ""
	var authors = [Author]()
	var books = [Book]()
	
	static func == (lhs: Library, rhs: Library) -> Bool {
		lhs.id == rhs.id	// pretty lame. Should check books and authors
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
	
	static func setData() -> Library {
		let library = Library()
		library.id = "My Library"
		
		let timJones = Author(firstName: "Tim", lastName: "Jones")
		let sallyFoo = Author(firstName: "Sally", lastName: "Foo")
		let johnDoe = Author(firstName: "John", lastName: "Doe")
		
		let jonesBook = Book(title: "Jones Book", author: timJones)
		let jonesBook2 = Book(title: "Jones Book II", author: timJones)
		let sallyBook = Book(title: "Sally Forth", author: sallyFoo)
		let sallyBook2 = Book(title: "Sally Fifth", author: sallyFoo)
		let anonymousBook = Book(title: "Anonymous", author: johnDoe)
		
		library.authors.append(timJones)
		library.authors.append(sallyFoo)
		library.authors.append(johnDoe)
		
		library.books.append(jonesBook)
		library.books.append(jonesBook2)
		library.books.append(sallyBook)
		library.books.append(sallyBook2)
		library.books.append(anonymousBook)
		
		return library
	}
	
	func findBook(title: String, authorFirst: String, authorLast: String) -> Book? {
		for book in books {
			if book.title == title &&
				book.author.firstName == authorFirst &&
				book.author.lastName == authorLast
			{
				return book
			}
		}
		return nil
	}
	
	func findAuthor(first: String, last: String) -> Author? {
		for author in authors {
			if author.firstName == first &&
				author.lastName == last
			{
				return author
			}
		}
		return nil
	}
}
