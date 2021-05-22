//
//  FeedRowViewModel.swift
//  CodeTest
//
//  Created by Aric Brown on 5/15/21.
//

import Foundation

struct FeedRowViewModel: Identifiable {
    let index: Int
    let id: String
    let title: String
    let subtitle: String
    let footer: String
    
    init(index: Int, feedEntity: FeedEntity) {
        let relativeDateTimeFormatter = RelativeDateTimeFormatter()
        relativeDateTimeFormatter.dateTimeStyle = .named
        
        let createdAtFormattedDate = relativeDateTimeFormatter.localizedString(for: feedEntity.createdAt, relativeTo: Date())
                                  
        self.index = index
        self.id = feedEntity.id
        self.title = feedEntity.feedDescription
        self.subtitle = feedEntity.url
        self.footer = "\(feedEntity.votes) votes by \(feedEntity.postedBy) \(createdAtFormattedDate)"
    }
}
