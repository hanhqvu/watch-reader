//
//  ListCollectionView.swift
//  WatchReader App
//
//  Created by Hanh Vu on 2023/08/23.
//

import SwiftUI

struct ListCollectionView: View {
    let lists = Status.allCases
    @State private var isSearchShown = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(lists, id: \.self) { list in
                    NavigationLink(value: list) {
                        Text(list.rawValue)
                    }
                }
            }
            .navigationTitle("Reading")
            .navigationDestination(for: Status.self) { status in
                BookListView(status: status)
            }
            .toolbar {
                ToolbarItemGroup {
                    HStack {
                        Button {
                            isSearchShown.toggle()
                        } label: {
                            Image(systemName: "plus.magnifyingglass")
                        }
                        
                        Spacer()
                        
                        Button {
                            print("Settings")
                        } label: {
                            Image(systemName: "gearshape")
                        }
                    }
                }
            }
            .sheet(isPresented: $isSearchShown) {
                SearchView(showSearch: $isSearchShown)
            }
        }
    }
}

struct ListCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        ListCollectionView()
    }
}
