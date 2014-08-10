//
//  DealerOutcome.h
//  BlackjackApp2
//
//  Created by joshua boverman on 6/28/14.
//  Copyright (c) 2014 joshua boverman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UniqueDealerHand.h"
#import "DealerHand.h"
#import "UniqueDealerHand.h"



float dO[11][8];

@interface DealerOutcome : NSObject <NSCoding>

//@property (strong, nonatomic) NSArray *allDealerHAnds;

@property (strong, nonatomic) NSArray *uC;


// initializes the dictionary of possibles



-(NSArray *) makeAllDealerHands;

-(void) makeAllUniqueDealerHandsWith: (NSArray *) allHands;

// gives an 11X7 array with all potential dealer outcomes
-(void)dealerOutcomesWithShoe: (Shoe *) shoe;

- (float) oddsWithShoe:(Shoe *) shoe andArray: (NSArray *) uniqueElement;

- (float) oddsWithShoe:(Shoe *) shoe andPlayerCardsByRank: (NSArray *) playerCardsByRank andArray: (NSArray *) uniqueElement;


-(void) dealerOutcomesWithShoe:(Shoe *) shoe andPlayerCardsByRank: (NSArray *) playerCardsByRank;

- (NSArray *) returnWithPlayerHandValue: (NSInteger) val ;


-(void) encodeWithCoder: (NSCoder *) aCoder;
-(id) initWithCoder: (NSCoder *) aDecoder;


@end
