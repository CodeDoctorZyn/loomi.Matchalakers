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
    private let posters = [
        "jaws",
        "godfather",
        "batman",
        "venture",
        "avengers"
    ]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                header
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
    }

    // MARK: - Header

    private var header: some View {
        HStack {
            Spacer()
            Button {
                print("Profile tapped")
            } label: {
               Image(systemName: "person.crop.circle.fill")
                   .font(.system(size: 22, weight: .semibold))
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
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundStyle(.primary)

            Text("Here are your next suggested picks:")
                .font(.headline)
                .foregroundStyle(.secondary)
                .font(.system(size: 17, weight: .regular, design: .rounded))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Stacked Carousel (overlapping, center on top)

    private var stackedCarousel: some View {
        StackedCarousel(
            items: Array(posters.enumerated()),
            index: $currentIndex,
            cardSize: CGSize(width: UIScreen.main.bounds.width - 230, height:275 ),
            sidePeek: 40,
            sideScale: 1,
            layerSpacing: 20
        ) { pair in
            let (_, name) = pair
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(Color.clear)
                .overlay(
                    Image(name)
                        .resizable()
                        .scaledToFill()
                )
                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                .overlay(
                    LinearGradient(colors: [Color.black.opacity(0.01), Color.black.opacity(0.15)], startPoint: .top, endPoint: .bottom)
                        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                )
        }
        .frame(height: 300)
        .padding(.top, -30)
    }

    // MARK: - Explore

    private var exploreSection: some View {
        VStack(alignment: .leading, spacing: 17) {
            Text("Explore other values to update your suggested picks")
                .font(.title3).bold()
                .foregroundStyle(.primary)

            HStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color(.secondarySystemBackground))
                    .overlay(
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Most selected\nvalue this\nweek")
                                .font(.headline)
                                .foregroundStyle(.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                        }
                        .padding(16)
                    )
                    .frame(height: 120)

                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color(.tertiarySystemFill))
                    .frame(height: 120)
            }

            chipRows
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 4)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: -2)
        )
    }

    private var chipRows: some View {
        VStack(spacing: 12) {
            chipRow(["Adventure", "Cozy", "Award‑winning"])
            chipRow(["Family", "Sci‑Fi", "Drama"])
            chipRow(["Animated", "Classic", "Indie"])
        }
        .padding(.top, 4)
    }

    private func chipRow(_ titles: [String]) -> some View {
        HStack(spacing: 12) {
            ForEach(titles, id: \.self) { title in
                Text(title)
                    .font(.subheadline.weight(.semibold))
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

private struct StackedCarousel<Item: Identifiable, Content: View>: View {
    private let items: [Item]
    @Binding private var index: Int
    private let cardSize: CGSize
    private let sidePeek: CGFloat
    private let sideScale: CGFloat
    private let layerSpacing: CGFloat
    private let content: (Item) -> Content

    // Convenience init for arrays of any Identifiable already provided by generic type

    // Convenience init for enumerated arrays (index, value)
    init<Wrapped>(
        items: [(offset: Int, element: Wrapped)],
        index: Binding<Int>,
        cardSize: CGSize,
        sidePeek: CGFloat = 36,
        sideScale: CGFloat = 0.9,
        layerSpacing: CGFloat = 16,
        @ViewBuilder content: @escaping ((offset: Int, element: Wrapped)) -> Content
    ) where Item == _PairIdentified<Wrapped> {
        self.items = items.map { _PairIdentified(offset: $0.offset, element: $0.element) }
        self._index = index
        self.cardSize = cardSize
        self.sidePeek = sidePeek
        self.sideScale = sideScale
        self.layerSpacing = layerSpacing
        self.content = { pair in content((offset: pair.offset, element: pair.element)) }
    }

    @GestureState private var drag: CGFloat = 0

    var body: some View {
        ZStack {
            ForEach(items.indices, id: \.self) { i in
                let rel = CGFloat(i - index)
                let isCenter = i == index

                let xBase: CGFloat = rel * sidePeek
                let xDrag: CGFloat = drag / 8
                let depth: CGFloat = rel * layerSpacing

                let scale: CGFloat = isCenter ? 1.0 : sideScale
                let y: CGFloat = isCenter ? 0 : 8 // make this CGFloat
//                let z: Double = isCenter ? 3.0 : (rel < 0 ? 2.0 : 1.0)
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
        .frame(maxWidth: .infinity, minHeight: cardSize.height, maxHeight: cardSize.height)
        .contentShape(Rectangle())
        .gesture(
            DragGesture()
                .updating($drag) { value, state, _ in
                    state = value.translation.width
                }
                .onEnded { value in
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

// Helper to make Int identifiable for generic carousel
private struct _IntIdentified: Identifiable {
    let value: Int
    var id: Int { value }
}

private struct _PairIdentified<Wrapped>: Identifiable {
    let offset: Int
    let element: Wrapped
    var id: Int { offset }
}

#Preview {
    HomeView()
}
