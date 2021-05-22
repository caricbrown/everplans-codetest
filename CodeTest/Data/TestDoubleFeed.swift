//
//  TestDoubleFeed.swift
//  CodeTest
//
//  Created by Aric Brown on 5/15/21.
//

import Foundation
import Combine

final class TestDoubleFeed: FeedAPI {
    let jsonString = """
        {
          "data": {
            "feed": [
              {
                "id": "1",
                "url": "https://giphy.com/gifs/computer-cat-wearing-glasses-VbnUQpnihPSIgIXuZv",
                "description": "Professor Cat",
                "votes": 20,
                "createdAt": "2021-05-15T19:52:02.978Z",
                "postedBy": {
                  "name": "alice"
                }
              },
              {
                "id": "2",
                "url": "https://giphy.com/gifs/reddit-doing-lJNoBCvQYp7nq",
                "description": "I have no idea what i am doing",
                "votes": 0,
                "createdAt": "2021-05-15T19:52:02.982Z",
                "postedBy": {
                  "name": "alice"
                }
              },
              {
                "id": "3",
                "url": "https://giphy.com/gifs/facepalm-yFQ0ywscgobJK",
                "description": "Sleepy Cat",
                "votes": 0,
                "createdAt": "2021-05-15T19:52:03.030Z",
                "postedBy": {
                  "name": "steve"
                }
              },
              {
                "id": "4",
                "url": "https://giphy.com/gifs/hallmarkecards-cute-hallmark-shoebox-BzyTuYCmvSORqs1ABM",
                "description": "I have the power!",
                "votes": 203,
                "createdAt": "2021-05-15T19:52:03.038Z",
                "postedBy": {
                  "name": "alice"
                }
              },
              {
                "id": "5",
                "url": "https://giphy.com/gifs/wiggle-shaq-13CoXDiaCcCoyk",
                "description": "Shaq Wiggle",
                "votes": 0,
                "createdAt": "2021-05-15T19:52:03.043Z",
                "postedBy": {
                  "name": "alice"
                }
              },
              {
                "id": "6",
                "url": "https://giphy.com/gifs/badass-boye-kiBcwEXegBTACmVOnE",
                "description": "I can drive!",
                "votes": 23993,
                "createdAt": "2021-05-15T19:52:03.091Z",
                "postedBy": {
                  "name": "steve"
                }
              },
              {
                "id": "7",
                "url": "https://giphy.com/gifs/happiness-9fuvOqZ8tbZOU",
                "description": "Sleepy puppy",
                "votes": 20,
                "createdAt": "2021-05-15T19:52:03.097Z",
                "postedBy": {
                  "name": "steve"
                }
              },
              {
                "id": "8",
                "url": "https://giphy.com/gifs/reaction-mood-gGeyr3WepujbGn7khx",
                "description": "Nope DOg",
                "votes": 290,
                "createdAt": "2021-05-15T19:52:03.103Z",
                "postedBy": {
                  "name": "alice"
                }
              },
              {
                "id": "9",
                "url": "https://giphy.com/gifs/cute-aww-eyebleach-2bUqez1VlOCInOZLTp",
                "description": "Struggle is real",
                "votes": 0,
                "createdAt": "2021-05-15T19:52:03.150Z",
                "postedBy": {
                  "name": "alice"
                }
              },
              {
                "id": "10",
                "url": "https://giphy.com/gifs/doge-shibe-54Vj1kxvgyF4k",
                "description": "Too much doge",
                "votes": 0,
                "createdAt": "2021-05-15T19:52:03.157Z",
                "postedBy": {
                  "name": "steve"
                }
              },
              {
                "id": "11",
                "url": "https://giphy.com/gifs/cat-kitten-gato-VIPdgcooFJHtC",
                "description": "Dis one mine",
                "votes": 3920,
                "createdAt": "2021-05-15T19:52:03.163Z",
                "postedBy": {
                  "name": "alice"
                }
              }
            ]
          }
        }
    """
    
    func getFeed() -> AnyPublisher<[FeedEntity], Never> {
        let jsonData = jsonString.data(using: .utf8)!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        let feedResponse = (try? decoder.decode(FeedResponse.self, from: jsonData)) ?? FeedResponse(data: FeedDataClass(feed: []))
        
        let feed = feedResponse.data.feed.map {
            FeedEntity(id: $0.id, url: $0.url, feedDescription: $0.feedDescription, votes: $0.votes, createdAt: $0.createdAt, postedBy: $0.postedBy.name)
        }
        
        return Just<[FeedEntity]>(feed)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
