//
//  DetailView.swift
//  WatchReader WatchKit Extension
//
//  Created by Hanh Vu on 2022/08/26.
//

import SwiftUI

struct DetailView: View {
    @State var book: Book
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://covers.openlibrary.org/b/olid/\(book.imageKey!)-L.jpg"))  { image in
                    image
                        .resizable()
                        .scaledToFit()
                    } placeholder: {
                        ProgressView()
                            .frame(width: 60, height: 120, alignment: .leading)
                    }
                    .frame(maxWidth: 60, maxHeight: 120, alignment: .leading)
                Text(book.title!)
                    .font(.custom("Baskerville", size: 20, relativeTo: .headline))
                    .frame(alignment: .leading)
                ForEach(book.authorArray, id: \.self) { author in
                    //force unwrap as name is a required attributes
                    Text(author.name!)
                }
                .font(.custom("Baskerville", size: 16, relativeTo: .subheadline))
                RatingView(rating: $book.ratingInt)
            }
        }
    }
}
