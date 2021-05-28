//
//  FeedRow.swift
//  CodeTest
//
//  Created by Aric Brown on 5/15/21.
//

import SwiftUI

struct FeedItemRow: View {
    var feedItem: FeedRowViewModel
    
    @State var selected: Bool
    var voteAction: ((_ isSelected: Bool) -> Void)?
    
    @State private var showCheckmark = false
    
    var body: some View {
        HStack {
            Text(String(feedItem.index))
                .font(.system(size: 20.0, weight: .bold))
                .frame(width: 50, height: 50)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
            
            VStack(alignment: .leading) {
                Text(feedItem.title)
                    .font(.system(size: 16, weight: .bold))
                    .lineLimit(1)
                Text(feedItem.subtitle)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color("secondaryTextColor")).lineLimit(1)
                footerText
            }
            
            Spacer()
            
            ZStack{
                if (showCheckmark) {
                    Image("checkmark")
                        .padding()
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                }
                Button(action: handleVoteAction) {
                    if (!showCheckmark) {
                        if (selected) {
                            Image("greenThumb")
                                .padding()
                                .transition(.asymmetric(insertion: .scale, removal: .opacity))
                        } else {
                            Image("grayThumb")
                                .padding()
                                .transition(.asymmetric(insertion: .scale, removal: .opacity))
                        }
                    }
                }
            }.frame(width: 50, height: 50)
            
        }
    }
}

extension FeedItemRow {
    private var footerText: some View {
        HStack {
            if (selected) {
                Text(feedItem.votes).modifier(GreenBoldFooterTextStyle())
                    .padding(.trailing, -5)
            } else {
                Text(feedItem.votes).modifier(GrayFooterTextStyle())
                    .padding(.trailing, -5)
            }
            Text(feedItem.footer).modifier(GrayFooterTextStyle())
        }
    }
    
    func handleVoteAction() {
        
        withAnimation {
            selected.toggle()
            showCheckmark.toggle()
        }
        
        if (self.voteAction != nil) {
            self.voteAction!(self.selected)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) {
            withAnimation {
                showCheckmark.toggle()
            }
        }
    }
}

struct FeedItemRow_Previews: PreviewProvider {
    static var previews: some View {
        let feedEntity = FeedEntity(id: "1", url: "http://www.supercali1234567890.com.edu", feedDescription: "Some long description", votes: 99, createdAt: "2021-05-15T19:52:03.163Z", postedBy: "alice")
        let feedItem = FeedRowViewModel(index: 999, feedEntity: feedEntity)
        
        FeedItemRow(feedItem: feedItem, selected: false).previewLayout(.sizeThatFits)
        FeedItemRow(feedItem: feedItem, selected: true).previewLayout(.sizeThatFits)
    }
}
