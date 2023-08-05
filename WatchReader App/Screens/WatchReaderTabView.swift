//
//  WatchReaderTabView.swift
//  WatchReader App
//
//  Created by Hanh Vu on 2023/08/06.
//

import SwiftUI

struct WatchReaderTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                ArchivedListView()
                    .tabItem {
                        Label("Read", systemImage: "archivebox.fill")
                    }
            }
            NavigationStack {
                CurrentListView()
                    .tabItem {
                        Label("Read", systemImage: "book.fill")
                    }
            }
        }.tabViewStyle(.page)
    }
}

struct WatchReaderTabView_Previews: PreviewProvider {
    static var previews: some View {
        WatchReaderTabView()
    }
}
