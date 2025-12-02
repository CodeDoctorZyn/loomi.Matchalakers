//
//  SavedView.swift
//
//
//  Created by Andrew Wang on 2/12/2025.
//

import SwiftUI

struct SavedView: View {
    @State private var currentSearchText = ""
    
    private let posters = [
        "jaws",
        "godfather",
        "batman",
        "venture",
        "avengers"
    ]
    
    var body: some View {
        NavigationStack {
            // TODO: Display the result in a list!
            // Filter using `currentSearchText`!
            // `LazyHGrid` `LazyVGrid`
            ScrollView {
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(minimum: 100, maximum: 200)),
                        GridItem(.flexible(minimum: 100, maximum: 200))
                    ]
                ) {
                    ForEach(0..<21, id: \.self) { _ in
                        // Image("")
                        Rectangle()
                            .fill(Color.blue)
                            .aspectRatio(0.7, contentMode: .fit)
                    }
                }
                .padding(8)
            }
            .navigationTitle("Saved Moies For You")
        }
        .searchable(text: $currentSearchText)
    }
}

#Preview {
    RootTabView()
}
