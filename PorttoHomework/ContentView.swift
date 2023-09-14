//
//  ContentView.swift
//  PorttoHomework
//
//  Created by Shane Li on 2023/9/12.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var viewModel = MainViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                    ForEach(viewModel.nfts.byEach(2)) { row in
                        GridRow {
                            ForEach(row) { item in
                                ThumbnailView(imageUrl: item.imageUrl ?? "", name: item.name)
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
