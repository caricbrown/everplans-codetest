//
//  FeedEntity.swift
//  CodeTest
//
//  Created by Aric Brown on 5/18/21.
//

import Foundation

struct FeedEntity {
    let id: String
    let url: String
    let feedDescription: String
    let votes: Int
    let createdAt: Date
    let postedBy: String
    
    init(id: String, url: String, feedDescription: String, votes: Int, createdAt: String, postedBy: String) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let createdAtDate = dateFormatter.date(from: createdAt)
        
        self.id = id
        self.url = url
        self.feedDescription = feedDescription
        self.votes = votes
        self.createdAt = createdAtDate!
        self.postedBy = postedBy
    }
}
