//
//  BookItemView.swift
//  WatchReader WatchKit Extension
//
//  Created by Hanh Vu on 2022/08/26.
//

import SwiftUI

struct BookItemView: View {
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

struct BookItemView_Previews: PreviewProvider {
    static var previews: some View {
        BookItemView(title: "Testing", key: "")
    }
}
