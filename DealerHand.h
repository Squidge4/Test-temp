//
//  DealerHand.h
//  BlackjackApp2
//
//  Created by joshua boverman on 6/28/14.
//  Copyright (c) 2014 joshua boverman. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "shoe.h"

@interface DealerHand : NSObject


@property (strong, nonatomic)  NSMutableArray *cards;  //  a string of NSNumbers (= card rank)
@property  (strong, nonatomic) NSMutableArray *cardsByRank; // index 0 is all the cards; indexes 1 - 10 are cards of rank
@property   NSInteger value,valueAceLow;


-(void) addAce;
- (void) removeLastCard;
- (BOOL) indexLastCard;
- (id) init;
- (void) handFromCards: (NSArray *) c;
- (float) probabilityWithShoe: (Shoe *) shoe;
-(id) initWithCopyOf:(DealerHand *) d;


@end

