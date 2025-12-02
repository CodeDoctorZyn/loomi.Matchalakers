//
//  TabView.swift
//
//
//  Created by Andrew Wang on 1/12/2025.
//

import SwiftUI

struct RootTabView: View {
    @State var currentSearchText = ""
    
    private let availableMovies = [
        Movie(title: "Jaws", poster: "jaws"),
        Movie(title: "Jaws", poster: "godfather"),
        Movie(title: "Jaws", poster: "batman"),
        Movie(title: "Jaws", poster: "venture"),
        Movie(title: "Jaws", poster: "avengers"),
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
                    List(availableMovies) { currentMovie in
                        VStack {
                            HStack {
                                Text(currentMovie.title)
                                    .font(.title)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            Image(currentMovie.poster)
                                .resizable()
                                .clipShape(.rect(cornerRadius: 20))
                        }
                        .listRowSeparator(.hidden)
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
