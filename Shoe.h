//
//  Shoe.h
//  BlackjackApp2
//
//  Created by joshua boverman on 6/28/14.
//  Copyright (c) 2014 joshua boverman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shoe : NSObject <NSCoding>



@property  (strong, nonatomic) NSMutableArray *cardsOfGivenRank; //array of cards of any particular rank.


#pragma mark archiving

-(void) encodeWithCoder: (NSCoder *) aCoder;
-(id) initWithCoder: (NSCoder *) aDecoder;
- (Shoe *) copyOfShoe: (Shoe *) shoe;




-(id) initWithDecks:(NSInteger)numDecks;

@end
