//
//  SearchItemView.swift
//  WatchReader WatchKit Extension
//
//  Created by Hanh Vu on 2022/08/26.
//

import SwiftUI

struct SearchItemView: View {
    @State var bookRes: BookRes
    @Binding var bookList: [Book]
    
    var body: some View {
            HStack {
                AsyncImage(url: URL(string: "https://covers.openlibrary.org/b/olid/\(bookRes.imageKey ?? "")-S.jpg"))  { image in
                    image
                        .resizable()
                        .scaledToFit()
                    } placeholder: {
                        Color.secondary
                    }
                    .frame(width: 25, height: 50, alignment: .leading)
                VStack {
                    Text("\(bookRes.title)")
                        .font(.custom("Baskerville", size: 14, relativeTo: .headline))
                        .frame(alignment: .leading)
                        .foregroundColor(.black)
                    Text("\(bookRes.author?[0] ?? "")")
                        .font(.custom("Baskerville", size: 10, relativeTo: .subheadline))
                        .frame(alignment: .leading)
                        .foregroundColor(.black)
                }
                
                if (!bookList.contains(where: { element in
                    if element.id == bookRes.id {
                        return true
                    } else {
                        return false
                    }
                })) {
                    Button(role: .none) {
                        bookList.append(Book(id: bookRes.id, title: bookRes.title, author: bookRes.author ?? [], imageKey: bookRes.imageKey ?? "", status: Status.reading))
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
