//
//  FeedListViewModel.swift
//  CodeTest
//
//  Created by Aric Brown on 5/15/21.
//

import Combine
import SwiftUI

final class FeedListViewModel: ObservableObject {
    @Published var feedItems = [FeedRowViewModel]()
    @Published var votes: [String] = [] // backed by @U -> see ApolloVote
    
    private let feedApi: FeedAPI
    private let voteApi: VoteAPI
    
    init(feedApi: FeedAPI = ApolloFeed(), voteApi: VoteAPI = ApolloVote()) {
        self.feedApi = feedApi
        self.voteApi = voteApi
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    static func loadedState() -> FeedListViewModel {
        let viewModel = FeedListViewModel(feedApi: TestDoubleFeed())
        return viewModel
    }
}

extension FeedListViewModel {
    func getSortedFeed() {
        feedApi.getFeed()
            .sink(receiveCompletion:{ _ in }, receiveValue: { feed in
                var sorted = feed
                sorted.sort(by: { lhs, rhs in
                    return lhs.votes > rhs.votes
                })
                self.feedItems = sorted.enumerated().map { FeedRowViewModel(index: $0+1, feedEntity: $1) }
            })
            .store(in: &cancellableSet)
    }
    
    func getCachedVotes() {
        voteApi.getVotes()
            .sink(receiveCompletion:{ _ in }, receiveValue: { result in
                self.votes = result
            })
            .store(in: &cancellableSet)
    }
    
    func handleLogoutAction() {
        NotificationCenter.default.post(name: CodeTestApp.logoutEvent, object: nil)
    }
    
    func handleVoteAction(_ id: String) {
        if (!votes.contains(id)) {
            voteApi.upvote(id: id)
                .sink(receiveCompletion:{ _ in }, receiveValue: { result in
                    self.getCachedVotes()
                    self.getSortedFeed()
                })
                .store(in: &cancellableSet)
            
        } else {
            voteApi.downvote(id: id)
                .sink(receiveCompletion:{ _ in }, receiveValue: { result in
                    self.getCachedVotes()
                    self.getSortedFeed()
                })
                .store(in: &cancellableSet)
        }
    }
}
