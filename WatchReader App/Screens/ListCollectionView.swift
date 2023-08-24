//
//  ListCollectionView.swift
//  WatchReader App
//
//  Created by Hanh Vu on 2023/08/23.
//

import SwiftUI

struct ListCollectionView: View {
    let lists = Status.allCases
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(lists, id: \.self) { list in
                    Text(list.rawValue)
                }
            }
            .navigationTitle("Reading")
            .toolbar {
                ToolbarItemGroup {
                    HStack {
                        Button {
                            print("Add")
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
        }
    }
}

struct ListCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        ListCollectionView()
    }
}
