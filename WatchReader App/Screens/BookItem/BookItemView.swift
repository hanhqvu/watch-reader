//
//  BookItemView.swift
//  WatchReader WatchKit Extension
//
//  Created by Hanh Vu on 2022/08/26.
//

import SwiftUI

struct BookItemView: View {
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://covers.openlibrary.org/b/olid/\(book.imageKey ?? "")-M.jpg"))  { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.secondary
            }
            .cornerRadius(5)
            .frame(width: 50, height: 100, alignment: .leading)
            
            ZStack {
                Text(book.title!)
                    .font(.custom("Baskerville", size: 14, relativeTo: .body))
                    .rotation3DEffect(.degrees(frontDegree), axis: (x: 1, y: 0, z: 0))
                
                VStack {
                    Text("Progress: \(book.progress, specifier: "%.0f")%")
                    
                    HStack {
                        Text("Rating: \(book.ratingInt ?? 0)")
                        Image(systemName: "star.fill")
                            .foregroundColor(Color.yellow)
                    }
                    
                }
                .rotation3DEffect(.degrees(backDegree), axis: (x: 1, y: 0, z: 0))
            }
            
        }
        .padding(1)
        .frame(maxWidth: .infinity)
        .onTapGesture {
            flipCard ()
        }
    }
}
