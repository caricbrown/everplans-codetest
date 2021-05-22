//
//  FeedItemList.swift
//  CodeTest
//
//  Created by Aric Brown on 5/15/21.
//

import SwiftUI
import Foundation

struct FeedItemList: View {
    @ObservedObject var viewModel = FeedListViewModel()
    @StateObject var bottomSheetState = BottomSheetState() // This works here for now, although I think ideally a bottom sheet state would be handled globally.
    
    let cancellable = NotificationCenter.default
        .publisher(for: CodeTestApp.createPostEvent)
        .sink { result in
            print(result)
        }
    
    init(viewModel: FeedListViewModel = .init()) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    List {
                        ForEach(self.viewModel.feedItems) {feedItem in
                            FeedItemRow(feedItem: feedItem, selected: viewModel.votes.contains(feedItem.id), voteAction: { viewModel.handleVoteAction(feedItem.id) })
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                    FloatingActionButton(action: {
                        self.bottomSheetState.isOpen.toggle()
                    })
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button("Refresh") {
//                            viewModel.getSortedFeed()
//                        }
//                    }
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("Feed").font(.system(size: 30, weight: .semibold))
                            Spacer()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Log Out") {
                            viewModel.handleLogoutAction()
                        }
                    }
                }
                .onAppear(perform: {
                    viewModel.getSortedFeed()
                    viewModel.getCachedVotes()
                })
            }
            .navigationBarColor(backgroundColor: .white, tintColor: Color.greenColor)
            BottomSheetModal {
                CreatePost()
            }.environmentObject(bottomSheetState)
        }
        .onReceive(NotificationCenter.default
                    .publisher(for: CodeTestApp.createPostEvent)) { _ in
            bottomSheetState.isOpen.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                viewModel.getSortedFeed()
            }
        }
    }
}

struct FeedItemList_Previews: PreviewProvider {
    static var previews: some View {
        FeedItemList(viewModel: FeedListViewModel.loadedState())
    }
}
