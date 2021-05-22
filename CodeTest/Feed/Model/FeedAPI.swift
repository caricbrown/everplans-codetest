//
//  FeedAPI.swift
//  CodeTest
//
//  Created by Aric Brown on 5/15/21.
//

import Combine

protocol FeedAPI {
    func getFeed() -> AnyPublisher<[FeedEntity], Never>
}
