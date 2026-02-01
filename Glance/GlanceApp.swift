//
//  GlanceApp.swift
//  Glance
//
//  Created by Geoff Storbeck on 2/1/26.
//

import SwiftUI

@main
struct GlanceApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
