//
//  ContentView.swift
//  WatchReader WatchKit Extension
//
//  Created by Hanh Vu on 2022/08/18.
//

import SwiftUI

struct BookRes: Codable {
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case id = "key"
        case imageKey = "cover_edition_key"
        case author = "author_name"
    }
    
    var id: String
    var title: String
    var imageKey: String?
    var author: [String]?
}

struct SearchRes: Codable {
    var docs: [BookRes]
}

enum status {
    case reading
    case read
    case abandoned
}

struct Book {
    let id: String
    let title: String
    let author: [String]
    let imageKey: String
    var status: status
    var rating: Int?
}

struct ContentView: View {
    @State var bookList: [Book] = []
    @State private var showSearch: Bool = false
    
    var body: some View {
        BookListView(bookList: $bookList)
            .sheet(isPresented: $showSearch) {
                SearchView(bookList: $bookList, showSearch: $showSearch)
            }
            .navigationTitle("WatchReader")
            .toolbar{
                Button(role: .none) {
                    showSearch.toggle()
                } label: {
                    Label("Add book", systemImage: "plus")
                }
            }
    }
}

struct DetailView: View {
    @Binding var book: Book
    @Binding var showDetail: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://covers.openlibrary.org/b/olid/\(book.imageKey)-L.jpg"))  { image in
                    image
                        .resizable()
                        .scaledToFit()
                    } placeholder: {
                        Color.secondary
                    }
                    .frame(maxWidth: 60, maxHeight: 120, alignment: .leading)
                Text("\(book.title)")
                    .font(.custom("Baskerville", size: 20, relativeTo: .headline))
                    .frame(alignment: .leading)
                ForEach(book.author, id: \.self) { author in
                    Text("\(author) ")
                        
                }
                .font(.custom("Baskerville", size: 16, relativeTo: .subheadline))
                RatingView(rating: $book.rating)
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    showDetail.toggle()
                }
            }
        }
        .navigationTitle("Details")
    }
}

struct BookListView: View {
    @Binding var bookList: [Book]
    @State var showDetail: Bool = false
    
    var body: some View {
            List {
                if (!bookList.isEmpty) {
                    ForEach(0..<bookList.count, id: \.self) { index in
                        BookView(title: bookList[index].title, key: bookList[index].imageKey)
                            .swipeActions(edge: .leading) {
                                Button(role: .none) {
                                    bookList.remove(at: index)
                                } label: {
                                    Label("Read", systemImage: "checkmark")
                                }
                                .tint(.green)
                            }
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    bookList.remove(at: index)
                                } label: {
                                    Label("Remove", systemImage: "trash")
                                }
                            }
                            .sheet(isPresented: $showDetail) {
                                DetailView(book: $bookList[index], showDetail: $showDetail)
                            }
                            .onTapGesture {
                                showDetail.toggle()
                            }
                    }
                    .listRowBackground(Color(red: 0.98, green: 0.929, blue: 0.804))
                }
            }
            .listStyle(.carousel)
    }
}

struct SearchView: View {
    @State var search: String = ""
    @State var searchResult: [BookRes] = []
    @State var isLoading: Bool = false
    @Binding var bookList: [Book]
    @Binding var showSearch: Bool
    
    var body: some View {
            List {
                if (isLoading) {
                    ProgressView("Loading")
                } else {
                    ForEach(0..<searchResult.count, id: \.self) { index in
                        SearchItemView(id: searchResult[index].id, title: searchResult[index].title, imageKey: searchResult[index].imageKey ?? "", author: searchResult[index].author ?? [], bookList: $bookList)
                    }
                    .listRowBackground(Color(red: 0.98, green: 0.929, blue: 0.804))
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        search = ""
                        searchResult = []
                        showSearch.toggle()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    TextField("Search with title", text: $search) {
                    }
                    .onSubmit {
                        Task {
                            await searchData()
                        }
                    }
                }
            }
            .listStyle(.carousel)
            .navigationTitle("Search")
            .navigationViewStyle(.stack)
    }
    
    func searchData() async {
        isLoading.toggle()
        guard let url = URL(string: "https://openlibrary.org/search.json?q=\(search.replacingOccurrences(of: " ", with: "+"))") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let search: SearchRes = try! JSONDecoder().decode(SearchRes.self, from: data)
            searchResult = search.docs.filter { book in
                return book.imageKey != nil
            }
            isLoading.toggle()
        } catch {
            print("Invalid data")
        }
    }
}

struct SearchItemView: View {
    let id: String
    let title: String
    let imageKey: String
    let author: [String]
    @Binding var bookList: [Book]
    
    var body: some View {
            HStack {
                AsyncImage(url: URL(string: "https://covers.openlibrary.org/b/olid/\(imageKey)-S.jpg"))  { image in
                    image
                        .resizable()
                        .scaledToFit()
                    } placeholder: {
                        Color.secondary
                    }
                    .frame(width: 25, height: 50, alignment: .leading)
                VStack {
                    Text("\(title)")
                        .font(.custom("Baskerville", size: 14, relativeTo: .headline))
                        .frame(alignment: .leading)
                        .foregroundColor(.black)
                    Text("\(author[0])")
                        .font(.custom("Baskerville", size: 10, relativeTo: .subheadline))
                        .frame(alignment: .leading)
                        .foregroundColor(.black)
                }
                
                if (!bookList.contains(where: { element in
                    if element.id == id {
                        return true
                    } else {
                        return false
                    }
                })) {
                    Button(role: .none) {
                        bookList.append(Book(id: id, title: title, author: author, imageKey: imageKey, status: status.reading))
                        } label: {
                            Image(systemName: "plus")
                        }
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                }
        }
        .padding(1)
        .frame(maxWidth: .infinity)
    }
}

struct BookView: View {
    let title: String
    let key: String
    
    var body: some View {
            HStack {
                AsyncImage(url: URL(string: "https://covers.openlibrary.org/b/olid/\(key)-M.jpg"))  { image in
                    image
                        .resizable()
                        .scaledToFit()
                    } placeholder: {
                        Color.secondary
                    }
                    .frame(width: 50, height: 100, alignment: .leading)
                Text("\(title)")
                    .font(.custom("Baskerville", size: 14, relativeTo: .body))
                    .foregroundColor(.black)
        }
        .padding(1)
        .frame(maxWidth: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
