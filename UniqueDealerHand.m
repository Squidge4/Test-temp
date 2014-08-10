//
//  UniqueDealerHand.m
//  BlackjackApp2
//
//  Created by joshua boverman on 6/28/14.
//  Copyright (c) 2014 joshua boverman. All rights reserved.
//

#import "UniqueDealerHand.h"

@implementation UniqueDealerHand


@synthesize cardsByRank, cards, upCards, multiplier, handValue, outcomeCategory;

- (float) oddsWithShoe: (Shoe *) shoe {
    
    float o=1;
    int i,j;
    
    for (i = 1; i <=10; i++) {
        if ([self.cardsByRank[i] longValue] <= [shoe.cardsOfGivenRank[i] longValue]) {
            for (j = 1; j <= [self.cardsByRank[i] longValue]; j++) {
                o *= [shoe.cardsOfGivenRank[i] longValue] -j+1;
            }
        } else {
            o = 0;
            break;
        }
    }
    for (j = 0; j < [self.cardsByRank[0] longValue]; j++) {
            o /= ([shoe.cardsOfGivenRank[0] longValue]-j);
        }
    
    return o;
}


@end
