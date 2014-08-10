//
//  NewPlayerHand.h
//  makeDealerCalcFile
//
//  Created by joshua boverman on 7/6/14.
//  Copyright (c) 2014 none. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "shoe.h"

@interface NewPlayerHand : NSObject <NSCoding>


@property (strong, nonatomic)  NSMutableArray *cards;  //  a string of NSNumbers (= card rank)
@property  (strong, nonatomic) NSMutableArray *cardsByRank; // index 0 is not used; indexes 1 - 10 are cards of rank
@property   NSInteger value,valueAceLow;


-(void) addAce;
- (void) removeLastCard;
- (BOOL) indexLastCard;
- (id) init;
- (void) handFromCards: (NSArray *) c;
- (float) probabilityWithShoe: (Shoe *) shoe;
-(id) initWithCopyOf:(NewPlayerHand *) d;


-(void) encodeWithCoder: (NSCoder *) aCoder;
-(id) initWithCoder: (NSCoder *) aDecoder;

@end

