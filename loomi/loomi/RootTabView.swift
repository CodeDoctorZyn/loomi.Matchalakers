//
//  TabView.swift
//
//
//  Created by Andrew Wang on 1/12/2025.
//

import SwiftUI


struct RootTabView: View {
    @State var currentSearchText = ""
    
    @State private var availableMovies: [Movie] = []
    
    func loadMovies() {
        availableMovies = MovieDataManager.loadMovies()
    }
    
    var filteredMovies: [Movie] {
        if currentSearchText.isEmpty {
            return availableMovies
        } else {
            return availableMovies.filter { movie in
                movie.name.lowercased().contains(currentSearchText.lowercased())
            }
        }
    }
    
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
                    List(filteredMovies) { currentMovie in
                        VStack {
                            HStack {
                                
                                Text(currentMovie.name)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            Image(currentMovie.posterLandscape)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 370, height: 240)
                                .clipShape(.rect(cornerRadius: 20))
                        }
                        .listRowSeparator(.hidden)
                    }
                    .onAppear{
                        loadMovies()
                    }
                    .toolbar {
                        ToolbarItem {
                            Button {
                                // TODO: implement filter for search
//                                filterSearch()
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
}

#Preview {
    RootTabView()
}
