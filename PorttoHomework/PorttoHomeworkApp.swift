//
//  PorttoHomeworkApp.swift
//  PorttoHomework
//
//  Created by Shane Li on 2023/9/12.
//

import SwiftUI
import SDWebImageSVGCoder

@main
struct PorttoHomeworkApp: App {
    init() {
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
