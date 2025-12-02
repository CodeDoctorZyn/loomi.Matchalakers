//
//  HomeView.swift
//  loomi
//
//  Created by Zayn on 1/12/2025.
//

import SwiftUI

struct HomeView: View {
    private let userName = "Beck"
    @State private var currentIndex = 2 // Start on card 3 (zero-based index)
    @State private var posters = [
        "jaws",
        "godfather",
        "batman",
        "venture",
        "avengers"
    ]
    
    // Mock metadata for demo purposes
    private let movieMeta: [String: (title: String, values: [String])] = [
        "jaws": ("Jaws", ["Courage", "Resilience", "Teamwork"]),
        "godfather": ("The Godfather", ["Loyalty", "Family", "Power"]),
        "batman": ("The Batman", ["Justice", "Empathy", "Perseverance"]),
        "venture": ("Venture", ["Curiosity", "Bravery", "Kindness"]),
        "avengers": ("Avengers", ["Unity", "Sacrifice", "Hope"])
    ]
    
    // Demo: most selected value this week
    private let mostSelectedValue: String = "Empathy"

    private func meta(for name: String) -> (title: String, values: [String]) {
        movieMeta[name] ?? (name.capitalized, [])
    }

    private func reloadSuggestions() {
        // In a real app, fetch new recommendations here
        posters = [
            "jaws",
            "godfather",
            "batman",
            "venture",
            "avengers"
        ]
        currentIndex = min(currentIndex, max(0, posters.count - 1))
        if posters.indices.contains(currentIndex) == false {
            currentIndex = 0
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
//                    header
                    greeting
                    stackedCarousel
                    exploreSection
                        .padding(.top, 8)
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
            }
            .background(
                LinearGradient(
                    colors: [Color(.systemBackground), Color(.secondarySystemBackground)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        ProfileView()
                    } label: {
                        Image(systemName: "person.crop.circle.fill")
                    }
                }
            }
        }
    }

    // MARK: - Header

     var header: some View {
        HStack {
            Spacer()
            Button {
                print("Profile tapped")
            } label: {
               Image(systemName: "person.crop.circle.fill")
                   .font(.custom("Arial-BoldMT", size: 22))
                   .foregroundStyle(.primary)
                   .padding(10)
                    .background(.ultraThinMaterial, in: Circle())
            }
        }
    }

    // MARK: - Greeting

    private var greeting: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Hi \(userName),")
                .font(.custom("Arial-BoldMT", size: 34))
                .foregroundStyle(.primary)

            Text("Here are your next suggested picks:")
                .font(.custom("Arial", size: 17))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top,-57)
    }

    // MARK: - Stacked Carousel (overlapping, center on top)

    private var stackedCarousel: some View {
        StackedCarousel(
            items: Array(posters.enumerated()),
            index: $currentIndex,
            cardSize: CGSize(width: UIScreen.main.bounds.width - 230, height:275 ),
            sidePeek: 25,
            sideScale: 1,
            layerSpacing: 15,
            reloadAction: reloadSuggestions
        ) { pair in
            let (offset, name) = pair
            let data = meta(for: name)

            ZStack {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color.clear)
                    .overlay(
                        Image(name)
                            .resizable()
                            .scaledToFill()
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                    .overlay(
                        LinearGradient(colors: [Color.black.opacity(0.01), Color.black.opacity(0.22)], startPoint: .top, endPoint: .bottom)
                            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                    )

                // Foreground overlays (only on the selected card)
                VStack {
                    HStack {
                        Text(data.title)
                            .font(.custom("Arial-BoldMT", size: 17))
                            .foregroundStyle(.white)
                            .shadow(color: .black.opacity(0.35), radius: 3, x: 0, y: 1)
                        Spacer()
                        Button {
                            // Remove the current poster and adjust index safely
                            if let removeIndex = posters.firstIndex(of: name) {
                                posters.remove(at: removeIndex)
                                if posters.isEmpty {
                                    currentIndex = 0
                                } else {
                                    currentIndex = min(currentIndex, posters.count - 1)
                                }
                            }
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: "hand.thumbsdown.fill")
                                    .font(.custom("Arial-BoldMT", size: 15))
                            }
                            .foregroundStyle(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(.ultraThinMaterial, in: Capsule())
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(12)

                    Spacer()

                    // Values chips
                    if !data.values.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(data.values, id: \.self) { value in
                                    Text(value)
                                        .font(.custom("Arial-BoldMT", size: 12))
                                        .foregroundStyle(.primary)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                                .fill(Color(.systemBackground).opacity(0.92))
                                        )
                                }
                            }
                            .padding(.horizontal, 15)
                        }
                        .padding(.bottom, 20)
                    }
                }
                .opacity(offset == currentIndex ? 1 : 0) // show only on selected card
                .animation(.easeInOut(duration: 0.2), value: currentIndex)
            }
        }
        .frame(height: 300)
        .padding(.top, -30)
    }

    // MARK: - Explore

    private var exploreSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Explore other values to update your suggested picks")
                .font(.custom("Arial-BoldMT", size: 20))
                .foregroundStyle(.primary)

            // Single card that contains both the label and the highlighted value
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(Color(.secondarySystemBackground))
                .overlay(
                    HStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Most selected\nvalue this week")
                                .font(.custom("Arial-BoldMT", size: 17))
                                .foregroundStyle(.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                        // Highlighted value pill on the right (full height)
                        ZStack {
                            RoundedRectangle(cornerRadius: 28, style: .continuous)
                                .fill(Color(.tertiarySystemFill))
                                .opacity(0.6)
                            RoundedRectangle(cornerRadius: 28, style: .continuous)
                                .inset(by: 3)
                                .fill(Color(.systemBackground))
                                .opacity(0.9)
                            Text(mostSelectedValue)
                                .font(.custom("Arial-BoldMT", size: 16))
                                .foregroundStyle(.primary)
                        }
                        .frame(maxHeight: .infinity)
                        .frame(width: 140)
                    }
                    .padding(16)
                )
                .frame(height: 120)

            chipRows
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 15)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: -2)
        )
    }

    private var chipRows: some View {
        VStack(spacing: 12) {
            chipRow(["Adventure", "Cozy"])
            chipRow(["Family", "Sci‑Fi", "Drama"])
            chipRow(["Animated", "Classic", "Indie"])
        }
        .padding(.top, 4)
    }

    private func chipRow(_ titles: [String]) -> some View {
        HStack(spacing: 12) {
            ForEach(titles, id: \.self) { title in
                Text(title)
                    .font(.custom("Arial-BoldMT", size: 15))
                    .foregroundStyle(.primary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(Color(.tertiarySystemFill))
                    )
            }
            Spacer(minLength: 0)
        }
    }
}

