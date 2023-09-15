//
//  ContentView.swift
//  PorttoHomework
//
//  Created by Shane Li on 2023/9/12.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var viewModel = MainViewModel()
    @State private var wholeHeight: CGFloat = .zero
    @State private var viewportHeight: CGFloat = .zero
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Here loads \(viewModel.nfts.count) NFTs!")
            Button {
                viewModel.reset()
            } label: {
                Text("Reset NFTs")
            }

            ScrollView {
                VStack {
                    Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                        ForEach(viewModel.nfts.byEach(2)) { row in
                            GridRow {
                                ForEach(row) { item in
                                    ThumbnailView(imageUrl: item.imageUrl ?? "", name: item.name)
                                }
                            }
                        }
                    }
                    if viewModel.isLoadingNFTs {
                        ProgressView()
                    }
                }
                .padding()
                .background {
                    GeometryReader { scrollProxy in
                        Color.clear
                            .preference(key: ScrollOffsetPreferenceKey.self, value: scrollProxy.frame(in: .named("scrollArea")).minY)
                            .preference(key: ContentHeightPreferenceKey.self, value: scrollProxy.frame(in: .named("scrollArea")).height)
                    }
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { minY in
                        let percentage = Int((viewportHeight - minY) / wholeHeight * 10000) / 100
                        if percentage > 102 {
                            viewModel.getNfts()
                        }
                    }
                    .onPreferenceChange(ContentHeightPreferenceKey.self) { height in
                        self.wholeHeight = height
                    }
                }
            }
            .coordinateSpace(name: "scrollArea")
            .background {
                GeometryReader { proxy in
                    Color.clear.onAppear {
                        viewportHeight = proxy.size.height
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Array {
    func byEach(_ num: Int) -> Array<Array<Element>> {
        var temp: [[Element]] = []
        for (index, element) in self.enumerated() {
            if (temp.count - 1) < (index / num) {
                temp.append([])
            }
            temp[index / num].append(element)
        }
        return temp
    }
}

extension Array: Identifiable where Element: Hashable {
    public var id: Self { self }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ContentHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
