//
//  TabViewAnimationApp.swift
//  TabViewAnimation
//
//  Created by Musk on 9/12/24.
//

import SwiftUI

@main
struct TabViewAnimationApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label("123", image: "")
                    }
                
                ContentView()
                    .tabItem {
                        Label("2312", image: "")
                    }
            }
        }
    }
}
