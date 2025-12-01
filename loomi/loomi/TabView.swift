//
//  TabView.swift
//  
//
//  Created by Andrew Wang on 1/12/2025.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        SwiftUI.TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ReviewView()
                .tabItem {
                    Label("Review", systemImage: "plus.circle")
                }
            
            SavedView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
            
        }
    }
        
    }

#Preview {
    RootTabView()
}
