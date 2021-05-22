//
//  ApolloFeed.swift
//  CodeTest
//
//  Created by Aric Brown on 5/18/21.
//

import Foundation
import Combine
import Apollo

final class ApolloFeed: FeedAPI {
    func getFeed() -> AnyPublisher<[FeedEntity], Never> {
        return Deferred {
            Future<[FeedEntity], Never> { promise in
                Network.shared.apollo.fetch(query: FeedQuery(), cachePolicy: .fetchIgnoringCacheData) { result in
                    
                    guard let data: FeedQuery.Data = try? result.get().data else { return }

                    let feed = data.feed.map {
                        FeedEntity(id: $0.id, url: $0.url, feedDescription: $0.description, votes: $0.votes, createdAt: $0.createdAt!, postedBy: $0.postedBy!.name)
                    }
                
                    promise(.success(feed))
                }
            }
        }
        // By default, Apollo will deliver query results on the main thread...
        .eraseToAnyPublisher()
    }
}
