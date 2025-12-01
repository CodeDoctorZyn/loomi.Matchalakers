//
//  TabView.swift
//
//
//  Created by Andrew Wang on 1/12/2025.
//

import SwiftUI

struct RootTabView: View {
    @State var currentSearchText = ""
    
    let possibleSearchResults = [
        "Placeholder 1",
        "Placeholder 2",
        "Placeholder 3", // Should be your data type! e.g. `Movie(…)`
    ]
    
    // TODO: Array? of data to search through.
    // 1. Define data structure: `struct`
    // 2. Hard code? array of candidate results.
    // 3. Figure out filtering array! `ForEach` to populate grid.
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                HomeView()
            }
            Tab("Review", systemImage: "plus.circle") {
                ReviewView()
            }
            Tab("Saved", systemImage: "bookmark") {
                SavedView()
            }
            Tab(role: .search) {
                NavigationStack {
                    // TODO: Display the result in a list!
                    // Filter using `currentSearchText`!
                    // `LazyHGrid` `LazyVGrid`
                    List {
                        
                        Text(currentSearchText)

                        NavigationLink {
                            Text("Selected: 1")
                        } label: {
                            Text("E.g. 1")
                        }
                        NavigationLink {
                            Text("Selected: 2")
                        } label: {
                            
                            Text("E.g. 2")
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("Search Results")
                }
            }
        }
        .searchable(text: $currentSearchText)
    }
}

#Preview {
    RootTabView()
}