// MARK: - Reusable StackedCarousel (overlapping deck)

// (Removed duplicate StackedCarousel definition; consolidated below)

// Update StackedCarousel to accept reloadAction closure
private struct StackedCarousel<Item: Identifiable, Content: View>: View {
    private let items: [Item]
    @Binding private var index: Int
    private let cardSize: CGSize
    private let sidePeek: CGFloat
    private let sideScale: CGFloat
    private let layerSpacing: CGFloat
    private let content: (Item) -> Content
    private let reloadAction: () -> Void

    // Convenience init for enumerated arrays (index, value)
    init<Wrapped>(
        items: [(offset: Int, element: Wrapped)],
        index: Binding<Int>,
        cardSize: CGSize,
        sidePeek: CGFloat = 36,
        sideScale: CGFloat = 0.9,
        layerSpacing: CGFloat = 16,
        reloadAction: @escaping () -> Void = {},
        @ViewBuilder content: @escaping ((offset: Int, element: Wrapped)) -> Content
    ) where Item == _PairIdentified<Wrapped> {
        self.items = items.map { _PairIdentified(offset: $0.offset, element: $0.element) }
        self._index = index
        self.cardSize = cardSize
        self.sidePeek = sidePeek
        self.sideScale = sideScale
        self.layerSpacing = layerSpacing
        self.reloadAction = reloadAction
        self.content = { pair in content((offset: pair.offset, element: pair.element)) }
    }

    @GestureState private var drag: CGFloat = 0

    var body: some View {
        ZStack {
            if items.isEmpty {
                Button {
                    reloadAction()
                } label: {
                    VStack(spacing: 8) {
                        Image(systemName: "arrow.clockwise")
                            .font(.custom("Arial-BoldMT", size: 22))
                        Text("No more suggestions")
                            .font(.custom("Arial-BoldMT", size: 17))
                        Text("Tap to get more")
                            .font(.custom("Arial", size: 15))
                            .foregroundStyle(.secondary)
                    }
                    .frame(width: cardSize.width, height: cardSize.height)
                    .background(
                        RoundedRectangle(cornerRadius: 28, style: .continuous)
                            .fill(Color(.secondarySystemBackground))
                    )
                }
                .buttonStyle(.plain)
            } else {
                ForEach(items.indices, id: \.self) { i in
                    let rel = CGFloat(i - index)
                    let isCenter = i == index

                    let xBase: CGFloat = rel * sidePeek
                    let xDrag: CGFloat = drag / 8
                    let depth: CGFloat = rel * layerSpacing

                    let scale: CGFloat = isCenter ? 1.0 : sideScale
                    let y: CGFloat = isCenter ? 0 : 8
                    let z: Double = Double(1000 - Int(abs(rel) * 10))
                    let opacity: Double = isCenter ? 1.0 : 0.92
                    let blurRadius: CGFloat = isCenter ? 0 : 2

                    content(items[i])
                        .frame(width: cardSize.width, height: cardSize.height)
                        .shadow(color: .black.opacity(0.08), radius: isCenter ? 18 : 12, x: 0, y: 10)
                        .scaleEffect(scale)
                        .blur(radius: blurRadius)
                        .opacity(opacity)
                        .offset(x: xBase + depth + xDrag, y: y)
                        .zIndex(z)
                }
            }
        }
        .frame(maxWidth: .infinity, minHeight: cardSize.height, maxHeight: cardSize.height)
        .contentShape(Rectangle())
        .gesture(
            DragGesture()
                .updating($drag) { value, state, _ in
                    state = value.translation.width
                }
                .onEnded { value in
                    guard !items.isEmpty else { return }
                    let threshold: CGFloat = 60
                    if value.translation.width < -threshold, index < items.count - 1 {
                        index += 1
                    } else if value.translation.width > threshold, index > 0 {
                        index -= 1
                    }
                }
        )
        .animation(.spring(response: 0.35, dampingFraction: 0.85), value: index)
    }
}

private struct _PairIdentified<Wrapped>: Identifiable {
    let offset: Int
    let element: Wrapped
    var id: Int { offset }
}

#Preview {
    HomeView()
}
