//
//  TabView.swift
//
//
//  Created by Andrew Wang on 1/12/2025.
//

import SwiftUI

struct RootTabView: View {
    @State var currentSearchText = ""
    
    @State private var availableMovies = [
        Movie(title: "Jaws", poster: "jaws"),
        Movie(title: "The Godfather", poster: "godfather"),
        Movie(title: "The Batman", poster: "batman"),
        Movie(title: "Venture", poster: "venture"),
        Movie(title: "The Avengers", poster: "avengers"),
    ]
    
    // TODO: Array? of data to search through.
    // 1. Define data structure: `struct`
    // 2. Hard code? array of candidate results.
    // 3. Figure out filtering array! `ForEach` to populate grid.
    
    @State var x: Int = 0
    
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
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            Image(currentMovie.poster)
                                .resizable()
                                .frame(width: 370, height: 240)
                                .clipShape(.rect(cornerRadius: 20))
                        }
                        .listRowSeparator(.hidden)
                    }
                    .toolbar {
                        ToolbarItem {
                            Button {
                                // TODO: implement filter for search
                                filterSearch()
                            } label: {
                                Image(systemName: "line.3.horizontal.decrease")
                            }
                            
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("Search Results")
                    .searchable(text: $currentSearchText, placement: .toolbar)
                }

            }
            
        }

    }
    
    /// This is a mock filter
    func filterSearch() {
        availableMovies.remove(at: 0)
    }
}

#Preview {
    RootTabView()
}
