//
//  UniqueDealerHand.h
//  BlackjackApp2
//
//  Created by joshua boverman on 6/28/14.
//  Copyright (c) 2014 joshua boverman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shoe.h"

@interface UniqueDealerHand : NSObject



@property (strong, nonatomic) NSMutableArray * cardsByRank;


@property (strong, nonatomic) NSMutableArray * cards;

//an array of up cards
@property (strong, nonatomic) NSMutableArray * upCards;
// multipliers, eg how many of these hands for each up card
@property (strong, nonatomic) NSMutableArray * multiplier;


// handValue has 8 outcomes - bust, 17, 18, 19, 20,21, bj (ace up) and bj (10 up).
@property NSInteger handValue, outcomeCategory; // cat: 0 (bust), 1 (17), 2 (18), 3 (19), 4 (20), 5 (21), 6 (blackjack)
- (float) oddsWithShoe: (Shoe *) shoe;

@end
