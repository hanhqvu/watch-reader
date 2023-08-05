//
//  SearchItemView.swift
//  WatchReader WatchKit Extension
//
//  Created by Hanh Vu on 2022/08/26.
//

import SwiftUI

struct SearchItemView: View {
    @Binding var bookRes: BookRes
    
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
            
            switch (bookRes.listStatus) {
            case .added:
                Image(systemName: "tray.circle")
                    .padding()
                    .foregroundColor(.green)
                    .imageScale(.large)
            case .pending:
                Image(systemName: "minus.circle")
                    .padding()
                    .foregroundColor(.red)
                    .imageScale(.large)
            case .none:
                Image(systemName: "plus.circle")
                    .padding()
                    .foregroundColor(.blue)
                    .imageScale(.large)
            }
            
        }
        .padding(1)
        .frame(maxWidth: .infinity)
        .onTapGesture {
            switch (bookRes.listStatus) {
            case .added: return
            case .pending:
                bookRes.listStatus = .none
            case .none:
                bookRes.listStatus = .pending
            }
        }
    }
}
