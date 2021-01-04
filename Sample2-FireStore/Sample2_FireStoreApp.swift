//
//  Sample2_FireStoreApp.swift
//  Sample2-FireStore
//
//  Created by keiji yamaki on 2021/01/04.
//

import SwiftUI
import UIKit
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    print("FireStoreアプリの。ApplicationDelegate didFinishLaunchingWithOptions.")
    return true
  }
}

@main
struct Sample2_FireStoreApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
      FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
