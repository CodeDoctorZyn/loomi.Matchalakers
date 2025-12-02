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
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .toolbar {
                    ToolbarItem {
                        Button {
                            
                        } label: {
                            Image(systemName: "person.crop.circle.fill")
                        }
                        
                    }
                }
        }
    }
}

#Preview {
    RootTabView()
}
