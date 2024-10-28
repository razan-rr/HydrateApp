//
//  HydrateAppApp.swift
//  HydrateApp
//
//  Created by Razan on 25/04/1446 AH.
//

import SwiftUI

@main
struct HydrateApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(WaterIntakeModel())
        }
    }
}
