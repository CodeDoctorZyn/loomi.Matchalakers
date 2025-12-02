//
//  MovieView.swift
//  loomi
//
//  Created by Zayn on 1/12/2025.
//

import SwiftUI

struct MovieView: View {
    
    let movie: Movie
    
    @State private var showAll = false
    
    let columns = [
        GridItem(.adaptive(minimum: 100), spacing: 1)
    ]
    
    
    var body: some View {
        
        VStack(spacing: 10) {
            // top buttons
            HStack(spacing: 60) {
                Image(systemName: "bookmark")
                Image(systemName:
                        "text.bubble.fill")
            }
            .font(.title2)
            
            //movie title, release date, length
            HStack {
                VStack(alignment:.leading) {
                    Text(movie.name)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    Text("\(movie.releasedDate) | \(102) mins")
                }
                
                Spacer()
                
                //recommended age
                ZStack{
                    Circle()
                        .fill(Color.gray) // fill first
                        .frame(width: 60, height: 60)
                        .overlay(
                            Circle().stroke(Color.black, lineWidth: 5) // border on top
                        )
                    Text(movie.suitableAge)
                        .font(.title2)
                }
            }
            
            //genres and popularity
            HStack {
                
            ScrollView(.horizontal, showsIndicators: true) {
                HStack {
                    ForEach(movie.genres, id: \.self) { genre in
                        Text(genre)
                            .padding(8)
                            .background(Color.gray)
                            .cornerRadius(15)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Image(systemName: "hand.thumbsup.fill")
                    Text(movie.popularity)
                }
            }
            
            //poster and trailer
            ZStack {
                Image(movie.posterLandscape)
                    .resizable()
                    .scaledToFill() // fills the frame while maintaining aspect ratio
                    .clipped()
                
                Rectangle()
                    .frame(width: 350, height: 175)
                    .cornerRadius(15)
                    .opacity(0.3)
                
                Image(systemName: "play.circle.fill")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                
                ZStack {
                    Rectangle()
                        .foregroundStyle(.gray)
                        .cornerRadius(10)
                        .frame(width: 39, height: 33)
                    
                    Text(movie.movieAgeRating)
                }
                .frame(maxWidth: 350, maxHeight: 175, alignment: .topTrailing)
                
            }
            .frame(width:350, height: 175)
            .cornerRadius(15)
            .clipped()
            
            //synopsis
            Text(movie.synopsis)
            
            //values
            VStack(alignment: .leading) {
                HStack {
                    Text("Values")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button(action: {
                        // Toggle expanded/collapsed state
                        withAnimation {
                            showAll.toggle()
                        }
                    }) {
                        Text(showAll ? "See less" : "See all >")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                }
                
                // Wrapping values
                LazyVGrid(columns: columns, alignment: .leading, spacing: 2) {
                    ForEach(showAll ? movie.values : Array(movie.values.prefix(3)), id: \.self) { value in
                        Text(value)
                            .padding(8)
                            .background(Color.gray)
                            .cornerRadius(15)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            
            //questions
            ZStack(alignment: .center) {
                Rectangle()
                    .frame(width: 351, height: 110)
                    .foregroundStyle(.gray)
                    .cornerRadius(15)
                
                Text("Hey Beck! Tap here to dive into fun conversation starters for you and your kids after the movie.")
                    .multilineTextAlignment(.center)
                    .fontWeight(.medium)
                    .padding(10)
            }
            
            //user reviews
            VStack(alignment: .leading){
                Text("User Reviews")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding([.leading, .trailing], 25)
    }
}
    

#Preview {
    let sampleMovie = Movie(
        id: 1,
        name: "Inside Out",
        values: ["Empathy", "Resilience", "Compassion", "Kindness", "Honesty"],
        suitableAge: "9+",
        genres: ["Animation", "Adventure", "Comedy"],
        movieAgeRating: "PG",
        length: 102,
        releasedDate: "2015",
        synopsis: "After young Riley is uprooted from her Midwest life and moved to San Francisco, her emotions conflict on how best to navigate a new city, house, and school.",
        posterPortrait: "InsideOut_portrait",
        posterLandscape: "InsideOut_landscape",
        trailerID: "yRUAzGQ3nSY",
        popularity: "95%"
    )
    
    MovieView(movie: sampleMovie)
}
