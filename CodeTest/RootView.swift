//
//  RootView.swift
//  CodeTest
//
//  Created by Aric Brown on 5/19/21.
//

import SwiftUI
import KeychainSwift

struct RootView: View {
    @EnvironmentObject var appState: AppState
    let keychainSwift = KeychainSwift()
    
    let cancellable = NotificationCenter.default
        .publisher(for: CodeTestApp.authenticatedEvent)
        .sink { result in
            print(result)
        }
    
    var body: some View {
        ZStack{
            if (appState.token.isEmpty) {
                SignupView().environmentObject(appState)
            } else {
                FeedItemList().environmentObject(appState)
            }
        }
        .onReceive(NotificationCenter.default
                    .publisher(for: CodeTestApp.authenticatedEvent)) { _ in
            self.appState.token = KeychainSwift().get(CodeTestApp.tokenKey) ?? ""
            self.appState.userId = KeychainSwift().get(CodeTestApp.userIdKey) ?? ""
        }
        .onReceive(NotificationCenter.default
                    .publisher(for: CodeTestApp.logoutEvent)) { _ in
            keychainSwift.delete(CodeTestApp.tokenKey)
            keychainSwift.delete(CodeTestApp.userIdKey)
            self.appState.token = ""
            self.appState.userId = ""
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
