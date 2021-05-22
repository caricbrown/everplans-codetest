//
//  CodeTestApp.swift
//  CodeTest
//
//  Created by Aric Brown on 5/15/21.
//

import SwiftUI
import KeychainSwift

@main
struct CodeTestApp: App {
    let appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            RootView().environmentObject(appState)
        }
    }
}

extension CodeTestApp {
    static let tokenKey = "token"
    static let userIdKey = "userId"
    static let authenticatedEvent = Notification.Name("com.codetest.authenticated")
    static let logoutEvent = Notification.Name("com.codetest.logout")
    static let createPostEvent = Notification.Name("com.codetest.createPost")
}

class AppState: ObservableObject {
    @Published var token : String = KeychainSwift().get(CodeTestApp.tokenKey) ?? ""
    @Published var userId : String = KeychainSwift().get(CodeTestApp.userIdKey) ?? ""
}

