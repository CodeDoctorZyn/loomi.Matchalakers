//
//  TabView.swift
//
//
//  Created by Andrew Wang on 1/12/2025.
//

import SwiftUI


struct RootTabView: View {
    @State var currentSearchText = ""

    // Lightweight model for search results to avoid name clashes with other Movie types
    struct SearchMovie: Identifiable, Equatable {
        let id = UUID()
        let title: String
        let poster: String
    }

    // Sample data for the search list
    @State private var availableMovies: [SearchMovie] = [
        SearchMovie(title: "Jaws", poster: "jaws"),
        SearchMovie(title: "The Godfather", poster: "godfather"),
        SearchMovie(title: "The Batman", poster: "batman"),
        SearchMovie(title: "Venture", poster: "venture"),
        SearchMovie(title: "The Avengers", poster: "avengers")
    ]

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
        if !availableMovies.isEmpty {
            availableMovies.removeFirst()
        }
    }
}

#Preview {
    RootTabView()
}
