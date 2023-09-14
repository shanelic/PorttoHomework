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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
